NAME=go-make
PROJECT=github.com/username/$(NAME)
MAIN=main.golang


init:
	@printf "\033[36;1m§\033[0m Implementing \033[36;1mGolang\033[0m template for '\033[36;1m$(NAME)\033[0m' as '\033[36;1m$(PROJECT)\033[0m'.\n"
	@printf "\033[37;1m»\033[0m Generating simple project structure...\n"
	@mkdir bin dist package
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
	@printf "\033[37;1m»\033[0m Running program '$(MAIN)'...\n"
	@go run $(MAIN)
	@printf "\033[32;1m»\033[0m Program '$(MAIN)' exited\n"



build:
	@printf "\033[37;1m»\033[0m Building '$(PROJECT)'...\n"
	go build -o bin/ $(PROJECT)
	@printf "\033[32;1m»\033[0m Built at 'bin/$(NAME)'\n\n"

	@printf "\033[37;1m»\033[0m Running program '$(NAME)'...\n"
	@./bin/$(NAME)
	@printf "\033[32;1m»\033[0m Program '$(NAME)' exited\n"



start:
	@printf "\033[37;1m»\033[0m Running program '$(NAME)'...\n"
	@./bin/$(NAME)
	@printf "\033[32;1m»\033[0m Program '$(NAME)' exited\n"


compile:
	@printf "\033[37;1m»\033[0m Compiling for linux, windows, macos with x64 & x86 architecture...\n"
	GOOS=linux GOARCH=amd64 go build -o dist/$(NAME)-linux-amd64 $(MAIN)
	GOOS=linux GOARCH=386 go build -o dist/$(NAME)-linux-386 $(MAIN)
	GOOS=windows GOARCH=amd64 go build -o dist/$(NAME)-windows-amd64 $(MAIN)
	GOOS=windows GOARCH=386 go build -o dist/$(NAME)-windows-386 $(MAIN)
	GOOS=darwin GOARCH=amd64 go build -o dist/$(NAME)-darwin-amd64 $(MAIN)
	@printf "\033[32;1m»\033[0m Compiled to 'dist/'\n"


clean:
	@printf "\033[37;1m»\033[0m Cleaning Golang cached packages...\n"
	@go clean -modcache
	@printf "\033[32;1m»\033[0m Cleaned\n"


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