#building tiny docker image which will only contain the executable file
FROM alpine:3.19

RUN mkdir /app 

COPY brokerApp /app 

CMD ["/app/brokerApp"]