FROM golang:1.24-alpine AS builder 

RUN mkdir /app 

COPY . /app 

WORKDIR /app 

#cgo_enabled=0 why we are using this ? 
# when ever we run the go build command we get binary file as output 
# this files are dependent on c libraries which will increase the size of the binary file when we disable the cgo the generated file will be static binary file (smaller size)
RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api 

RUN chmod +x /app/brokerApp 



#building tiny docker image which will only contain the executable file
FROM alpine:3.19

RUN mkdir /app 

COPY --from=builder /app/brokerApp /app 

CMD ["/app/brokerApp"]