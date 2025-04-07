#!/bin/bash

# This script helps prepare for a release by updating the version in pyproject.toml
# Usage: ./scripts/prepare_release.sh <version>

set -e  # Exit on error

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: ./scripts/prepare_release.sh <version>"
  echo "Example: ./scripts/prepare_release.sh 0.1.2"
  exit 1
fi

# Check if we're in the right directory
if [ ! -f "pyproject.toml" ]; then
  echo "Error: This script must be run from the root directory of the project"
  exit 1
fi

echo "🚀 Preparing for release v${VERSION}..."

# Step 1: Update version in pyproject.toml
echo "📝 Updating version in pyproject.toml..."
sed -i '' "s/version = \".*\"/version = \"${VERSION}\"/" pyproject.toml

# Step 2: Commit changes
echo "📦 Committing version changes..."
git add pyproject.toml
git commit -m "Bump version to ${VERSION}"

# Step 3: Push changes
echo "⬆️ Pushing changes to GitHub..."
if ! git push; then
  echo "❌ Failed to push changes to GitHub. This might be due to authentication issues."
  echo "Please make sure you have the correct access rights to the repository."
  echo "You may need to update your GitHub authentication token with write permissions."
  echo "Visit: https://github.com/settings/tokens to create a new token with 'repo' scope."
  exit 1
fi

echo "✅ Preparation for release v${VERSION} completed successfully!"
echo ""
echo "To complete the release, create and push a tag:"
echo "git tag -a v${VERSION} -m \"Release v${VERSION}\""
echo "git push --tags"
echo ""
echo "The GitHub Actions workflow will handle the rest of the release process." 