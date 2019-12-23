build:
	bundle install
	yarn install --check-files
	rails webpacker:install

run:
	bundle exec foreman start
	
test:
	RAILS_ENV=test bundle exec rspec --fail-fast
