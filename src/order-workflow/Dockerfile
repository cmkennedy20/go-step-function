FROM golang:1.21.3-alpine3.17 as build
RUN mkdir /opt/go_lambda/
WORKDIR /opt/go_lambda/
# Copy dependencies list
COPY go.mod ./
# Build with optional lambda.norpc tag
COPY ./lambda.go .
RUN go build -tags lambda-image -o main lambda.go
# Copy artifacts to a clean image
FROM golang:1.21.3-alpine3.17
COPY --from=build /opt/go_lambda/main ./main
ENTRYPOINT [ "./main" ]