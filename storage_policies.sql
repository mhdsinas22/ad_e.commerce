-- Enable RLS on storage.objects if not already enabled
alter table storage.objects enable row level security;

-- Create the profile_images bucket if it doesn't exist (this is usually done in UI, but good to have)
insert into storage.buckets (id, name, public)
values ('profile_images', 'profile_images', false)
on conflict (id) do nothing;

-- Policy to allow authenticated users to view their own profile image
-- Replaces any existing policy for SELECT
drop policy if exists "Users can view their own profile image" on storage.objects;
create policy "Users can view their own profile image"
on storage.objects for select
to authenticated
using (
  bucket_id = 'profile_images'
  and (storage.foldername(name))[1] = (
    select username from public.profiles where user_id = auth.uid()
  )
);

-- Policy to allow authenticated users to upload their own profile image
-- Replaces any existing policy for INSERT
drop policy if exists "Users can upload their own profile image" on storage.objects;
create policy "Users can upload their own profile image"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'profile_images'
  and (storage.foldername(name))[1] = (
    select username from public.profiles where user_id = auth.uid()
  )
);

-- Policy to allow authenticated users to update their own profile image
-- Replaces any existing policy for UPDATE
drop policy if exists "Users can update their own profile image" on storage.objects;
create policy "Users can update their own profile image"
on storage.objects for update
to authenticated
using (
  bucket_id = 'profile_images'
  and (storage.foldername(name))[1] = (
    select username from public.profiles where user_id = auth.uid()
  )
);

-- Policy to allow authenticated users to delete their own profile image
-- Replaces any existing policy for DELETE
drop policy if exists "Users can delete their own profile image" on storage.objects;
create policy "Users can delete their own profile image"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'profile_images'
  and (storage.foldername(name))[1] = (
    select username from public.profiles where user_id = auth.uid()
  )
);
