# install_linux.sh

```bash id="rmdp4k"
#!/bin/bash

set -e

INSTALL_DIR="$HOME/.ledger-automation"
PYTHON_DIR="$INSTALL_DIR/python"
BOOTSTRAP_URL="https://raw.githubusercontent.com/Abdurrahimgithub/AutoFIlings/main/bootstrap.py"

mkdir -p "$INSTALL_DIR"

echo "Downloading bootstrap.py..."
curl -L "$BOOTSTRAP_URL" -o "$INSTALL_DIR/bootstrap.py"

echo "Checking Python..."
if ! command -v python3 &> /dev/null
then
    echo "Python3 not found. Installing..."

    if command -v apt &> /dev/null
    then
        sudo apt update
        sudo apt install -y python3 python3-pip python3-venv curl
    elif command -v yum &> /dev/null
    then
        sudo yum install -y python3 python3-pip curl
    elif command -v dnf &> /dev/null
    then
        sudo dnf install -y python3 python3-pip curl
    elif command -v pacman &> /dev/null
    then
        sudo pacman -Sy --noconfirm python python-pip curl
    else
        echo "Unsupported package manager."
        exit 1
    fi
fi

echo "Creating virtual environment..."
python3 -m venv "$PYTHON_DIR"

echo "Activating environment..."
source "$PYTHON_DIR/bin/activate"

echo "Upgrading pip..."
pip install --upgrade pip

echo "Adding Ledger Automation Python to PATH..."

PROFILE_FILE="$HOME/.bashrc"

if [ -n "$ZSH_VERSION" ]; then
    PROFILE_FILE="$HOME/.zshrc"
fi

PATH_EXPORT="export PATH=\"$PYTHON_DIR/bin:\$PATH\""

grep -qxF "$PATH_EXPORT" "$PROFILE_FILE" || echo "$PATH_EXPORT" >> "$PROFILE_FILE"

export PATH="$PYTHON_DIR/bin:$PATH"

echo "Running Bootstrap Installer..."
python "$INSTALL_DIR/bootstrap.py"

echo ""
echo "Installation Complete!"
echo "Folder: $INSTALL_DIR"
echo "Restart terminal or run:"
echo "source $PROFILE_FILE"
```

