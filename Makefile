export GOFLAGS := -mod=vendor
export GOPROXY := off

.PHONY: all
all: bin/wave

bin/wave: $(shell find . -type f -name '*.go')
	go build -o bin/wave ./cmd/wave

.PHONY: clean
clean:
	rm -rf bin

# Check that given variables are set and all have non-empty values,
# die with an error otherwise.
#
# Params:
#   1. Variable name(s) to test.
#   2. (optional) Error message to print.
check_defined = \
	$(strip $(foreach 1,$1, \
		$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
	$(if $(value $1),, \
		$(error Undefined $1$(if $2, ($2))))

.PHONY: release
release:
	@:$(call check_defined, GITHUB_TOKEN)
	docker run -e GITHUB_TOKEN=$(GITHUB_TOKEN) --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v $(PWD):/workdir -w /workdir mailchain/goreleaser-xcgo goreleaser --rm-dist
