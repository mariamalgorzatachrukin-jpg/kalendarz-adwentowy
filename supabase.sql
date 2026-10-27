-- Uruchom w Supabase: SQL Editor -> New query -> wklej całość -> Run.
-- Schemat startowy. RLS jest włączone; aplikacja nie udostępnia danych anonimowo.
create extension if not exists pgcrypto;

create table if not exists public.students (
  id uuid primary key default gen_random_uuid(),
  access_code text unique not null,
  display_name text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  day_number integer unique not null check (day_number between 1 and 22),
  title text not null,
  prompt text not null,
  variants jsonb not null default '[]'::jsonb,
  opens_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.submissions (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  task_id uuid not null references public.tasks(id) on delete cascade,
  variant_index integer not null default 0,
  answer text,
  photo_path text,
  status text not null default 'Wysłano' check (status in ('Wysłano','Poprawna','Błędna','Do poprawy')),
  teacher_comment text,
  submitted_at timestamptz not null default now(),
  reviewed_at timestamptz,
  unique(student_id, task_id)
);

alter table public.students enable row level security;
alter table public.tasks enable row level security;
alter table public.submissions enable row level security;

-- Celowo nie dodajemy polityk anon. Bezpieczny dostęp uczniów i nauczyciela
-- wymaga serwerowego punktu dostępu/weryfikacji kodu, który skonfigurujemy dalej.
-- Nie wklejaj nigdy klucza service_role do strony internetowej.

insert into public.tasks(day_number, title, prompt, variants)
values
(1, 'Mikołajowe dodawanie', 'Oblicz działanie z wariantu przydzielonego przez nauczyciela.', '[{"question":"248 + 137 = ?","answer":"385"},{"question":"356 + 228 = ?","answer":"584"},{"question":"417 + 165 = ?","answer":"582"}]'),
(2, 'Renifery odejmują', 'Rozwiąż zadanie z treści wyświetlonej po zalogowaniu.', '[{"question":"Z 640 prezentów rozdano 275. Ile zostało?","answer":"365"},{"question":"Z 725 prezentów rozdano 348. Ile zostało?","answer":"377"},{"question":"Z 900 prezentów rozdano 456. Ile zostało?","answer":"444"}]'),
(3, 'Świąteczne mnożenie', 'Rozwiąż działanie z przydzielonego wariantu.', '[{"question":"7 × 8 = ?","answer":"56"},{"question":"6 × 9 = ?","answer":"54"},{"question":"8 × 4 = ?","answer":"32"}]')
on conflict (day_number) do nothing;

-- Storage: bucket "prace-uczniow" powinien pozostać prywatny.
