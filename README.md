# DnsStorage

## Running with docker

### Dependencies

  * Docker 19
  * Docker Compose 1.26

### Setup

  * Install [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/)
  * Run `docker-compose up`

### Preparing database

  * `docker-compose run app rails db:create db:migrate db:seed`

### Running tests

  * `docker-compose run app rspec spec`

## API

(_Running on [`localhost:3000`](http://localhost:3000)_)

### [POST] /v1/dns_records

#### cURL

```bash
curl -XPOST -H "Content-type: application/json" -d '{
    "dns_records": {
        "ip": "192.168.0.1",
        "domain_names_attributes": [
            {
                "name": "twitter.com"
            }
        ]
    }
}' 'http://localhost:3000/v1/dns_records'
```

#### Successful response

```json
{
  "id": 1
}
```

#### Error response

```json
{
  "errors": ["Ip must have a valid format"]
}
```

### [GET] /v1/dns_records?page={NUMBER}included[]={INCLUDED}&excluded[]={EXCLUDED}

#### cURL

```bash
curl -XGET -H "Content-type: application/json" 'http://localhost:3000/v1/dns_records?included[]=ipsum.com&included[]=dolor.com&excluded[]=sit.com'
```

#### Successful response

```json
{
	"total_records": 2,
	"records": [{
		"id": 1,
		"ip": "1.1.1.1"
	}, {
		"id": 3,
		"ip": "3.3.3.3"
	}],
	"related_domain_names": [{
		"name": "amet.com",
		"count": 2
	}, {
		"name": "lorem.com",
		"count": 1
	}]
}
```
