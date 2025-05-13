#!/bin/zsh

source /Users/cohenrussell/Code/Scripts/my-aws/src/file-managment.sh
source /Users/cohenrussell/Code/Scripts/my-aws/src/profile-logs.sh
source /Users/cohenrussell/Code/Scripts/my-aws/src/s3upload.sh

usage()
{
    echo "\033[1mDescription:\033[0m"
    echo "  This is a program to help make uploading files to aws s3 buckets easier"
    echo "  If your projet also has a git repo, running \"myaws create-log\" in the root"
    echo "  folder of the repo will create a log, removing the need to manauly add files"
    echo "  and specify the bucket each time. Instead, using git logs, only the files"
    echo "  that have been changed since last upload will be uploaded again"
    echo ""
    echo "\033[1mUsage:\033[0m"
    echo "  myaws help                      displays help menu"
    echo "  myaws list                      displays all selected files"
    echo "  myaws profile                   set aws profile to be used"
    echo "  myaws add <file path>           adds a file or folder to being selected"
    echo "  myaws remove <file path>        removes a file or folder from being selected"
    echo "  myaws upload <bucket path>      uploads the selected files to the entered bucket"
    echo "  myaws create-log                works only in folders with git repositories,"
    echo "                                  creates a myaws record."
    echo "  myaws delete-log                deletes any logs setup in the directory"
}

if ! [[ $# -gt 0 ]]; then
    usage
    exit 1
fi

program="$1"

case "$program" in

    "help")
        usage
        exit 0
    ;;

    "list")
        echo "selected files: "
        echo ""
        cat ../urs-files/selected.txt
        echo ""
        echo "You can add files using \"myaws add <file path>\""
        echo "and remove files using \"myaws remove <file path>\""
    ;;

    "profile")
        updateProfile
    ;;

    "add")
        if ! [[ $# -eq 2 ]]; then
            usage
            exit 1
        fi
        # call the appropriate function

    ;;

    "remove")
        if ! [[ $# -eq 2 ]]; then
            usage
            exit 1
        fi
        # call the appropriate function

    ;;

    "upload")
        if [[ $# -eq 1 ]]; then
            # look for .my-aws, if not found then tell then usage or how to create one

        elif [[ $# -eq 2 ]]; then
            # upload with the given bucket name
    
        else
            usage
            exit 1
        fi
    ;;

    "create-log")
        if ! [[ $# -eq 1 ]]; then
            usage
            exit 1
        fi
        create-log
    ;;

    "delete-log")
        if ! [[ $# -eq 1 ]]; then
            usage
            exit 1
        fi
        delete-log
    ;;

    *)
        usage
        exit 1
    ;;
esac