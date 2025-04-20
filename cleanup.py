import os
import re

DIR = './odin-assimp/'

# Regex to match: StructName :: struct { }
empty_struct_pattern = re.compile(
    r'^([a-zA-Z_][a-zA-Z0-9_]*) :: struct \{\n\}$', re.MULTILINE
)

for filename in os.listdir(DIR):
    if filename.endswith('.odin'):
        filepath = os.path.join(DIR, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        # Remove all empty struct definitions
        cleaned = re.sub(empty_struct_pattern, '', content)
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(cleaned)
