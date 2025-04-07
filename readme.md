# CLI Phonetic Alphabet

A command-line tool for converting text to NATO phonetic alphabet. Built with Click for argument parsing and Rich for pretty output.

## Installation

### With Homebrew (macOS)

```bash
brew tap yourusername/cli-phonetic-alphabet
brew install cli-phonetic-alphabet
```

### From Source

1. Clone this repository
2. Install build dependencies:
   ```bash
   pip install hatch
   ```
3. Build the package:
   ```bash
   hatch build
   ```
4. Install the built package:
   ```bash
   pip install dist/cli_phonetic_alphabet-0.1.0-py3-none-any.whl
   ```

## Usage

The tool can be used in two ways:

1. Convert text to NATO phonetic alphabet:
   ```bash
   phonetic "Hello World"
   ```

2. Show the complete NATO phonetic alphabet:
   ```bash
   phonetic --list
   ```

If no text is provided, the tool will prompt you to enter text interactively.

## Features

- Beautiful terminal output using Rich
- Interactive mode
- Complete alphabet listing
- Handles spaces and special characters
- Case-insensitive input
- Support for numbers

## Requirements

- Python 3.8 or higher
- Click
- Rich 