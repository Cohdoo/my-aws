# my-aws **MAC ONLY**
Scripts to make my life of uploading stuff to aws s3 easier and faster

To install, run sudo ./installer from inside the installer directory
The command to run is 'myaws'

This is a program to help make uploading files to aws s3 buckets easier. You can manually select the files you want to add and specify the bucket for them to be added too. You can create a myaws log, removing the need to manauly add files and specify the bucket each time. Instead, only the files that have been changed since last upload will be uploaded again. Additionally, a user will have a global ingore list of files or file and directories to automaticlly ignore for any upload (specified using global patterns), as well as a local ignore for a bucket if a log is created.
