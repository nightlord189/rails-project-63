install:
	bundle install

lint:
	bundle exec rubocop

.PHONY: test
test:
	bundle exec rake test