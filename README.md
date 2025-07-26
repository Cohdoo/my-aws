# MyAWS S3 File Manager (macOS Only)

A command-line tool to simplify and streamline file uploads to AWS S3 buckets. This tool provides an intuitive interface for managing file uploads, with support for both selective and change-based synchronization.

## Features

- **Profile Management**: Easily switch between AWS SSO profiles
- **Selective Upload**: Choose specific files and directories to upload
- **Change Detection**: Upload only modified files since last sync
- **Ignore Patterns**: Support for both global and local ignore patterns
- **Bucket Association**: Associate directories with specific S3 buckets
- **Simple CLI**: Intuitive command-line interface for all operations

## Installation

1. Clone this repository
2. Navigate to the installer directory
3. Run the installer with sudo:
```bash
sudo ./installer
```

## Usage

The main command is `myaws`. Here are the available commands:

```bash
myaws help                      # Display help menu
myaws list                      # Display all selected files
myaws profile                   # Set AWS profile to be used
myaws create-log               # Create a myaws record for current directory
myaws delete-log               # Delete myaws configuration for current directory
myaws add <file path>          # Add a file/folder to selection
myaws remove <file path>       # Remove a file/folder from selection
myaws ignore-list <option>     # View ignore file (-g for global, -l for local)
myaws upload <option> <bucket> # Upload files to AWS S3
```

### Upload Options

- `--selected (-s)`: Upload only selected files/directories
- `--changed (-c)`: Upload all changed files in current directory

### Bucket Specification

You can specify buckets in two ways:
1. Directly in the command: `s3://bucket-path/`
2. Via a myaws log (created with `myaws create-log`)

## Ignore Files

MyAWS supports two levels of ignore patterns:

1. **Global Ignore**: Applies to all uploads (`~/.myaws/usr-files/ignore`)
2. **Local Ignore**: Specific to a directory (`./.my-aws/ignore`)

## Directory Configuration

When you run `myaws create-log`, it creates a `.my-aws` directory containing:
- `head`: Stores the associated S3 bucket path
- `ignore`: Local ignore patterns for this directory

## Requirements

- macOS
- AWS CLI configured with SSO profiles
- Appropriate AWS S3 permissions

## Notes

- All file paths can be relative or absolute
- The tool maintains state in `~/.myaws` directory
- AWS credentials should be configured before use
