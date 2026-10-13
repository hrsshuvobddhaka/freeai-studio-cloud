-- Run in Supabase Dashboard > SQL Editor only when ready to add cloud accounts.
-- This creates private per-user projects. Do not disable RLS.
create extension if not exists pgcrypto;

create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null default 'Untitled project',
  project_type text not null default 'ai_director',
  content jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.projects enable row level security;

create policy "Users can read their own projects"
on public.projects for select
using (auth.uid() = user_id);

create policy "Users can create their own projects"
on public.projects for insert
with check (auth.uid() = user_id);

create policy "Users can update their own projects"
on public.projects for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create policy "Users can delete their own projects"
on public.projects for delete
using (auth.uid() = user_id);
