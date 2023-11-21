package main

import (
	"github.com/aws/aws-lambda-go/lambda"
	"fmt"
)

type MyEvent struct {
	Action string `json:"Input"`
}

type MyResponse struct {
	Message string `json:"transaction_type:"`
}

func HandleLambdaEvent(event *MyEvent) (*MyResponse, error) {
	if event == nil {
		return nil, fmt.Errorf("received nil event")
	}
	return &MyResponse{Message: fmt.Sprintf("%s order_processed", event.Action)}, nil
}

func main() {
    lambda.Start(HandleLambdaEvent)
}
