NAME=go-make
PROJECT=github.com/username/$(NAME)
GOOS=linux
GOARCH=amd64

init:
	@printf "\033[36;1m§\033[0m Implementing \033[36;1mGolang\033[0m template for '\033[36;1m$(NAME)\033[0m' as '\033[36;1m$(PROJECT)\033[0m'.\n"
	@printf "\033[37;1m»\033[0m Generating simple project structure...\n"
	@mkdir bin package
	@printf "package main\n\nfunc main() {\n\n}\n" >> main.go
	@printf "\033[32;1m»\033[0m Generated all files\n"

	@printf "\n\033[37;1m»\033[0m Initializing go.mod for '\033[36;1m$(PROJECT)\033[0m'...\n"
	@go mod init $(PROJECT)
	@printf "\033[32;1m»\033[0m Initialized '$(PROJECT)'\n"

	@printf "\n\033[37;1m»\033[0m Initializing git repository...\n"
	@git init
	@git checkout -b main
	@printf "\033[32;1m»\033[0m Initialized (*main)\n"

run:
	go run main.go

build:
	go build -o bin/ $(PROJECT)
	./bin/$(NAME)

start:
	./bin/$(NAME)

compile:
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o bin/$(NAME)-$(GOOS)-$(GOARCH) main.go

clean:
	@printf "\033[37;1m»\033[0m Cleaning Golang cached packages...\n"
	@printf "\033[32;1m»\033[0m Cleaned\n"
	@go clean -modcache

tidy:
	go mod tidy

publish:
	GOPROXY=proxy.golang.org go list -m $(PROJECT)

purge:
	@printf "\033[37;1m»\033[0m Purging everything (except Makefile)...\n"
	@find * ! -name 'Makefile' -type d -exec rm -rf {} +
	@find . ! -name 'Makefile' -type f -exec rm -f {} +
	@rm -rf .git/
	@printf "\033[32;1m»\033[0m Purged\n"