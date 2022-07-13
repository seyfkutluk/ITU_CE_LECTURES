- init:
    run: rm -f assignment2
    blocker: true

- build:
    run: gcc -std=c99 -Wall -Werror assignment2.c -o assignment2  # timeout: 2
    blocker: true

- case0:
    run: ./assignment2
    script:
        - expect: "Target: "  # timeout: 2
        - send: "101"
        - expect: "Throw: "                   # timeout: 2
        - send: "18 S"
        - expect: "Points: 101\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "7 T"
        - expect: "Points: 101\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "9 D"
        - expect: "Points: 83\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "1 O"
        - expect: "Points: 58\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "10 T"
        - expect: "Points: 28\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "15 T"
        - expect: "Points: 28\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "12 S"
        - expect: "Points: 16\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "16 S"
        - expect: "Points: 16\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "8 D"
        - expect: "Points: 0\r\n"                   # timeout: 2
    return: 0

- case1:
    run: ./assignment2
    script:
        - expect: "Target: "  # timeout: 2
        - send: "301"
        - expect: "Throw: "                   # timeout: 2
        - send: "1 O"
        - expect: "Points: 301\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "1 I"
        - expect: "Points: 301\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "20 D"
        - expect: "Points: 261\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "20 S"
        - expect: "Points: 241\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "17 S"
        - expect: "Points: 224\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "8 T"
        - expect: "Points: 200\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "1 I"
        - expect: "Points: 150\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "1 O"
        - expect: "Points: 125\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "13 T"
        - expect: "Points: 86\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "8 S"
        - expect: "Points: 78\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "19 T"
        - expect: "Points: 21\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "1 S"
        - expect: "Points: 20\r\n"                   # timeout: 2
        - expect: "Throw: "                   # timeout: 2
        - send: "10 D"
        - expect: "Points: 0\r\n"                   # timeout: 2
    return: 0