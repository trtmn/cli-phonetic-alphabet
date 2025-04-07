import click
from rich.console import Console
from rich.table import Table
import rich

# NATO Phonetic Alphabet dictionary
NATO_ALPHABET = {
    'A': 'Alpha', 'B': 'Bravo', 'C': 'Charlie', 'D': 'Delta',
    'E': 'Echo', 'F': 'Foxtrot', 'G': 'Golf', 'H': 'Hotel',
    'I': 'India', 'J': 'Juliet', 'K': 'Kilo', 'L': 'Lima',
    'M': 'Mike', 'N': 'November', 'O': 'Oscar', 'P': 'Papa',
    'Q': 'Quebec', 'R': 'Romeo', 'S': 'Sierra', 'T': 'Tango',
    'U': 'Uniform', 'V': 'Victor', 'W': 'Whiskey', 'X': 'X-ray',
    'Y': 'Yankee', 'Z': 'Zulu'
}

# NATO Phonetic Alphabet for numbers
NATO_NUMBERS = {
    '0': 'Zero', '1': 'One', '2': 'Two', '3': 'Three', '4': 'Four',
    '5': 'Five', '6': 'Six', '7': 'Seven', '8': 'Eight', '9': 'Nine'
}

console = Console()

class PhoneticTable:
    """Class for creating consistent phonetic alphabet tables."""
    
    @staticmethod
    def create_table(title=None):
        """Create a table with consistent styling."""
        table = Table(
            show_header=True, 
            header_style="bold blue", 
            box=rich.box.ROUNDED,
            title=title
        )
        return table
    
    @staticmethod
    def add_columns(table, is_alphabet_list=False):
        """Add columns to the table with consistent styling."""
        if is_alphabet_list:
            table.add_column("Letter")
            table.add_column("Phonetic", style="green")
        else:
            table.add_column("Character")
            table.add_column("Phonetic", style="green")
        return table

def create_phonetic_table(text: str) -> Table:
    """Create a rich table with the phonetic alphabet conversion."""
    table = PhoneticTable.create_table()
    table = PhoneticTable.add_columns(table)
    
    for char in text.upper():
        if char.isalpha():
            table.add_row(char, NATO_ALPHABET[char])
        elif char.isdigit():
            table.add_row(char, NATO_NUMBERS[char])
        elif char.isspace():
            table.add_row(char, "")
        else:
            table.add_row(char, char)
    
    return table

@click.command()
@click.argument('text', required=False)
@click.option('--list', 'show_list', is_flag=True, help='Show the complete NATO phonetic alphabet')
@click.option('-s', '--string', help='Text to convert to NATO phonetic alphabet')
def main(text: str, show_list: bool, string: str):
    """Convert text to NATO phonetic alphabet or show the complete alphabet."""
    if show_list:
        table = PhoneticTable.create_table(title="NATO Phonetic Alphabet")
        table = PhoneticTable.add_columns(table, is_alphabet_list=True)
        
        for letter, phonetic in sorted(NATO_ALPHABET.items()):
            table.add_row(letter, phonetic)
        
        console.print(table)
        return

    # Use string from option if provided, otherwise use positional argument
    input_text = string if string is not None else text
    
    if not input_text:
        input_text = click.prompt('Enter text to convert', type=str)
    
    table = create_phonetic_table(input_text)
    console.print(table)

if __name__ == '__main__':
    main() 