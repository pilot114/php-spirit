# php-spirit: статистический отчёт по 1000 популярным пакетам packagist
# Цели одинаковые во всех проектах ~/projects — см. make help.
.DEFAULT_GOAL := help

.PHONY: help
help: ## эта справка
	@grep -hE '^[a-zA-Z0-9_-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-12s %s\n", $$1, $$2}'

.PHONY: install
install: ## поставить зависимости
	composer install

.PHONY: dev
dev: ## запустить для разработки
	php -S 127.0.0.1:8080 -t serve

.PHONY: build
build: ## сборка
	GITHUB_TOKEN=$$(gh auth token) php bin/build.php

.PHONY: audit
audit: ## уязвимости в зависимостях
	composer audit

.PHONY: outdated
outdated: ## устаревшие зависимости
	composer outdated --direct
