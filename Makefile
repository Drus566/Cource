build:
	bundle update
	bundle install
	yarn install --check-files
	rails webpacker:install

run:
	bundle exec foreman start
	
test:
	bundle exec rspec
