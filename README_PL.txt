MATEMATYCZNY KALENDARZ ADWENTOWY — PAKIET STARTOWY

W środku:
- szkic strony w świątecznym stylu,
- połączenie Supabase przez zmienne środowiskowe,
- supabase.sql do utworzenia tabel,
- instrukcja dalszego uruchomienia.

WAŻNE:
To nie jest jeszcze gotowa strona dla dzieci. Logowanie kodami, wysyłanie zdjęć,
blokada jednej próby, przydzielanie wariantów i panel nauczyciela wymagają
bezpiecznego backendu/funkcji serwerowych i polityk dostępu. Nie udostępniaj
anonimowo tabel uczniów ani zdjęć. Nigdy nie umieszczaj klucza Secret/service_role
w kodzie przeglądarkowym.

NAJPROSTSZY NASTĘPNY KROK:
1. Utwórz konto w usłudze do hostowania kodu (np. GitHub) i środowisko uruchomieniowe,
   albo użyj lokalnie Node.js.
2. Skopiuj .env.example do .env.local i wpisz URL oraz Publishable key.
3. W Supabase SQL Editor uruchom supabase.sql.
4. Przed prawdziwym użyciem dodaj backend do weryfikacji kodów oraz polityki RLS.
