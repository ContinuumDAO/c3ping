#!/bin/bash

# Single output file for all scripts
OUTPUT_FILE="helpers/read-outbox/outbox.log"

# Clear the output file and add header
echo "=== C3Ping Read-Outbox Scripts Output ===" > "$OUTPUT_FILE"
echo "Generated on: $(date)" >> "$OUTPUT_FILE"
echo "========================================" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Function to run a script and capture its output
run_and_capture() {
    local script_name=$1
    
    echo "Running $script_name and capturing output to $OUTPUT_FILE..."
    
    # Add section header to the output file
    echo "=== Output of $script_name ===" >> "$OUTPUT_FILE"
    echo "Timestamp: $(date)" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    # Run the script and capture both stdout and stderr
    if ./helpers/read-outbox/$script_name.sh >> "$OUTPUT_FILE" 2>&1; then
        echo "✓ $script_name completed successfully"
    else
        echo "✗ $script_name failed (check $OUTPUT_FILE for details)"
    fi
    
    echo "" >> "$OUTPUT_FILE"
    echo "=== End of $script_name output ===" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "----------------------------------------" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
}

# Run each script and capture output
run_and_capture "arbitrum-sepolia"
run_and_capture "bsc-testnet"
run_and_capture "sepolia"
run_and_capture "base-sepolia"
run_and_capture "scroll-sepolia"
run_and_capture "avalanche-fuji"
run_and_capture "opbnb-testnet"
run_and_capture "holesky"
run_and_capture "soneium-minato-testnet"

# Add footer to the output file
echo "=== All Scripts Completed ===" >> "$OUTPUT_FILE"
echo "End time: $(date)" >> "$OUTPUT_FILE"
echo "Total output size: $(du -h "$OUTPUT_FILE" | cut -f1)" >> "$OUTPUT_FILE"

echo "All scripts completed. All output has been captured to: $OUTPUT_FILE"
echo "Output file size: $(du -h "$OUTPUT_FILE" | cut -f1)"