-- Carnet de Tyrie : à coller dans Supabase > SQL Editor, puis « Run ».
-- Remplace les deux adresses e-mail ci-dessous par les vôtres avant de lancer.

create table if not exists public.carnet (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.carnet enable row level security;

-- Seuls vos deux comptes peuvent lire et modifier le carnet.
create policy "carnet lecture" on public.carnet for select to authenticated
  using ((auth.jwt() ->> 'email') in ('TON_EMAIL@exemple.fr', 'EMAIL_ELODIE@exemple.fr'));
create policy "carnet ajout" on public.carnet for insert to authenticated
  with check ((auth.jwt() ->> 'email') in ('TON_EMAIL@exemple.fr', 'EMAIL_ELODIE@exemple.fr'));
create policy "carnet modif" on public.carnet for update to authenticated
  using ((auth.jwt() ->> 'email') in ('TON_EMAIL@exemple.fr', 'EMAIL_ELODIE@exemple.fr'))
  with check ((auth.jwt() ->> 'email') in ('TON_EMAIL@exemple.fr', 'EMAIL_ELODIE@exemple.fr'));

-- Mises à jour en direct entre vos deux navigateurs.
alter publication supabase_realtime add table public.carnet;

-- Vos objectifs actuels, repris de la version Claude.
insert into public.carnet (id, data) values ('state', '{"v":2,"players":{"a":"Nymos","b":"Jeff"},"lists":{"carnet":[],"a":[{"id":"ezugzzj","title":"sdvdsbsdbs","desc":"","achs":[{"id":4692,"m":{"a":false}}],"tasks":[],"done":{"a":false}},{"id":"oj0yv46","title":"un nouvel ami","desc":"","achs":[{"id":7225,"m":{"a":false}}],"tasks":[],"done":{"a":false}}],"b":[{"id":"mqajsbq","title":"sdfsd","desc":"","achs":[{"id":1730,"m":{"b":false}}],"tasks":[],"done":{"b":false}},{"id":"032g8ny","title":"fdsfsdfsdfd","desc":"","achs":[{"id":9003,"m":{"b":false}}],"tasks":[],"done":{"b":false}},{"id":"4s7bjlp","title":"Finir l''histoire de Path Of Fire","desc":"La faire a 100","achs":[{"id":3900,"m":{"b":false}}],"tasks":[],"done":{"b":false}}]}}'::jsonb)
on conflict (id) do nothing;
