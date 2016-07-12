*** Settings ***
Suite Setup       Run Tests    ${EMPTY}    running/parallel.robot
Resource          atest_resource.robot

*** Test Cases ***
Simple Parallel
    ${tc} =    Check Test Case    ${TEST NAME}
    Check Log Message    ${tc.kws[0].msgs[0]}    Not yet in Parallel
    Should Be Parallel Keyword  ${tc.kws[1]}    2
    Check Log Message    ${tc.kws[1].kws[0].msgs[0]}    worker-1
    Check Log Message    ${tc.kws[1].kws[1].msgs[0]}    worker-2
    Check Log Message    ${tc.kws[2].msgs[0]}    Not in Parallel anymore

Complex Parallel
    ${tc} =    Check Test Case    ${TEST NAME}
    Should Be Parallel Keyword  ${tc.kws[0]}    3
    Check Log Message    ${tc.kws[0].kws[0].msgs[0]}    worker-1
    Should Be Parallel Keyword  ${tc.kws[0].kws[1]}    2
    Check Log Message    ${tc.kws[0].kws[1].kws[0].msgs[0]}    worker-1.1
    Check Log Message    ${tc.kws[0].kws[1].kws[1].msgs[0]}    worker-1.2
    Check Log Message    ${tc.kws[0].kws[2].msgs[0]}    worker-2

Complex Parallel With Fail
    ${tc} =    Check Test Case  ${TEST NAME}
    Should Be Parallel Keyword  ${tc.kws[0]}    3
    Check Log Message    ${tc.kws[0].kws[0].msgs[0]}    worker-1
    Should Be Parallel Keyword  ${tc.kws[0].kws[1]}    3
    Should Be Equal    ${tc.kws[0].kws[1].status}    FAIL
    Check Log Message    ${tc.kws[0].kws[1].kws[0].msgs[0]}    worker-1.1
    Should Be Equal  ${tc.kws[0].kws[1].kws[1].status}    FAIL
    Check Log Message    ${tc.kws[0].kws[1].kws[2].msgs[0]}    worker-1.2
    Check Log Message    ${tc.kws[0].kws[2].msgs[0]}    worker-2

Complex Parallel With Multiple Fail
    ${tc} =    Check Test Case  ${TEST NAME}
    Should Be Parallel Keyword  ${tc.kws[0]}    3
    Should Be Equal    ${tc.kws[0].kws[0].status}    FAIL
    Should Be Parallel Keyword  ${tc.kws[0].kws[1]}    3
    Should Be Equal    ${tc.kws[0].kws[1].status}    FAIL
    Check Log Message    ${tc.kws[0].kws[1].kws[0].msgs[0]}    worker-1.1
    Should Be Equal  ${tc.kws[0].kws[1].kws[1].status}    FAIL
    Check Log Message    ${tc.kws[0].kws[1].kws[2].msgs[0]}    worker-1.2
    Check Log Message    ${tc.kws[0].kws[2].msgs[0]}    worker-2

Parallel Failing
    ${tc} =    Check Test Case    ${TEST NAME} 1
    Should Be Parallel Keyword    ${tc.kws[0]}    2
    Check Log Message    ${tc.kws[0].kws[0].msgs[0]}    worker-1
    Should Be Equal    ${tc.kws[0].kws[1].status}    FAIL
    ${tc2} =    Check Test Case    ${TEST NAME} 2
    Should Be Parallel Keyword    ${tc2.kws[0]}    2
    Should Be Equal    ${tc2.kws[0].kws[0].status}    FAIL
    Should Be Parallel Keyword    ${tc2.kws[0].kws[0]}    2
    Should Be Equal    ${tc2.kws[0].kws[0].kws[0].status}    FAIL
    Check Log Message    ${tc2.kws[0].kws[0].kws[1].msgs[0]}    Slept 1 second
    Check Log Message    ${tc2.kws[0].kws[1].msgs[0]}    worker-1

*** Keywords ***
Should Be Parallel Keyword
    [Arguments]    ${kw}    ${subcount}
    Should Be Equal    ${kw.type}    parallel    Not PARALLEL keyword
    Should Be Equal As Integers    ${kw.keyword_count}    ${subcount}    Wrong number of sub keywords
