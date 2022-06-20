env:
	python -m venv .venv

install:
	python -m pip install -r requirements.txt

gui:
	export BROWSER=$(BROWSER) && \
	export FILTER=$(FILTER) && \
	docker-compose -f docker/hub.yaml up -d && \
	docker-compose -f docker/$(BROWSER).yaml up -d && \
	docker-compose -f docker/test.yaml up --build && \
	docker-compose -f docker/test.yaml stop && \
	docker-compose -f docker/hub.yaml stop && \
	docker-compose -f docker/$(BROWSER).yaml down && \
	docker rm -f $$(docker ps -a -q)
# TODO : docker prune?

api:
	export FILTER=$(FILTER) && \
	docker-compose -f docker/test.yaml up --build

clean:
	rm -r reports
	