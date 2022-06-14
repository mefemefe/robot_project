
# TRELLO - Robot Framework

Trello's API and GUI Test Automation project using Robot Framework.


### Environment Variables

To run this project, you will need to have the following environment variables

`TRELLO_APIKEY`
`TRELLO_TOKEN`
[(get them here)](https://trello.com/app-key)



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
- Or using **--include** to run by tags (can also include a path or use '.' to run all)

```bash
  robot --include smoke .
```
## Authors

- [@mefemefe](https://github.com/mefemefe)
- [@nicolasvallejo13](https://github.com/nicolasvallejo13)
- [@trab2](https://github.com/trab2)


#

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
