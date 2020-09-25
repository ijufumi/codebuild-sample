FROM golang:1.12-alpine AS build
#Install git
RUN apk add --no-cache git wget
RUN wget --no-check-certificate --no-proxy http://iju-test-bucket.s3-ap-northeast-1.amazonaws.com/elb_memo.txt
#Get the hello world package from a GitHub repository
RUN go get github.com/golang/example/hello
WORKDIR /go/src/github.com/golang/example/hello
# Build the project and send the output to /bin/HelloWorld 
RUN go build -o /bin/HelloWorld

FROM golang:1.12-alpine
#Copy the build's output binary from the previous build container
COPY --from=build /bin/HelloWorld /bin/HelloWorld
ENTRYPOINT ["/bin/HelloWorld"]
