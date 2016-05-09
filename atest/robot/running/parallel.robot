*** Settings ***
Suite Setup       Run Tests    ${EMPTY}    running/parallel.robot
Resource          atest_resource.robot

*** Test Cases ***
Simple Parallel
    ${tc} =    Check Test Case    ${TEST NAME}
    Check Log Message    ${tc.kws[0].msgs[0]}    Not yet in Parallel
    Should Be For Keyword    ${tc.kws[1]}    2
    Should Be For Item    ${tc.kws[1].kws[0]}    \${var} = one
    Check Log Message    ${tc.kws[1].kws[0].kws[0].msgs[0]}    var: one
    Should Be For Item    ${tc.kws[1].kws[1]}    \${var} = two
    Check Log Message    ${tc.kws[1].kws[1].kws[0].msgs[0]}    var: two
    Check Log Message    ${tc.kws[2].msgs[0]}    Not in For anymore
    ${tc2} =    Check Test Case    ${TEST NAME} 2
    Should Be For Keyword    ${tc2.kws[0]}    6
    Test "Simple For 2" Helper    ${tc2.kws[0].kws[0]}    1
    Test "Simple For 2" Helper    ${tc2.kws[0].kws[1]}    2
    Test "Simple For 2" Helper    ${tc2.kws[0].kws[2]}    3
    Test "Simple For 2" Helper    ${tc2.kws[0].kws[3]}    4
    Test "Simple For 2" Helper    ${tc2.kws[0].kws[4]}    5
    Test "Simple For 2" Helper    ${tc2.kws[0].kws[5]}    6

