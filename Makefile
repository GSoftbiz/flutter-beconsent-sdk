run dev: ## Run application
	@flutter run --flavor dev -t lib/main_dev.dart

.PHONY: all test clean
test: ## Run flutter test with coverage
	@flutter test --coverage

gen: ## Run code generator
	@flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

clean: ## Clean build
	@flutter clean

get: ## Gets all the dependencies listed in the pubspec.yaml
	@flutter pub get

doctor: ## Ensure any dependencies you need to install to complete the setup
	@flutter doctor -v

.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)