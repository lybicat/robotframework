*** Settings ***
Documentation  test different kind of parallel executions

*** Test Cases ***
Simple Parallel
    Log    Not yet in Parallel
    : PARALLEL
    \    Log    worker-1
    \    Log    worker-2
    Log    Not in Parallel anymore
