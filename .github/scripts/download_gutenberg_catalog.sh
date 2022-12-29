#!/bin/env bash

echo Downloading catalog CSV
curl https://www.gutenberg.org/cache/epub/feeds/pg_catalog.csv --output pg_catalog.csv

echo Creating sqlite db
sqlite3 books.db ".mode csv" ".import pg_catalog.csv books" ".exit"
