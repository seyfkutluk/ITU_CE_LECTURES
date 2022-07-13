- init:
    run: rm -f assignment3
    blocker: true

- build:
    run: gcc -std=c99 -Wall -Werror assignment3.c -o assignment3  # timeout: 2
    blocker: true

- case0:
    run: ./assignment3
    script:
        - expect: "Size: " 
        - send: "5"
        - expect: "Cars: "                   
        - send: "5"
        - expect: "Locations: "               
        - send: "1 1"
        - expect: "Locations: "                
        - send: "2 2"
        - expect: "Locations: "              
        - send: "3 2"
        - expect: "Locations: "               
        - send: "4 2"
        - expect: "Locations: "                
        - send: "5 2"
        - expect: "Best Slot Found In: 1 5\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0
    
- case1:  #park dolu ise (slot sayısı = araba sayısı)
    run: ./assignment3
    script:
        - expect: "Size: "  
        - send: "3"
        - expect: "Cars: "                  
        - send: "9"
        - expect: "Best Slot Found In: 0 0\r\n"  
        - expect: _EOF_  
    return: 0

- case2:  #parkta hiç araba yoksa
    run: ./assignment3
    script:
        - expect: "Size: " 
        - send: "3"
        - expect: "Cars: "                  
        - send: "0"
        - expect: "Best Slot Found In: 1 1\r\n" 
        - expect: _EOF_ 
    return: 0

- case3: # slotun dışına yerleştirmeye çalışırsa(4,5)
    run: ./assignment3
    script:
        - expect: "Size: " 
        - send: "4"
        - expect: "Cars: "                   
        - send: "2"
        - expect: "Locations: "               
        - send: "1 1"
        - expect: "Locations: "                
        - send: "4 5"
        - expect: "Best Slot Found In: 4 4\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0

- case4:
    run: ./assignment3
    script:
        - expect: "Size: " 
        - send: "51"
        - expect: "max size must be 50"
        - expect: "Size: " 
        - send: "4"
        - expect: "Cars: "                   
        - send: "3"
        - expect: "Locations: "               
        - send: "1 1"
        - expect: "Locations: "                
        - send: "3 3"
        - expect: "Locations: "              
        - send: "4 4"
        - expect: "Best Slot Found In: 1 4\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0