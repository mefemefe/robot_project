
# TRELLO - Robot Framework

Trello's API and GUI Test Automation project using Robot Framework.


## Environment Variables

To run this project, you will need to have the following environment variables

`TRELLO_APIKEY`
`TRELLO_TOKEN`
[(get them here)](https://trello.com/app-key)

`TRELLO_EMAIL`
`TRELLO_PASSWORD`

#### For Docker

`FILTER=<tag_pattern>`

`REMOTE=True` (REMOTE is False by default, it is needed to be True for running with selenium containers. When using the 'make gui' command it will be set to True automatically)

#### Both Local & Docker

`BROWSER=<chrome, firefox or edge>`

It is recommended to have a .env file with these environment variables so that docker-compose can read them directly.


### Requires

*Python >= 3.6   (with pip)*
## Run Locally

- **Clone** the project

```bash
  git clone https://github.com/mefemefe/robot_project.git
```

- **Recommended:** Set up a Virtual Environment

```bash
  python -m venv <env_name>
  source <env_name>/Scripts/activate 
```

- **Install dependencies**

```bash
  pip install -r requirements.txt
```

- **Set up the Environment Variables** described in the "Environment Variables"  section of this readme.

- Run tests using **'robot' + the path** to your .robot file, or folder containing .robot files

```bash
  robot <path>
```
- Or using **--include** to run by tags (also include a path, it can be specific or use '.' to search in all subfolders)

```bash
  robot --include smoke .
```

## Using make
Create a virtual environment
```bash
  make env
```
Install requirements
```bash
  make install
```
Run gui tests on a docker container with a tag and a browser
(BROWSER needs to be one of the following case-sensitive words for now: 'chrome', 'firefox', 'edge')
```bash
  make gui BROWSER=<browser_name> FILTER=<tag_pattern>
```
Run api tests on a docker container with a tag
```bash
  make api FILTER=<tag_pattern>
```
## Authors

- [@mefemefe](https://github.com/mefemefe)
- [@nicolasvallejo13](https://github.com/nicolasvallejo13)
- [@trab2](https://github.com/trab2)


#

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
