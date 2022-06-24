env:
	python -m venv .venv

install:
	python -m pip install -r requirements.txt

gui:
	export BROWSER=$(BROWSER) && \
	export FILTER=$(FILTER) && \
	docker-compose -f docker/hub.yaml up -d && \
	docker-compose -f docker/$(BROWSER).yaml up -d && \
	docker-compose -f docker/gui_test.yaml up --build && \
	docker-compose -f docker/gui_test.yaml stop && \
	docker-compose -f docker/hub.yaml stop && \
	docker-compose -f docker/$(BROWSER).yaml down && \
	docker rm -f $$(docker ps -a -q) && \
	docker rmi docker_automation:latest

api:
	export FILTER=$(FILTER) && \
	docker-compose -f docker/api_test.yaml up --build && \
	docker-compose -f docker/api_test.yaml down && \
	docker rmi docker_automation:latest

clean:
	rm -r reports
	