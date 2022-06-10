*** Settings ***

Resource     ../../core/keywords/key.robot
Resource     ../../core/variables/var.robot

*** Test Cases ***
Example Test
    Log something    ${var}