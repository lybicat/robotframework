*** Settings ***
Suite Setup       Run Tests    ${EMPTY}    running/parallel.robot
Resource          atest_resource.robot

*** Test Cases ***
Simple Parallel
    ${tc} =    Check Test Case    ${TEST NAME}
    Check Log Message    ${tc.kws[0].msgs[0]}    Not yet in Parallel

