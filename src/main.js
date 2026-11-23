import { createClient } from '@supabase/supabase-js';
import './style.css';

const url = import.meta.env.VITE_SUPABASE_URL;
const key = import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY;
const configured = Boolean(url && key && !url.includes('TWOJ-PROJEKT') && !key.includes('wklej_tutaj'));
const supabase = configured ? createClient(url, key) : null;

document.querySelector('#app').innerHTML = `
  <main class="shell">
    <header class="hero">
      <div class="eyebrow">🎄 MATEMATYCZNA PRZYGODA</div>
      <h1>Kalendarz adwentowy</h1>
      <p>Klasa 4 • Odkrywaj, licz i rozwiązuj świąteczne zagadki!</p>
    </header>
    <section class="panel" id="login-panel">
      <h2>Wejdź do kalendarza</h2>
      <p class="muted">Wpisz swój kod ucznia otrzymany od nauczyciela.</p>
      <form id="login-form">
        <label for="code">Kod ucznia</label>
        <input id="code" autocomplete="off" required maxlength="32" placeholder="Np. RENIFER-07" />
        <button type="submit">Otwórz kalendarz ✨</button>
      </form>
      <p class="notice" id="message">${configured
        ? 'Połączenie z projektem skonfigurowane. Dostęp uczniów włączymy po skonfigurowaniu bezpiecznej weryfikacji kodów.'
        : 'To wersja startowa. Najpierw ustawimy połączenie z Supabase i zabezpieczenia.'}</p>
    </section>
    <section class="panel hidden" id="calendar-panel">
      <div class="welcome"><div><h2 id="welcome-title">Witaj!</h2><p class="muted">Wybierz okienko kalendarza.</p></div><button class="secondary" id="logout">Wyloguj</button></div>
      <div class="grid" id="days"></div>
      <div id="task-area"></div>
    </section>
    <footer>⭐ Licz samodzielnie • Powodzenia!</footer>
  </main>
`;

const form = document.querySelector('#login-form');
form.addEventListener('submit', async (event) => {
  event.preventDefault();
  const message = document.querySelector('#message');
  const code = document.querySelector('#code').value.trim();
  if (!configured) {
    message.textContent = 'Najpierw trzeba skonfigurować połączenie z bazą. Ten ekran nie zapisuje jeszcze odpowiedzi uczniów.';
    return;
  }
  // Do not query students directly with an anonymous code. A server-side
  // verification endpoint is required before real student access is enabled.
  message.textContent = 'Połączenie jest ustawione, ale logowanie kodem wymaga jeszcze bezpiecznej funkcji serwerowej. Nie wpisuj prawdziwych danych uczniów do testów.';
});
