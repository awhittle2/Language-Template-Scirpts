#!/bin/bash

# Prompt the user for the project name
read -p "Enter the project name: " project_name

# Set the main file name
main_file="Main.java"
read_me="README.md"

# Create project directory
mkdir "$project_name"
cd "$project_name"

# Create the main file
cat > "$main_file" << EOL
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        printHello();
    }

    public static void printHello() {
        System.out.println("Hello from the function!");
    }
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

A simple java program.

## Dependencies
- java

## Usage

./test.sh

EOL

cat > "test.sh" << EOL
#!/bin/bash

# Note this is only for Debian-based distros

# Update the system
sudo apt update -y && sudo apt upgrade -y

# Make sure the dependencies are installed first
for package in default-jre; do
    if ! dpkg -s "$package" &> /dev/null; then
        sudo apt-get install -y "$package"
    fi
done

javac "$main_file"
java Main
EOL

cat > "gitignore" << EOL
*.class
EOL

chmod +x test.sh

git init
git config --global user.name "Abigail Whittle"
git config --global user.email "whittleabigail@gmail.com"

git add .
git commit -m "Initial commit"

echo "Project directory for '${project_name}' has been created and initialized with git!"

code .
