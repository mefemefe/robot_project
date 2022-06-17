env:
	python -m venv .venv

install:
	python -m pip install -r requirements.txt

test:
	docker-compose up --build

down:
	docker-compose down

report:
	docker cp automation:/reports .

tag:
	export FILTER=$(FILTER) && make test

test_api:
	docker-compose up --build && docker cp automation:/reports . && docker-compose down

clean:
	rm -r reports
	