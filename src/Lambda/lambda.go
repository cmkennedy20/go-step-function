package main

import (
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
)

type MyEvent struct {
	Action string `json:"Input"`
}

type MyResponse struct {
	Message string `json:"Result:"`
}

func HandleLambdaEvent(event MyEvent) (MyResponse, error) {
	return MyResponse{"True"}, nil
}

func main() {
    lambda.Start(HandleLambdaEvent)
}
