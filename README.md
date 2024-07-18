# Test assignment description, completed according to specs
## Setup
For running mysql, redis, web and webhook containers run
* docker-compose up --build -d
on dev environment run
* rails db:migrate
* sidekiq
to run tests run
* rspec

## Features
Templates collecting "webhook" is hosted via webhook docker container
at "http://127.0.0.1:9902/note_templates/templates.json"

## AS Description
* Filtering logic includes query objects
* Fetching templates, unfified error messages embrace service objects
* DRY (filtering queries) and dependency injection (webhook logic) principles usage

## FS Description
* Backround processing is using good pracices - idempotency, usage of max threads, processes scaling, logging
* REST API good practices - unified messaging format, resource naming conventions, layering
* DB design uses STI for storing fetched pieces of data as templates for notes.
* Backround processing emulates the situation, where there are tons of records to fetch and perform in batches, with
* retry to fallback queues. Errors handling same as info that can be queued ( by logs or any logic) is saved
* to sidekiq status records.
* Tests are covering all crud endpoints with successful and failure contexts, using json matchers, faker, factory bot
* Webhook test mock is added , that can be reused by unit tests.

## Gems Used Additionally
* Sidekiq Status plugin
* Whenever cron schedule
* Faraday http client
* Kaminari for pagination
* AMSerializer
* JSON expectations RSpec matcher
* Webmock external http requests mock for RSpec

## Versions
* Rails version
7.0.8
* Ruby version
3.2.1
* MySQL version
8.0.35
