#/bin/bash
cd ../../
name="go-hello"
result=$(aws lambda get-function-configuration --function-name $name | grep "ResourceNotFoundException")
if [[ -z "$result" ]]; then
    $(aws lambda delete-function --function-name $name)
    else
        echo "The lambda doesn't exist"
fi 
aws lambda create-function --no-paginate --function-name $name --runtime provided.al2 --handler bootstrap --architectures arm64 --role arn:aws:iam::290749291887:role/lambda-execution-role --zip-file fileb://src/Lambda/output.zip