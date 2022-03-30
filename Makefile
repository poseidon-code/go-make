NAME=go-make
GITHUB_USERNAME=poseidon-code
PROJECT=github.com/$(GITHUB_USERNAME)/$(NAME)
VERSION=v0.1.0

init:
	@go mod init $(PROJECT)
	@printf "\033[32;1m█\033[0m Initialized '$(PROJECT)'\n"
	@git init
	@git checkout -b main
	@printf "\033[32;1m█\033[0m Initialized Git repository (*main)\n"


build:
	@printf "\033[37;1m█\033[0m Building '$(PROJECT)'...\n"
	go build -o ./bin/ $(PROJECT)
	@printf "\033[32;1m█\033[0m Built at 'bin/$(NAME)'\n"


compile:
	@printf "\033[37;1m█\033[0m Compiling for linux, windows, macos with x64 architecture...\n"
	GOOS=linux GOARCH=amd64 go build -o ./dist/$(NAME)-linux-amd64 $(PROJECT)
	GOOS=windows GOARCH=amd64 go build -o ./dist/$(NAME)-windows-amd64.exe $(PROJECT)
	GOOS=darwin GOARCH=amd64 go build -o ./dist/$(NAME)-darwin-amd64 $(PROJECT)
	@printf "\033[32;1m█\033[0m Compiled to 'dist/'\n"


tidy:
	@go clean -modcache
	@printf "\033[32;1m█\033[0m Cleaned Go cached packages\n"
	@go get -t -u ./...
	@printf "\033[32;1m█\033[0m Updated package dependencies\n"
	@go mod tidy
	@printf "\033[32;1m█\033[0m Tidied Up\n"


publish:
	@git tag $(VERSION)
	@git push origin $(VERSION)
	@GOPROXY=proxy.golang.org go list -m $(PROJECT)@$(VERSION)
