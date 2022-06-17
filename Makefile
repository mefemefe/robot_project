env:
	python -m venv .venv

install:
	python -m pip install -r requirements.txt

gui_ch:
	docker-compose -f docker/docker-compose.chrome.yaml up --build

gui_ed:
	docker-compose -f docker/docker-compose.edge.yaml up --build

gui_ff:
	docker-compose -f docker/docker-compose.firefox.yaml up --build

down_ch:
	docker-compose -f docker/docker-compose.chrome.yaml down

down_ed:
	docker-compose -f docker/docker-compose.edge.yaml down

down_ff:
	docker-compose -f docker/docker-compose.firefox.yaml down

down_api:
	docker-compose -f docker/docker-compose.yaml down

report:
	docker cp automation:/reports .

tag_ch:
	export FILTER=$(FILTER) && make test_ch

tag_ed:
	export FILTER=$(FILTER) && make test_ed

tag_ff:
	export FILTER=$(FILTER) && make test_ff

api:
	docker-compose -f docker/docker-compose.yaml up --build && docker cp automation:/reports . && docker-compose -f docker/docker-compose.yaml down

api_tag:
	export FILTER=$(FILTER) && make api

clean:
	rm -r reports
	