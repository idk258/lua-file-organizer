# Lua File Organizer

A simple Windows file organizer written in Lua.

It automatically sorts files into folders like:

- Images
- Videos
- Archives
- Documents
- Other

## How to use

1. Install Lua on your computer.
2. Download `organizer.lua`.
3. Open Command Prompt or PowerShell in the folder where the script is.
4. Run:

```bash
lua organizer.lua
```

5. Enter the folder you want to organize.

Example:

```text
C:\Users\YourName\Downloads
```

6. Type `yes` to confirm.

The script will automatically move files into the correct folders.

## Example

Before:

```text
Downloads/
photo.png
video.mp4
notes.txt
file.zip
```

After:

```text
Downloads/
├── Images/
├── Videos/
├── Documents/
└── Archives/
```

## Note

This script is made for **Windows**.