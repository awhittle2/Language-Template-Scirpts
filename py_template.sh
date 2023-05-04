#!/bin/bash

# Prompt the user for the project name
read -p "Enter the project name: " project_name

# Change this variable to match your desired main file name
main_file="main.py"
read_me="README.md"

# Create project directory
mkdir "$project_name"
cd "$project_name"

# Create the main file
cat > "$main_file" << EOL
def print_hello():
    print("Hello from the function!")

def main():
    print("Hello, World!")
    print_hello()

if __name__ == "__main__":
    main()
EOL

# Create the README file
cat > "$read_me" << EOL
# ${project_name}

## Table of Contents
- [Description](#description)
- [Dependencies](#dependencies)
- [Usage](#usage)

## Description

A simple python program.

## Dependencies
- python3

## Usage

./test.sh

EOL

cat > "test.sh" << EOL
#!/bin/bash

# Note this is only for Debian-based distros

# Update the system
sudo apt update -y && sudo apt upgrade -y

# Make sure the dependencies are installed first
for package in python3 python3-pip; do
    if ! dpkg -s "$package" &> /dev/null; then
        sudo apt-get install -y "$package"
    fi
done

python3 "$main_file"
EOL

chmod +x test.sh

git init
git config --global user.name "Abigail Whittle"
git config --global user.email "whittleabigail@gmail.com"

git add .
git commit -m "Initial commit"

echo "Project directory for '${project_name}' has been created and initialized with git!"

code .
