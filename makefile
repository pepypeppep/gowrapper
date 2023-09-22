run:
	go run main.go

migration:
	migrate create -ext sql -dir database/migrations/ -seq $(name)s
	touch database/queries/$(name)s.sql
	touch controller/$(name).go
	for filename in database/migrations/*_$(name)s.down.sql; do echo "DROP TABLE $(name)s;" > $$filename; done;
	for filename in database/migrations/*_$(name)s.up.sql; do echo "CREATE TABLE $(name)s (\n\n);" > $$filename; done;
	for filename in database/queries/$(name)s.sql; do echo "\
	-- name: List$(name) :many\nSELECT * FROM $(name)s;\n\n\
	-- name: Get$(name) :one\nSELECT * FROM $(name)s WHERE id = ?;\n\n\
	-- name: Create$(name) :execresult\nINSERT INTO $(name)s () VALUES (?);\n\n\
	-- name: Update$(name) :exec\nUPDATE $(name)s SET column=? WHERE id = ?;\n\n\
	-- name: Delete$(name) :exec\nDELETE FROM $(name)s WHERE id = ?;" > $$filename; done;

loop:
	for filename in database/migrations/*down.sql; do echo "DROP TABLE $(name);" > $$filename; done;
	for filename in database/migrations/*down.sql; do echo "CREATE TABLE $(name) ();" > $$filename; done;

migrate:
	go run database/migrate.go

sqlc:
	sqlc generate

module:
	curl https://raw.githubusercontent.com/pepypeppep/gowrapper/main/script.sh -nc - --output ./script.sh
	@bash ./script.sh $(name)
	rm script.sh

module2: 
	mkdir -p modules
	mkdir -p modules/$(name)/controller
	mkdir -p modules/$(name)/model
	mkdir -p modules/$(name)/repository
	touch modules/$(name)/controller/$(name).go
	touch modules/$(name)/model/$(name).go
	touch modules/$(name)/repository/$(name).go
	touch modules/$(name)/routes.go
	echo "package controller" > modules/$(name)/controller/$(name).go
	echo "package model" > modules/$(name)/model/$(name).go
	echo "package repository" > modules/$(name)/repository/$(name).go
	echo "package $(name)" > modules/$(name)/routes.go