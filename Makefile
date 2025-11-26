setup:
	bundle install
	docker compose up -d postgres
	bin/rails db:drop db:create db:migrate

start:
	docker compose up -d
	[[ -e tmp/pids/server.pid ]] || bundle exec rails server -d -b 0.0.0.0 -p 3000

stop:
	docker compose down
	cat tmp/pids/server.pid | xargs kill

restart: stop start
