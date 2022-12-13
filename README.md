# subway

## Prerequisites

- docker and docker-compose (docker desktop provides all of this)

## Running the app

Compile the typescript, build the docker image, start the docker containers from the image

```
npx tsc
docker-compose build
docker-compose up -d
```

The service can now be reached at localhost:8080/

Example requests:

GET localhost:8080/route?origin=A&destination=I

POST localhost:8080/train-line

with body

```
{
    "stations": [
        "G",
        "H",
        "I"
    ],
    "name": "Gamma"
}
```
