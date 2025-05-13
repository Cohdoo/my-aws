#!/bin/zsh

uploadOptionSelected()
{
    # aquire the bucketname to upload to
    bucketname=""
    if [[ "$1" == "" ]]; then
        # not specified to look into log to find it
        if [[ -d "./.my-aws" ]]; then
            bucketname="$(cat ./.my-aws/head)";
        else
            echo "no myaws log found. Create one with myaws create-log, or"
            echo "specify which bucket to upload to in form s3://bucket-name/"
            return
        fi
    else
        bucketname="$1"
    fi

    # upload all files in selected to the bucket
    
}

uploadOptionChanged()
{
    bucketname=""

    # aquire the bucketname to upload to
    if [[ "$1" == "" ]]; then
        # not specified to look into log to find it
        if [[ -d "./.my-aws" ]]; then
            bucketname="$(cat ./.my-aws/head)";
        else
            echo "no myaws log found. Create one with myaws create-log, or"
            echo "specify which bucket to upload to in form s3://bucket-name/"
            return
        fi
    else
        bucketname="$1"
    fi

    # upload all changed files in current directory to the bucket
    aws s3 sync "$PWD" "$bucketname"
}