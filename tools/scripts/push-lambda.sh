#/bin/bash
cd ../../
name="go-hello"
result=$(aws lambda get-function-configuration --function-name $name)
lambda_exists=$( $result | grep "ResourceNotFoundException" )
if [[ -z $lambda_exists ]]; then
    echo "it worked"
    aws lambda delete-function --function-name $name
    else
        echo "it don't work"
fi 
output=$(aws lambda create-function --function-name $name --runtime provided.al2 --handler bootstrap --architectures arm64 --role arn:aws:iam::290749291887:role/lambda-execution-role --zip-file fileb://src/Lambda/output.zip)
echo $output