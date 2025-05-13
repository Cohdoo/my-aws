#!/bin/zsh

create-log()
{
    # check to see if a log is already created
    if [[ -d "./.my-aws" ]]; then
        echo "log already created"
        return
    fi
    # check to see if there is a git repo
    if ! [[ -d "./.git" ]]; then
        echo "No git repo found, which is required"
        return
    fi

    # make the directory and files
    mkdir ./.my-aws
    touch ./.my-aws/head
    touch ./.my-aws/last-upload

    # get user data for what to put into files
    echo "Enter the name of the bucket to associate this directory with."
    echo "Please enter in the format s3://bucket-path/ : "
    read inHead
    
    # put data into the files
    print "$inHead" > ./.my-aws/head
    date +"%Y-%m-%d" > ./.my-aws/last-upload

    echo "Log created"
}

delete-log()
{
    echo "Confirm deletion of the myaws log associated with this directory? (y/n) "
    read answer
    if [[ "${answer[1]}" == "y" ]]; then
        rm -rf ./.my-aws
        echo "deletion successful"
    else
        echo "deletion cancled"
    fi
    return
}

updateProfile()
{
    echo "update profile to be implemented"
}