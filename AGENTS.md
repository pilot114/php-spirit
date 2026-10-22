# php-spirit

Отчёт по 1000 самым скачиваемым пакетам packagist: собирает их `composer.json` и считает, какие поля,
зависимости и лицензии встречаются чаще. Результат — `serve/report.json` и страница `serve/index.html`.

## Как устроено

- `bin/build.php` — четыре шага: список популярных → `composer.json` каждого (GitHub API, GitLab API,
  packagist) → агрегаты `tmp/composer_cache.json` → `serve/report.json`.
- `src/functions.php` — всё остальное, включая класс `Report`.
- `tmp/` — промежуточный кеш, в git не хранится. Уже скачанные пакеты при повторном запуске пропускаются,
  так что первый прогон долгий, следующие — быстрые.

## Грабли

- Для GitHub API нужен `GITHUB_TOKEN` (без него упрётся в лимит 60 запросов в час); `make build` берёт
  токен из `gh auth token`.
- PSR-17 фабрики даёт сам `guzzlehttp/psr7` — пакет `http-interop/http-factory-guzzle` не нужен и держал
  psr7 на 2.x.

## Команды

Цели Makefile одинаковые во всех проектах `~/projects` (`make help` — список):

- `make install` — поставить зависимости
- `make dev` — запустить для разработки
- `make test` — тесты
- `make lint` — статический анализ
- `make build` — сборка
- `make audit` — уязвимости в зависимостях
- `make outdated` — устаревшие зависимости
