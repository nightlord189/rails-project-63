install:
	bundle install

lint:
	bundle exec rubocop

lint-fix:
	bundle exec rubocop --auto-correct-all

.PHONY: test
test:
	bundle exec rake test