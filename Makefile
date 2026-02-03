IMAGE_NAME = pip-offline-downloader
OUTPUT_DIR = $(PWD)/out
PLATFORM = linux/amd64  

all: build run

build:
	docker build --platform $(PLATFORM) -t $(IMAGE_NAME) .

run:
	mkdir -p $(OUTPUT_DIR)
	docker run --platform $(PLATFORM) --rm -v $(OUTPUT_DIR):/output $(IMAGE_NAME)

clean:
	rm -rf $(OUTPUT_DIR)

purge: clean
	docker rmi -f $(IMAGE_NAME) || true

.PHONY: all build run clean purge