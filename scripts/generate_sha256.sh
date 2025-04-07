#!/bin/bash

# This script generates the SHA256 hash for the Homebrew formula
# Usage: ./scripts/generate_sha256.sh <version>

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: ./scripts/generate_sha256.sh <version>"
  exit 1
fi

URL="https://github.com/yourusername/cli-phonetic-alphabet/archive/refs/tags/v${VERSION}.tar.gz"
echo "Downloading ${URL}..."
curl -L "${URL}" -o "cli-phonetic-alphabet-${VERSION}.tar.gz"

echo "Generating SHA256 hash..."
SHA256=$(shasum -a 256 "cli-phonetic-alphabet-${VERSION}.tar.gz" | cut -d ' ' -f 1)

echo "SHA256 hash: ${SHA256}"
echo "Replace the sha256 line in cli-phonetic-alphabet.rb with:"
echo "sha256 \"${SHA256}\""

# Clean up
rm "cli-phonetic-alphabet-${VERSION}.tar.gz" 