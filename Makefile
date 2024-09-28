install:
	bundle install

lint:
	rubocop

.PHONY: test
test:
	rake test