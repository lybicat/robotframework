*** Settings ***
Documentation  test different kind of parallel executions

*** Test Cases ***
Simple Parallel
    Log    Not yet in Parallel
    : PARALLEL
    \    Log    worker-1
    \    Nested Parallel
    \    Log    worker-2
    Log    Not in Parallel anymore

*** Keywords ***
Nested Parallel
    : PARALLEL
    \    Log    worker-1.1
    \    Log    worker-1.2