#!/bin/bash
cd /opt/lambda_home
working_directory=$(pwd)
for folder in "$working_directory"/*; do
    if [ -d "$folder" ]; then
        lambda_name=$(basename $folder)
        zip "$lambda_name.zip" "$working_directory/$lambda_name/"
        awslocal lambda create-function --function-name $lambda_name --runtime nodejs18.x --zip-file "fileb://$lambda_name.zip" --handler index.handler --role arn:aws:iam::000000000000:role/lambda-role
        awslocal lambda create-function-url-config --function-name $lambda_name --auth-type NONE
    fi