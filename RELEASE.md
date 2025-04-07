# Release Process

This document outlines the process for publishing a new version of the CLI Phonetic Alphabet tool.

## Prerequisites

- Git installed and configured
- GitHub account with write access to the repositories
- GitHub authentication token with `repo` scope
- Homebrew installed (for testing)

## Automated Release Process

We've created a script that automates the entire release process. To use it:

1. Make sure you're in the root directory of the project
2. Run the release script with the new version number:

```bash
./scripts/release.sh <version>
```

For example:

```bash
./scripts/release.sh 0.1.2
```

The script will:
1. Update the version in pyproject.toml
2. Update the version in the Homebrew formula
3. Commit and push the changes to GitHub
4. Create and push a new tag
5. Generate the SHA256 hash for the new release
6. Update the Homebrew formula with the correct SHA256 hash
7. Update the Homebrew tap repository

## Manual Release Process

If you prefer to perform the release process manually, follow these steps:

1. Update the version in pyproject.toml
2. Update the version in the Homebrew formula (cli-phonetic-alphabet.rb)
3. Commit and push the changes to GitHub
4. Create and push a new tag
5. Generate the SHA256 hash for the new release
6. Update the Homebrew formula with the correct SHA256 hash
7. Update the Homebrew tap repository

### Generating the SHA256 Hash

To generate the SHA256 hash for a new release:

```bash
./scripts/generate_sha256.sh <version>
```

For example:

```bash
./scripts/generate_sha256.sh 0.1.2
```

### Fixing SHA256 Hash Issues

If you encounter SHA256 hash mismatch issues, you can use the fix script:

```bash
./scripts/fix_sha256.sh <version>
```

For example:

```bash
./scripts/fix_sha256.sh 0.1.2
```

## Testing the Release

After publishing a new release, you can test it by installing it with Homebrew:

```bash
brew tap trtmn/cli-phonetic-alphabet
brew install cli-phonetic-alphabet
```

## Troubleshooting

### Authentication Issues

If you encounter authentication issues when pushing to GitHub, make sure your GitHub authentication token has the correct permissions. You may need to create a new token with the `repo` scope.

Visit: https://github.com/settings/tokens to create a new token.

### SHA256 Hash Mismatch

If you encounter SHA256 hash mismatch issues, it's likely because the tag was created after the commit, or the tag was updated. In this case, use the fix script to update the SHA256 hash in the Homebrew formula. 