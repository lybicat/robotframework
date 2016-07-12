*** Settings ***
Documentation  test different kind of parallel executions

*** Test Cases ***
Simple Parallel
    Log    Not yet in Parallel
    : PARALLEL
    \    Log    worker-1
    \    Log    worker-2
    Log    Not in Parallel anymore

Complex Parallel
    : PARALLEL
    \    Log    worker-1
    \    Nested Parallel
    \    Log    worker-2

Complex Parallel With Fail
    [Documentation]  FAIL    Here we Fail
    : PARALLEL
    \    Log    worker-1
    \    Nested Parallel With Fail
    \    Log    worker-2

Complex Parallel With Multiple Fail
    [Documentation]    FAIL    Here we Fail
    : PARALLEL
    \    Fail    Here we Fail
    \    Nested Parallel With Fail
    \    Log    worker-2

Parallel Failing 1
    [Documentation]    FAIL    Here we Fail
    : PARALLEL
    \    Log    worker-1
    \    Fail    Here we Fail

Parallel Failing 2
    [Documentation]    FAIL    Here we Fail
    : PARALLEL
    \    Nested Parallel With Fail2
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

Nested Parallel With Fail2
    : PARALLEL
    \    Fail    Here we Fail
    \    Sleep    1s

