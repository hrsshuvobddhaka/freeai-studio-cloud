-- Existing table থাকলে আগে schema/policies মিলিয়ে দেখো।
create table if not exists public.projects(id uuid primary key default gen_random_uuid(),user_id uuid not null references auth.users(id) on delete cascade,title text not null,project_type text not null default 'storyboard',content jsonb not null default '{}'::jsonb,created_at timestamptz not null default now(),updated_at timestamptz not null default now());
alter table public.projects enable row level security;
grant select,insert,update,delete on public.projects to authenticated;
drop policy if exists "Users can read their own projects" on public.projects;
create policy "Users can read their own projects" on public.projects for select to authenticated using(auth.uid()=user_id);
drop policy if exists "Users can create their own projects" on public.projects;
create policy "Users can create their own projects" on public.projects for insert to authenticated with check(auth.uid()=user_id);
drop policy if exists "Users can update their own projects" on public.projects;
create policy "Users can update their own projects" on public.projects for update to authenticated using(auth.uid()=user_id) with check(auth.uid()=user_id);
drop policy if exists "Users can delete their own projects" on public.projects;
create policy "Users can delete their own projects" on public.projects for delete to authenticated using(auth.uid()=user_id);
