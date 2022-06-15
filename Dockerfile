FROM python:slim-buster

WORKDIR /automation

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

ENTRYPOINT robot --outputDir /reports --include $FILTER .