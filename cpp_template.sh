#!/bin/bash

# Prompt the user for the project name
read -p "Enter the project name: " project_name

# Change these variables to match your desired file names
main_file="main.cpp"
header_file="functions.h"
source_file="functions.cpp"
read_me="README.md"

# Create project directory
mkdir "$project_name"
cd "$project_name"

# Create the main file
cat > "$main_file" << EOL
#include <iostream>
#include "${header_file}"

int main() {
    std::cout << "Hello, World!" << std::endl;
    print_hello();
    return 0;
}
EOL

# Create the header file
cat > "$header_file" << EOL
#ifndef FUNCTIONS_HPP
#define FUNCTIONS_HPP

void print_hello();

#endif // FUNCTIONS_HPP
EOL

# Create the source file
cat > "$source_file" << EOL
#include <iostream>
#include "${header_file}"

void print_hello() {
    std::cout << "Hello from the function!" << std::endl;
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

A simple C++ program.

## Dependencies
- iostream

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
    g++ -o main main.cpp functions.cpp
    ./main
elif [ "$number" -eq 2 ]; then
    g++ -g -o main main.cpp functions.cpp
    gdb ./main
elif [ "$number" -eq 3 ]; then
    g++ -g -o main main.cpp functions.cpp
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
