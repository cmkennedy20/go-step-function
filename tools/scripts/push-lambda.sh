#/bin/bash
export AWS_PAGER=""
cd ../../
name="process-lambda"
result=$(aws lambda get-function-configuration --function-name $name | grep "ResourceNotFoundException") > /dev/null
if [[ -z "$result" ]]; then
    $(aws lambda delete-function --function-name $name) 
    else
        echo "The lambda doesn't exist"
fi 
docker exec -it $(docker ps | grep golang | cut -d " " -f 1) /bin/bash /opt/go_home/process-lambda/build.sh
aws lambda create-function --no-paginate --function-name $name --runtime provided.al2 --handler bootstrap --architectures arm64 --role arn:aws:iam::290749291887:role/lambda-execution-role --zip-file fileb://src/process-lambda/process-lambda.zip