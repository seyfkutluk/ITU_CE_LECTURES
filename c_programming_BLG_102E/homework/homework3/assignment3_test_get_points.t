- init:
    run: rm -f assignment3
    blocker: true

- build:
    run: gcc -std=c99 -Wall -Werror  assignment.c -o assignment3  # timeout: 2
    blocker: true

- case0: #1. Size'ın 1 ile 50 arasında olması 
    run: ./assignment3
    points: 2
    script:
        - expect: "Size: " # timeout: 2
        - send: "51"
        - expect: "Size must be between 50 and 1"# timeout: 2
        - expect: "Size: " # timeout: 2
        - send: "4"
        - expect: "Cars: "      # timeout: 2             
        - send: "3"
        - expect: "Locations: "   # timeout: 2            
        - send: "1 1"
        - expect: "Locations: "    # timeout: 2            
        - send: "3 3"
        - expect: "Locations: "    # timeout: 2          
        - send: "4 4"
        - expect: "Best Slot Found In: 1 4\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0

- case1:  #2. park dolu ise (slot sayısı = araba sayısı)
    run: ./assignment3
    points: 12
    script:
        - expect: "Size: "  # timeout: 2
        - send: "3"
        - expect: "Cars: "     # timeout: 2             
        - send: "9"
        - expect: "Best Slot Found In: 0 0\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0

- case2: #3. tek boş yer olursa
    run: ./assignment3
    points: 12
    script:
        - expect: "Size: " # timeout: 2
        - send: "2"
        - expect: "Cars: "         # timeout: 2          
        - send: "3"
        - expect: "Locations: "  # timeout: 2             
        - send: "1 1"
        - expect: "Locations: "  # timeout: 2              
        - send: "2 1"
        - expect: "Locations: "      # timeout: 2          
        - send: "1 2"
        - expect: "Best Slot Found In: 2 2\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0

- case3:  #4. parkta hiç araba yoksa
    run: ./assignment3
    points: 12
    script:
        - expect: "Size: " # timeout: 2
        - send: "3"
        - expect: "Cars: "     # timeout: 2             
        - send: "0"
        - expect: "Best Slot Found In: 1 1\r\n" # timeout: 2
        - expect: _EOF_ # timeout: 2
    return: 0

- case4: #5. test dosyasında öğrencilere verdiğimiz örnek 
    run: ./assignment3
    points: 12
    script:
        - expect: "Size: " # timeout: 2
        - send: "5"
        - expect: "Cars: "    # timeout: 2               
        - send: "5"
        - expect: "Locations: "   # timeout: 2            
        - send: "1 1"
        - expect: "Locations: "    # timeout: 2            
        - send: "2 2"
        - expect: "Locations: "     # timeout: 2         
        - send: "3 2"
        - expect: "Locations: "     # timeout: 2          
        - send: "4 2"
        - expect: "Locations: "      # timeout: 2          
        - send: "5 2"
        - expect: "Best Slot Found In: 1 5\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0

- case5: #10. case 4'e benzer bir örnek
    run: ./assignment3
    points: 12
    script:
        - expect: "Size: " # timeout: 2
        - send: "6"
        - expect: "Cars: "     # timeout: 2              
        - send: "9"
        - expect: "Locations: "   # timeout: 2            
        - send: "1 4"
        - expect: "Locations: "   # timeout: 2             
        - send: "1 6"
        - expect: "Locations: "   # timeout: 2           
        - send: "2 1"
        - expect: "Locations: "  # timeout: 2             
        - send: "3 3"
        - expect: "Locations: "  # timeout: 2              
        - send: "3 5"
        - expect: "Locations: "  # timeout: 2              
        - send: "5 1"
        - expect: "Locations: "  # timeout: 2              
        - send: "5 4"
        - expect: "Locations: "   # timeout: 2             
        - send: "5 6"
        - expect: "Locations: "    # timeout: 2            
        - send: "6 2"
        - expect: "Best Slot Found In: 1 2\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0

- case6: #6. eşit durum da küçük x'i seç
    run: ./assignment3
    points: 12
    script:
        - expect: "Size: " # timeout: 2
        - send: "3"
        - expect: "Cars: "    # timeout: 2               
        - send: "1"
        - expect: "Locations: "   # timeout: 2            
        - send: "2 3"
        - expect: "Best Slot Found In: 1 1\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0

- case7: #7. x ler aynı ise küçüy y seç
    run: ./assignment3
    points: 12
    script:
        - expect: "Size: " # timeout: 2
        - send: "3"
        - expect: "Cars: "  # timeout: 2                 
        - send: "1"
        - expect: "Locations: "  # timeout: 2             
        - send: "3 2"
        - expect: "Best Slot Found In: 1 1\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0

- case8: #8. büyük size sahip örnek
    run: ./assignment3
    points: 12
    script:
        - expect: "Size: " # timeout: 2
        - send: "6"
        - expect: "Cars: "     # timeout: 2              
        - send: "3"
        - expect: "Locations: "  # timeout: 2             
        - send: "36 36"
        - expect: "Locations: "    # timeout: 2           
        - send: "36 35"
        - expect: "Locations: "     # timeout: 2          
        - send: "35 36"
        - expect: "Best Slot Found In: 1 1\r\n"  # timeout: 2
        - expect: _EOF_  # timeout: 2
    return: 0
    
- case9:  #9. boş yerden fazla araba koymak isterse 
    run: ./assignment3
    points: 2
    script:
        - expect: "Size: "  # timeout: 2
        - send: "3"
        - expect: "Cars: "     # timeout: 2             
        - send: "10"
        - expect: "Best Slot Found In: 0 0\r\n"  # timeout: 2
        - expect: _EOF_   # timeout: 2
    return: 0

