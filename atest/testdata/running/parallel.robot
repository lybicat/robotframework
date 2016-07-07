*** Settings ***
Documentation  test different kind of parallel executions

*** Test Cases ***
Simple Parallel
    Log    Not yet in Parallel
    : PARALLEL
    \    Log    worker-1
    \    Log    worker-2
    Log    Not in Parallel anymore

Complex Parallel With Fail
    Log    Not yet in Parallel
    : PARALLEL
    \    Log    worker-1
    \    Nested Parallel With Fail
    \    Log    worker-2
    Log    Not in Parallel anymore

Complex Parallel
    Log    Not yet in Parallel
    : PARALLEL
    \    Log    worker-1
    \    Nested Parallel
    \    Log    worker-2
    Log    Not in Parallel anymore

Complex Parallel With Multiple Fail
    Log    Not yet in Parallel
    : PARALLEL
    \    Fail    Here we Fail
    \    Nested Parallel With Fail
    \    Log    worker-2
    Log    Not in Parallel anymore

Parallel Failing 1
    : PARALLEL
    \    Log    worker-1
    \    Fail    Here we Fail

Parallel Failing 2
    : PARALLEL
    \    Fail    Here we Fail
    \    Log    worker-1

*** Keywords ***
Nested Parallel
    : PARALLEL
    \    Log    worker-1.1
    \    Log    worker-1.2

Nested Parallel With Fail
    : PARALLEL
    \    Log    worker-1.1
    \    Fail    Here we Fail
    \    Log    worker-1.2