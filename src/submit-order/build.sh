#/bin/bash
cd /opt/go_home/submit-order
GOOS=linux GOARCH=arm64 go build -tags lambda.norpc -o bootstrap lambda.go
zip lambda.zip bootstrap
