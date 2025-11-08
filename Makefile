# Docker image and container names
IMAGE_NAME = ollama-custom
CONTAINER_NAME = ollama-container
PORT = 11434

# Build and run the Docker container
all:
	@echo "Building Docker image..."
	docker build -t $(IMAGE_NAME) .
	@echo "Running Docker container..."
	docker run -d --name $(CONTAINER_NAME) -p $(PORT):$(PORT) -v ollama:/root/.ollama $(IMAGE_NAME)
	@echo "Ollama is running on port $(PORT)"
	@echo "Container name: $(CONTAINER_NAME)"

# Clean up Docker resources
fclean:
	@echo "Stopping and removing container..."
	-docker stop $(CONTAINER_NAME) 2>/dev/null || true
	-docker rm $(CONTAINER_NAME) 2>/dev/null || true
	@echo "Removing Docker image..."
	-docker rmi $(IMAGE_NAME) 2>/dev/null || true
	@echo "Removing Docker volume..."
	-docker volume rm ollama 2>/dev/null || true
	@echo "Cleanup complete"

.PHONY: all fclean
