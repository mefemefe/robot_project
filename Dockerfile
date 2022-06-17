FROM python:slim-buster

WORKDIR .

COPY ../ .
RUN pip install -r requirements.txt

ENTRYPOINT robot --outputDir /reports --include $FILTER -v BROWSER:$BROWSER tests