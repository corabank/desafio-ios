gen:
	@echo "Generating resources..."
# Create Generated directory if it doesn't exists
	@mkdir -p Sources/Generated
# Generate images, colors and strings with swiftgen
	@swiftgen
# Generate project file wih xcodegen
	@echo "Generating project..."
	@xcodegen
	@echo "Generation completed."