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


export AWS_PAGER=""
cd /opt/localstack_home
work_dir=$(pwd)
functions=$(ls | grep lambda)
for function_name in $functions
do
    function_path="$work_dir/$function_name"
    cd $function_path
    awslocal create-function --no-paginate --function-name $function_name --runtime provided.al2 --handler bootstrap --architectures arm64 --role     lambda create-function --function-name $lambda_name --runtime nodejs18.x --zip-file "fileb://$lambda_name.zip" --handler index.handler --role --zip-file fileb://$function_path/lambda.zip
    awslocal lambda create-function-url-config --function-name $lambda_name --auth-type NONE
done 