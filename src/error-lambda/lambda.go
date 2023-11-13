package main

import (
	"github.com/aws/aws-lambda-go/lambda"
	"fmt"
)

type MyEvent struct {
	Action string `json:"Input"`
}

type MyResponse struct {
	Message string `json:"Result:"`
}

func HandleLambdaEvent(event *MyEvent) (*MyResponse, error) {
	if event == nil {
		return nil, fmt.Errorf("received nil event")
	}
	return &MyResponse{Message: fmt.Sprintf("%s passed_input", event.Action)}, nil
}


func main() {
    lambda.Start(HandleLambdaEvent)
}
