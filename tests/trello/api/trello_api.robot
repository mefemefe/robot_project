*** Settings ***

Resource     ../../common/keywords/key.robot
Resource     ../../common/variables/var.robot

*** Test Cases ***
Example Test
    Log something    ${var}