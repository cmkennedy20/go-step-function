#/bin/bash
export AWS_PAGER=""
cd ../../src
work_dir=$(pwd)
functions=$(ls | grep lambda)
for function_name in $functions
do
    function_path="$work_dir/$function_name"
    cd $function_path
    result=$(aws lambda get-function-configuration --function-name $function_name | grep "ResourceNotFoundException") > /dev/null
    if [[ -z "$result" ]]; then
        $(aws lambda delete-function --function-name $function_name) 
        rm -r -f bootstrap lambda.zip 
        else
            echo "The lambda doesn't exist"
    fi 
    docker exec -it $(docker ps | grep golang | cut -d " " -f 1) /bin/bash /opt/go_home/$function_name/build.sh
    aws lambda create-function --no-paginate --function-name $function_name --runtime provided.al2 --handler bootstrap --architectures arm64 --role arn:aws:iam::290749291887:role/lambda-execution-role --zip-file fileb://$function_path/lambda.zip
done 