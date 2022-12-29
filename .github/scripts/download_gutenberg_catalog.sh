#!/bin/env bash

echo Downloading catalog CSV
curl https://www.gutenberg.org/cache/epub/feeds/pg_catalog.csv --output pg_catalog.csv

echo Creating sqlite db
sqlite3 books.db ".mode csv" ".import pg_catalog.csv books" ".exit"

echo verifying that db was created successfully
sqlite3 books.db "select * from books limit 10;" ".exit"
[ $? -eq 0 ] && echo "success" || exit 1 