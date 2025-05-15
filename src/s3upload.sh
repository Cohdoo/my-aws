#!/bin/zsh

uploadOptionSelected()
{
    
    # aquire the bucketname and potentially a ignore
    local bucketname=""
    local ignoreFile=""
    if [[ "$1" == "" ]]; then
        # not specified to look into log to find it
        if [[ -d "./.my-aws" ]]; then
            bucketname="$(cat ./.my-aws/head)"
            ignoreFile="$(cat ./.my-aws/ignore)"
        elif [[ -d "../.my-aws" ]]; then
            bucketname="$(cat ../.my-aws/head)"
            ignoreFile="$(cat ../.my-aws/ignore)"
        elif [[ -d "../../.my-aws" ]]; then
            bucketname="$(cat ../../.my-aws/head)"
            ignoreFile="$(cat ../../.my-aws/ignore)"
        elif [[ -d "../../../.my-aws" ]]; then
            bucketname="$(cat ../../../.my-aws/head)"
            ignoreFile="$(cat ../../../.my-aws/ignore)"
        else
            echo "no myaws log found. Create one with myaws create-log, or"
            echo "specify which bucket to upload to in form s3://bucket-name/"
            return
        fi
    else
        bucketname="$1"
    fi

    getExcludes "$ignoreFile"
    excludeArgs=("${reply[@]}")

    # get array of the paths to all the selected files, and upload each file
    selectedfiles_array=("${(f)$(< "$SELECTED_PATH")}")
    for path in "${selectedfiles_array[@]}"; do
        if [[ -f "$path" ]]; then
            aws s3 cp "$path" "$bucketname" --profile "$(cat "$PROFILE_PATH")" "${excludeArgs[@]}"
        elif [[ -d "$path" ]]; then
            aws s3 cp "$path" "$bucketname" --recursive --profile "$(cat "$PROFILE_PATH")" "${excludeArgs[@]}"
        fi
    done
}

uploadOptionChanged()
{
    
    bucketname=""
    ignoreFile=""
    # aquire the bucketname to upload to
    if [[ "$1" == "" ]]; then
        # not specified to look into log to find it
        if [[ -d "./.my-aws" ]]; then
            bucketname="$(cat ./.my-aws/head)"
            ignoreFile="$(cat ./.my-aws/ignore)"
        elif [[ -d "../.my-aws" ]]; then
            bucketname="$(cat ../.my-aws/head)"
            ignoreFile="$(cat ../.my-aws/ignore)"
        elif [[ -d "../../.my-aws" ]]; then
            bucketname="$(cat ../../.my-aws/head)"
            ignoreFile="$(cat ../../.my-aws/ignore)"
        elif [[ -d "../../../.my-aws" ]]; then
            bucketname="$(cat ../../../.my-aws/head)"
            ignoreFile="$(cat ../../../.my-aws/ignore)"
        else
            echo "no myaws log found. Create one with myaws create-log, or"
            echo "specify which bucket to upload to in form s3://bucket-name/"
            return
        fi
    else
        bucketname="$1"
    fi

    getExcludes "$ignoreFile"
    excludeArgs=("${reply[@]}")
    aws s3 sync "$PWD" "$bucketname" --profile "$(cat "$PROFILE_PATH")" "${excludeArgs[@]}"

    echo "all files uploaded"
}

getExcludes() {
    excludeFiles=()
    globalIgnore="$IGNORE_PATH"
    localIgnore="$1"

    # Load global ignore file
    if [[ -f "$globalIgnore" ]]; then
        globalIgnorePaths=("${(@f)$(< "$globalIgnore")}")
        for file in "${globalIgnorePaths[@]}"; do
            excludeFiles+=("--exclude" "$file")
        done
    fi

    # Load local ignore file
    if [[ -f "$localIgnore" ]]; then
        localIgnorePaths=("${(@f)$(< "$localIgnore")}")
        for file in "${localIgnorePaths[@]}"; do
            excludeFiles+=("--exclude" "$file")
        done
    fi

    # Use 'reply' to return the array
    reply=("${excludeFiles[@]}")
}