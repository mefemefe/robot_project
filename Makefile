env:
	python -m venv .venv

install:
	python -m pip install -r requirements.txt

test:
	docker-compose up --build && docker-compose down

tag:
	export FILTER=$(FILTER) && make test

test_wa:
	docker-compose up --build && docker cp robot_project_automation_1:/reports . && docker-compose down

clean:
	rm -r reports
	