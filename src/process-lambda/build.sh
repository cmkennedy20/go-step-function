#/bin/bash
cd /opt/go_home/process-lambda
GOOS=linux GOARCH=arm64 go build -tags lambda.norpc -o bootstrap lambda.go
zip process-lambda.zip bootstrap
