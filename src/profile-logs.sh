#!/bin/zsh

create-log()
{
    # check to see if a log is already created
    if [[ -d "./.my-aws" ]]; then
        echo "log already created"
        return
    fi

    # make the directory and files
    mkdir ./.my-aws
    touch ./.my-aws/head
    touch ./.my-aws/ignore

    # get user data for what to put into files
    echo "Enter the name of the bucket to associate this directory with."
    echo -n "Please enter in the format s3://bucket-path/ : "
    read inHead
    
    # put data into the files
    print "$inHead" > ./.my-aws/head
    echo "you can add local ignore files by running aws ignore-list --local"
    echo "Log created"
}

delete-log()
{
    echo -n "Confirm deletion of the myaws log associated with this directory? (y/n) "
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
    echo "Current aws sso profile is $(cat $PROFILE_PATH)"
    echo -n "Do you want to change profile? (y/n) "
    read answer
    if ! [[ "$answer[1]" == "y" ]]; then
        return
    fi
    echo -n "Enter new aws sso profile: "
    read newProfile
    echo "updated profile to $newProfile"
    print "$newProfile" > $PROFILE_PATH
}