#!/bin/bash

# This script automates the release process for the CLI Phonetic Alphabet tool
# Usage: ./scripts/release.sh <version>

set -e  # Exit on error

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: ./scripts/release.sh <version>"
  echo "Example: ./scripts/release.sh 0.1.2"
  exit 1
fi

# Check if we're in the right directory
if [ ! -f "pyproject.toml" ]; then
  echo "Error: This script must be run from the root directory of the project"
  exit 1
fi

echo "🚀 Starting release process for v${VERSION}..."

# Step 1: Update version in pyproject.toml
echo "📝 Updating version in pyproject.toml..."
sed -i '' "s/version = \".*\"/version = \"${VERSION}\"/" pyproject.toml

# Step 2: Update version in Homebrew formula
echo "📝 Updating version in Homebrew formula..."
sed -i '' "s/url \"https:\/\/github.com\/trtmn\/cli-phonetic-alphabet\/archive\/refs\/tags\/v.*\.tar\.gz\"/url \"https:\/\/github.com\/trtmn\/cli-phonetic-alphabet\/archive\/refs\/tags\/v${VERSION}.tar.gz\"/" cli-phonetic-alphabet.rb

# Step 3: Commit changes
echo "📦 Committing version changes..."
git add pyproject.toml cli-phonetic-alphabet.rb
git commit -m "Bump version to ${VERSION}"

# Step 4: Push changes
echo "⬆️ Pushing changes to GitHub..."
if ! git push; then
  echo "❌ Failed to push changes to GitHub. This might be due to authentication issues."
  echo "Please make sure you have the correct access rights to the repository."
  echo "You may need to update your GitHub authentication token with write permissions."
  echo "Visit: https://github.com/settings/tokens to create a new token with 'repo' scope."
  exit 1
fi

# Step 5: Create and push tag
echo "🏷️ Creating tag v${VERSION}..."
git tag -a "v${VERSION}" -m "Release v${VERSION}"
if ! git push --tags; then
  echo "❌ Failed to push tags to GitHub. This might be due to authentication issues."
  echo "Please make sure you have the correct access rights to the repository."
  echo "You may need to update your GitHub authentication token with write permissions."
  echo "Visit: https://github.com/settings/tokens to create a new token with 'repo' scope."
  exit 1
fi

# Step 6: Wait for GitHub to process the tag (this is important!)
echo "⏳ Waiting for GitHub to process the tag (10 seconds)..."
sleep 10

# Step 7: Generate SHA256 hash
echo "🔍 Generating SHA256 hash..."
URL="https://github.com/trtmn/cli-phonetic-alphabet/archive/refs/tags/v${VERSION}.tar.gz"
echo "Downloading ${URL}..."
curl -L "${URL}" -o "cli-phonetic-alphabet-${VERSION}.tar.gz"

echo "Generating SHA256 hash..."
SHA256=$(shasum -a 256 "cli-phonetic-alphabet-${VERSION}.tar.gz" | cut -d ' ' -f 1)

echo "SHA256 hash: ${SHA256}"

# Step 8: Update Homebrew formula with the correct SHA256
echo "📝 Updating Homebrew formula with the correct SHA256..."
sed -i '' "s/sha256 \".*\"/sha256 \"${SHA256}\"/" cli-phonetic-alphabet.rb

# Step 9: Update Homebrew tap repository
echo "🔄 Updating Homebrew tap repository..."
cd ../homebrew-cli-phonetic-alphabet
cp ../cli-photnetic-alphabet/cli-phonetic-alphabet.rb .
git add .
git commit -m "Update formula to v${VERSION}"
if ! git push; then
  echo "❌ Failed to push changes to the Homebrew tap repository."
  echo "Please make sure you have the correct access rights to the repository."
  echo "You may need to update your GitHub authentication token with write permissions."
  echo "Visit: https://github.com/settings/tokens to create a new token with 'repo' scope."
  exit 1
fi

# Step 10: Clean up
echo "🧹 Cleaning up..."
cd ../cli-photnetic-alphabet
rm "cli-phonetic-alphabet-${VERSION}.tar.gz"

echo "✅ Release v${VERSION} completed successfully!"
echo ""
echo "To install the new version:"
echo "brew tap trtmn/cli-phonetic-alphabet"
echo "brew install cli-phonetic-alphabet" 