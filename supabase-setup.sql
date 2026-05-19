-- ════════════════════════════════════════════════════════════════════════════
--  SUPABASE SETUP SCRIPT FOR ZAHRA'S BIRTHDAY MESSAGE BOARD
--  Run this in your Supabase SQL Editor
-- ════════════════════════════════════════════════════════════════════════════

-- 1. CREATE THE MESSAGES TABLE
create table if not exists messages (
  id bigint primary key generated always as identity,
  name text,
  message text not null,
  is_anon boolean default false,
  created_at timestamp with time zone default now()
);

-- 2. CREATE INDEX FOR BETTER QUERY PERFORMANCE
create index if not exists idx_messages_created_at 
  on messages(created_at desc);

-- 3. ENABLE ROW LEVEL SECURITY (RLS)
alter table messages enable row level security;

-- 4. CREATE RLS POLICY - ALLOW ANYONE TO READ MESSAGES
create policy "Allow public read access"
  on messages for select
  using (true);

-- 5. CREATE RLS POLICY - ALLOW ANYONE TO INSERT MESSAGES
create policy "Allow public insert access"
  on messages for insert
  with check (true);

-- ════════════════════════════════════════════════════════════════════════════
--  DONE! Your messages table is ready to use.
--  The index improves performance when loading messages.
--  RLS policies allow anyone to read and submit messages anonymously.
-- ════════════════════════════════════════════════════════════════════════════
