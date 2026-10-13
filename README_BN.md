# FreeAI Studio — Cloudflare + Supabase starter

এটি মোবাইল-ফ্রেন্ডলি, সম্প্রসারণযোগ্য starter। বর্তমান AI Director লোকাল নিয়মভিত্তিক পরিকল্পনা তৈরি করে; এটি পূর্ণ AI model, video, voice cloning বা music generation নয়।

## ফোল্ডার
- `index.html` — frontend
- `functions/api/health.js` — backend health endpoint
- `functions/api/director.js` — AI Director request validation endpoint
- `supabase/schema.sql` — পরবর্তী ধাপে cloud project table ও row-level security

## মোবাইল দিয়ে Cloudflare Pages deploy
1. ZIP extract করুন।
2. GitHub-এ নতুন **Public** repository বানান, যেমন `freeai-studio-cloud`.
3. Extract করা ফোল্ডারের **ভেতরের সব ফাইল ও functions ফোল্ডার** repository root-এ upload করুন; ZIP ফাইলটি একা upload করবেন না।
4. Cloudflare dashboard-এ লগইন করুন → Workers & Pages → Create → Pages → Connect to Git.
5. GitHub repository নির্বাচন করুন। Framework preset: `None`; Build command ফাঁকা; Build output directory: `/` (বা Cloudflare UI-তে static root হিসেবে যে মান নির্দেশ করে)। Save and Deploy করুন।
6. deploy হলে `https://<project-name>.pages.dev` ঠিকানা পাওয়া যাবে।
7. সাইটে Backend পরীক্ষা করুন চাপুন। `/api/health`-এ `ok: true` এলে Pages Function চলছে।

## Supabase (পরবর্তী ধাপ)
1. Supabase-এ নতুন project তৈরি করুন।
2. SQL Editor-এ `supabase/schema.sql`-এর SQL চালান।
3. এই schema শুধু projects table এবং RLS তৈরি করে; এটি এখনও frontend login/cloud save-এর সঙ্গে সংযুক্ত নয়।
4. `service_role` key কখনও browser code-এ দেবেন না। পরবর্তী সংযোগে Supabase anon/publishable key ও RLS ব্যবহার করতে হবে।

## গুরুত্বপূর্ণ নিরাপত্তা ও খরচ
- GitHub public repo-তে কোনো secret/API key commit করবেন না।
- Cloudflare ও Supabase-এর free quota/terms পরিবর্তিত হতে পারে।
- API key browser-এ না রেখে Cloudflare Pages > Settings > Variables and Secrets-এ server-side secret হিসেবে রাখুন।
- AI provider সংযোগ না করা পর্যন্ত API endpoint শুধু request যাচাই করে; আসল AI generation করে না।
- Voice cloning কেবল কণ্ঠের মালিকের স্পষ্ট অনুমতি নিয়ে করতে হবে।
