#!/usr/bin/env bash

# Package Management Script for NixOS
# This script helps manage the centralized packages in modules/packages.nix

set -e

PACKAGES_FILE="modules/packages.nix"
BACKUP_FILE="modules/packages.nix.backup"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}=== $1 ===${NC}"
}

# Function to backup current packages file
backup_packages() {
    if [ -f "$PACKAGES_FILE" ]; then
        cp "$PACKAGES_FILE" "$BACKUP_FILE"
        print_status "Backup created: $BACKUP_FILE"
    fi
}

# Function to restore from backup
restore_backup() {
    if [ -f "$BACKUP_FILE" ]; then
        cp "$BACKUP_FILE" "$PACKAGES_FILE"
        print_status "Restored from backup: $BACKUP_FILE"
    else
        print_error "No backup file found"
        exit 1
    fi
}

# Function to list all packages by category
list_packages() {
    print_header "Packages by Category"
    
    if [ ! -f "$PACKAGES_FILE" ]; then
        print_error "Packages file not found: $PACKAGES_FILE"
        exit 1
    fi
    
    # Extract categories and packages
    grep -E "^    # =====|^    [a-zA-Z]" "$PACKAGES_FILE" | while read -r line; do
        if [[ $line =~ "=====" ]]; then
            # Category header
            category=$(echo "$line" | sed 's/.*===== \(.*\) =====.*/\1/')
            echo -e "\n${BLUE}$category${NC}"
        else
            # Package name
            package=$(echo "$line" | sed 's/^[[:space:]]*//')
            echo "  - $package"
        fi
    done
}

# Function to search for a package
search_package() {
    local search_term="$1"
    
    if [ -z "$search_term" ]; then
        print_error "Please provide a search term"
        echo "Usage: $0 search <package_name>"
        exit 1
    fi
    
    print_header "Searching for packages containing: $search_term"
    
    if grep -i "$search_term" "$PACKAGES_FILE" > /dev/null; then
        grep -i "$search_term" "$PACKAGES_FILE" | while read -r line; do
            if [[ $line =~ ^[[:space:]]*[a-zA-Z] ]]; then
                package=$(echo "$line" | sed 's/^[[:space:]]*//')
                echo "  - $package"
            fi
        done
    else
        print_warning "No packages found containing: $search_term"
    fi
}

# Function to add a package
add_package() {
    local package="$1"
    local category="$2"
    
    if [ -z "$package" ]; then
        print_error "Please provide a package name"
        echo "Usage: $0 add <package_name> [category]"
        exit 1
    fi
    
    if [ -z "$category" ]; then
        category="SYSTEM UTILITIES"
    fi
    
    print_header "Adding package: $package to category: $category"
    
    # Check if package already exists
    if grep -q "^[[:space:]]*$package$" "$PACKAGES_FILE"; then
        print_warning "Package $package already exists"
        return
    fi
    
    # Find the category section and add the package
    if grep -q "===== $category =====" "$PACKAGES_FILE"; then
        # Add package before the next category or end of list
        awk -v pkg="$package" -v cat="$category" '
        /===== '"$category"' =====/ { in_category=1; print; next }
        in_category && /===== / { in_category=0 }
        in_category && /^[[:space:]]*[a-zA-Z]/ { 
            print "    " pkg
            in_category=0
        }
        { print }
        ' "$PACKAGES_FILE" > "$PACKAGES_FILE.tmp" && mv "$PACKAGES_FILE.tmp" "$PACKAGES_FILE"
        
        print_status "Package $package added to category $category"
    else
        print_error "Category '$category' not found"
        echo "Available categories:"
        grep "=====" "$PACKAGES_FILE" | sed 's/.*===== \(.*\) =====.*/\1/'
    fi
}

# Function to remove a package
remove_package() {
    local package="$1"
    
    if [ -z "$package" ]; then
        print_error "Please provide a package name"
        echo "Usage: $0 remove <package_name>"
        exit 1
    fi
    
    print_header "Removing package: $package"
    
    if grep -q "^[[:space:]]*$package$" "$PACKAGES_FILE"; then
        # Remove the package line
        sed "/^[[:space:]]*$package$/d" "$PACKAGES_FILE" > "$PACKAGES_FILE.tmp" && mv "$PACKAGES_FILE.tmp" "$PACKAGES_FILE"
        print_status "Package $package removed"
    else
        print_warning "Package $package not found"
    fi
}

# Function to rebuild the system
rebuild_system() {
    print_header "Rebuilding NixOS system"
    print_warning "This will rebuild your system with the current package configuration"
    read -p "Continue? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Rebuilding system..."
        sudo nixos-rebuild switch --flake .#novanix
        print_status "System rebuild completed"
    else
        print_warning "Rebuild cancelled"
    fi
}

# Function to show usage
show_usage() {
    echo "Package Management Script for NixOS"
    echo ""
    echo "Usage: $0 <command> [options]"
    echo ""
    echo "Commands:"
    echo "  list                    List all packages by category"
    echo "  search <term>           Search for packages containing the term"
    echo "  add <package> [cat]     Add a package to a category (default: SYSTEM UTILITIES)"
    echo "  remove <package>        Remove a package"
    echo "  backup                  Create a backup of the current packages file"
    echo "  restore                 Restore from backup"
    echo "  rebuild                 Rebuild the NixOS system"
    echo "  help                    Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 list"
    echo "  $0 search firefox"
    echo "  $0 add firefox BROWSERS"
    echo "  $0 remove spotify"
    echo "  $0 rebuild"
}

# Main script logic
case "${1:-help}" in
    list)
        list_packages
        ;;
    search)
        search_package "$2"
        ;;
    add)
        add_package "$2" "$3"
        ;;
    remove)
        remove_package "$2"
        ;;
    backup)
        backup_packages
        ;;
    restore)
        restore_backup
        ;;
    rebuild)
        rebuild_system
        ;;
    help|--help|-h)
        show_usage
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac 