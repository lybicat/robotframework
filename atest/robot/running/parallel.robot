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
    Check Log Message    ${tc.kws[0].msgs[0]}    Not yet in Parallel
    Should Be Parallel Keyword  ${tc.kws[1]}    3
    Check Log Message    ${tc.kws[1].kws[0].msgs[0]}    worker-1
    Check Log Message    ${tc.kws[1].kws[1].kws[0].msgs[0]}    worker-1.1
    Check Log Message    ${tc.kws[1].kws[1].kws[1].msgs[0]}    worker-1.2
    Check Log Message    ${tc.kws[1].kws[2].msgs[0]}    worker-2
    Check Log Message    ${tc.kws[2].msgs[0]}    Not in Parallel anymore

*** Keywords ***
Should Be Parallel Keyword
    [Arguments]    ${kw}    ${subcount}
    Should Be Equal    ${kw.type}    parallel    Not PARALLEL keyword
    Should Be Equal As Integers    ${kw.keyword_count}    ${subcount}    Wrong number of sub keywords
