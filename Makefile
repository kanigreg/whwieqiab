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

# Make sure you have run ssh-agent before running deploy commands
# ---
#   ssh-add -l
# ---
# unless run agent and add key
# ---
#   eval $(ssh-agent)
#   ssh-add ~/.ssh/id_of_deployment_private_key
# ---
deploy:
	bws run --project-id ${BWS_PROJECT_QUERY_FLOW} -- kamal deploy

deploy-setup:
	bws run --project-id ${BWS_PROJECT_QUERY_FLOW} -- kamal setup
