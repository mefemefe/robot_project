
# TRELLO - Robot Framework

Trello's API and GUI Test Automation project using Robot Framework.


### Environment Variables

To run this project, you will need to have the following environment variables

`TRELLO_APIKEY`
`TRELLO_TOKEN`
[(get them here)](https://trello.com/app-key)

`TRELLO_USER`
`TRELLO_PASSWORD`

For Docker
`PYTHONPATH=/automation/tests`
`FILTER=<tag_pattern>`

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

### Using make
Create a virtual environment
```bash
  make env
```
Install requirements
```bash
  make install
```
Run tests on a docker container with a tag defined on a FILTER environment variable
```bash
  make test
```
Run tests on a docker container with a tag
```bash
  make tag FILTER=<tag_pattern>
```
## Authors

- [@mefemefe](https://github.com/mefemefe)
- [@nicolasvallejo13](https://github.com/nicolasvallejo13)
- [@trab2](https://github.com/trab2)


#

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
