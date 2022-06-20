from dotenv import dotenv_values
from os import getenv, path, getcwd


def get_variables(*required: str):
    """If an environment variable is Required it should be passed as 
    an argument when import this file as a Variables file.
    The function will prioritize variables in the '.env' file at the 
    current working directory, if not found it will look in the
    current env.
    The Variables set in the global scope by this function 
    will have the same name as the keys in the .env file or current environment."""
    dot_env = dotenv_values(path.join(getcwd(), ".env"))
    variables = {}
    if required:
        for var in required:
            if var not in dot_env.keys():
                exists = getenv(var)
                if exists:
                    variables[var] = exists
    if dot_env:
        for item in dot_env.items():
            variables[item[0]] = item[1]
    return variables
