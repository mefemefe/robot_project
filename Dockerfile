FROM python:slim-buster

WORKDIR .

COPY ../ .
RUN pip install -r requirements.txt

ENTRYPOINT docker/wait-for-it.sh selenium-hub:4444 -- robot --outputDir /reports --include $FILTER -v BROWSER:$BROWSER -v REMOTE:True tests