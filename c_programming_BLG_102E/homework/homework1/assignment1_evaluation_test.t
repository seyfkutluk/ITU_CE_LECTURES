- init:
    run: rm -f assignment
    blocker: true

- build:
    run: gcc -std=c99 -Wall -Werror assignment.c -o assignment  # timeout: 1
    blocker: true

- case0_1900_1_1_1999:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1900 1 1"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "1999"
        - expect: "[ \r\n]*It's a Monday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 1901 and 1999:[ \r\n]*14[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0

- case0_invalid_11_31:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "2018 11 31"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1

- case1_1868_11_13_2018:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1868 11 13"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "2018"
        - expect: "[ \r\n]*It's a Friday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 1869 and 2018:[ \r\n]*21[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0

- case1_1582_2_24_2018:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1582 2 24"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "2018"
        - expect: "[ \r\n]*It's a Wednesday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 1583 and 2018:[ \r\n]*63[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0

- case1_330_5_11_1453:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "330 5 11"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "1453"
        - expect: "[ \r\n]*It's a Sunday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 331 and 1453:[ \r\n]*160[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0

- case1_1444_11_10_1921:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1444 11 10"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "1921"
        - expect: "[ \r\n]*It's a Sunday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 1445 and 1921:[ \r\n]*68[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0

- case1_722_1_2_1492:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "722 1 2"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "1492"
        - expect: "[ \r\n]*It's a Monday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 723 and 1492:[ \r\n]*111[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0

- case2_invalid_2_30:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1495 2 30"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1

- case2_invalid_4_31:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1713 4 31"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1

- case2_invalid_6_31:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "546 6 31"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1    
    
- case2_invalid_9_31:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1162 9 31"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1

- case2_invalid_11_31:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1215 11 31"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1    
    
- case2_invalid_negative_1:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1918 -3 31"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1
    
- case2_invalid_negative_2:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1895 5 -11"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1
    
- case2_invalid_negative_3:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "742 -3 -32"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1    
    
- case2_invalid_other:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1770 15 42"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1    

- case2_invalid_other2:
    run: ./assignment
    points: 2
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1756 7 0"
        - expect: "[ \r\n]*[Ii]nvalid[ ]*[Dd]ate[. ]*[ \r\n]*"                  # timeout: 1
        - expect: _EOF_                                # timeout: 1
    return: 1

- case3_0_1_1_2018:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "0 1 1"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "2018"
        - expect: "[ \r\n]*It's a Sunday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 1 and 2018:[ \r\n]*293[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0

- case3_1993_3_10_2018:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1993 3 10"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "2018"
        - expect: "[ \r\n]*It's a Wednesday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 1994 and 2018:[ \r\n]*3[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0

- case3_1993_3_10_2021:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1993 3 10"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "2021"
        - expect: "[ \r\n]*It's a Wednesday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 1994 and 2021:[ \r\n]*4[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0

- case3_1999_8_17_2070:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1999 8 17"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "2070"
        - expect: "[ \r\n]*It's a Tuesday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 2000 and 2070:[ \r\n]*10[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0    
    
- case3_1546_7_4_5000:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1546 7 4"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "5000"
        - expect: "[ \r\n]*It's a Thursday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 1547 and 5000:[ \r\n]*491[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0    

- case3_1526_8_28_3000:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "1526 8 28"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "3000"
        - expect: "[ \r\n]*It's a Saturday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 1527 and 3000:[ \r\n]*206[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0
    
- case3_200_12_31_2000:
    run: ./assignment
    points: 6
    script:
        - expect: "[ \r\n]*[Ee]nter [Dd]ate \\[[Yy]ear[ ]*[Mm]onth[ ]*[Dd]ay\\]:[ \r\n]*"  # timeout: 1
        - send: "200 12 31"
        - expect: "[ \r\n]*[Ee]nter[ ]*[Ee]nd[ ]*[Yy]ear[ ]*:[ \r\n]*"                   # timeout: 1
        - send: "2000"
        - expect: "[ \r\n]*It's a Wednesday[. ]*[ \r\n]*"                 # timeout: 1
        - expect: "[ \r\n]*[Ss]ame[ ]*[Dd]ay[- ]*[Aa]nd[- ]*[Mm]onth[ ]*[Oo]n[ ]*[Ss]ame[ ]*[Ww]eekday[ ]*[Bb]etween 201 and 2000:[ \r\n]*255[ \r\n]*"  # timeout: 1
        - expect: _EOF_  # timeout: 1
    return: 0