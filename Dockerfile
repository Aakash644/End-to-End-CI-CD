#start with a base image
FROM golang:1.22 as base

#setup work dir inside container
WORKDIR /app

#copy go mod files
COPY go.mod ./ 

# Download all the dependencies
RUN go mod download

#copying source code to work dir
COPY . .

# Build the application
RUN go build -o main .

#################################################

FROM gcr.io/distroless/base

# Copy the binary from the previous stage
COPY --from=base /app/main .

# Copy the static files from the previous stage
COPY --from=base /app/static ./static


# Expose the port on which the application will run
EXPOSE 8080

# Command to run the application
CMD ["./main"]