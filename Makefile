IMAGE_NAME = package-fetcher
OUTPUT_DIR = $(PWD)/out

all: build run

build:
	docker build -t $(IMAGE_NAME) .

run:
	mkdir -p $(OUTPUT_DIR)
	docker run --rm -v $(OUTPUT_DIR):/output $(IMAGE_NAME)

clean:
	rm -rf $(OUTPUT_DIR)

purge: clean
	docker rmi -f $(IMAGE_NAME) || true

.PHONY: all build run clean purge
