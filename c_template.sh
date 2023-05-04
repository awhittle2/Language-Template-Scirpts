#!/bin/bash
#!/bin/bash

# Prompt the user for the project name
read -p "Enter the project name: " project_name

# Change these variables to match your desired file names
main_file="main.c"
header_file="functions.h"
source_file="functions.c"
read_me="README.md"

# Create project directory
mkdir "$project_name"
cd "$project_name"

# Create the main file
cat > "$main_file" << EOL
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "${header_file}"

int main() {
    printf("Hello, World!\\n");
    print_hello();
    return 0;
}
EOL

# Create the header file
cat > "$header_file" << EOL
#ifndef FUNCTIONS_H
#define FUNCTIONS_H

void print_hello();

#endif // FUNCTIONS_H
EOL

# Create the source file
cat > "$source_file" << EOL
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "${header_file}"

void print_hello() {
    printf("Hello from the function!\\n");
}
EOL

# Create the README file
cat > "$read_me" << EOL
# ${project_name}

## Table of Contents
- [Description](#description)
- [Dependencies](#dependencies)
- [Usage](#usage)

## Description

A simple C program.

## Dependencies
- stdio.h
- stdlib.h
- string.h

## Usage

./test.sh

EOL

cat > "test.sh" << EOL
#!/bin/bash

# Note this is only for Debian-based distros

# Prompt the user for a number
read -p "Enter a number 1 (normal), 2 (gdb), 3 (valgrind): " number

# Update the system
sudo apt update -y && sudo apt upgrade -y

# Make sure the dependencies are installed first
for package in valgrind gdb build-essential; do
    if ! dpkg -s "$package" &> /dev/null; then
        sudo apt-get install -y "$package"
    fi
done

# Compile and run the program
if [ "$number" -eq 1 ]; then
    gcc --std=gnu99 -o main main.c functions.c
    ./main
elif [ "$number" -eq 2 ]; then
    gcc --std=gnu99 -g -o main main.c functions.c
    gdb ./main
elif [ "$number" -eq 3 ]; then
    gcc --std=gnu99 -g -o main main.c functions.c
    valgrind --leak-check=full --track-origins=yes main
else
    echo "Invalid number"
fi
EOL

chmod +x test.sh

git init
git config --global user.name "Abigail Whittle"
git config --global user.email "whittleabigail@gmail.com"

# Create the .gitignore file
cat > ".gitignore" << EOL
*.o
*.out
*.exe
EOL

git add .
git commit -m "Initial commit"

echo "Project directory for '${project_name}' has been created and initialized with git!"

code .