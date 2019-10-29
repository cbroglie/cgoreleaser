.PHONY: all
all: bin/wave

bin/wave: $(shell find . -type f -name '*.go')
	go build -o bin/wave ./cmd/wave

.PHONY: clean
clean:
	rm -rf bin

