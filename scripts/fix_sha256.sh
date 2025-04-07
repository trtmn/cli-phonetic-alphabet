#!/bin/bash

# This script fixes the SHA256 hash in the Homebrew formula
# Usage: ./scripts/fix_sha256.sh <version>

set -e  # Exit on error

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: ./scripts/fix_sha256.sh <version>"
  echo "Example: ./scripts/fix_sha256.sh 0.1.1"
  exit 1
fi

# Check if we're in the right directory
if [ ! -f "pyproject.toml" ]; then
  echo "Error: This script must be run from the root directory of the project"
  exit 1
fi

echo "🔍 Fixing SHA256 hash for v${VERSION}..."

# Generate SHA256 hash
URL="https://github.com/trtmn/cli-phonetic-alphabet/archive/refs/tags/v${VERSION}.tar.gz"
echo "Downloading ${URL}..."
curl -L "${URL}" -o "cli-phonetic-alphabet-${VERSION}.tar.gz"

echo "Generating SHA256 hash..."
SHA256=$(shasum -a 256 "cli-phonetic-alphabet-${VERSION}.tar.gz" | cut -d ' ' -f 1)

echo "SHA256 hash: ${SHA256}"

# Update Homebrew formula with the correct SHA256
echo "📝 Updating Homebrew formula with the correct SHA256..."
sed -i '' "s/sha256 \".*\"/sha256 \"${SHA256}\"/" cli-phonetic-alphabet.rb

# Clean up
echo "🧹 Cleaning up..."
rm "cli-phonetic-alphabet-${VERSION}.tar.gz"

echo "✅ SHA256 hash fixed successfully!"
echo ""
echo "To update the Homebrew tap repository, run:"
echo "cd ../homebrew-cli-phonetic-alphabet"
echo "cp ../cli-photnetic-alphabet/cli-phonetic-alphabet.rb ."
echo "git add ."
echo "git commit -m \"Fix SHA256 hash for v${VERSION}\""
echo "git push" 