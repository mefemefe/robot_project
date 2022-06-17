env:
	python -m venv .venv

install:
	python -m pip install -r requirements.txt

gui:
	export BROWSER=$(BROWSER) && \
	export FILTER=$(FILTER) && \
	docker-compose -f docker/$(BROWSER).yaml up --build -d && \
	docker-compose -f docker/test.yaml up --build && \
	docker-compose -f docker/$(BROWSER).yaml down && \
	docker-compose -f docker/test.yaml down && \
	docker rmi -f $$(docker image ls -a | grep -v "selenium/hub" | grep -v "selenium/node-firefox" | grep -v "selenium/node-edge" | grep -v "selenium/node-chrome" | awk 'NR>1 {print $3}')

api:
	export FILTER=$(FILTER) && \
	docker-compose -f docker/test.yaml up --build

clean:
	rm -r reports
	