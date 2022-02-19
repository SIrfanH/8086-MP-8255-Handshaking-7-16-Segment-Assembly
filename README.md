# 8086-MP-8255-Handshaking-7-16-Segment-Assembly
This Assembly program and Circuit is designed to implement a simple 1 bit calculator and demostrating handshaking in 8255 IC. The circuit uses a 7 segment display for displating calculation results, a 16 segment display for showing right or wrong results and a keypad for getting user input.
## Circuit Design Logic
In this circuit the keypad that takes user input and a 7 segment display that shows results are connected to the first 8255 which is in handshaking data input-output mode (Mode 1). This 8255 IC is connected to 8086 MP starting from the address 200H and to consecutive even number addresses. A 16 segment display is connected to both Port A and B of the second 8255 which is operating in mode 0 and the 8255 is connected to 8086 MP from address 60H and its consecutive even number addresses. Both the 7 and 16 segment display are common cathod.<br/>

## Flow Logic
When a user enters a value using the keypad the 8255 takes the value using handshaking mode and then prints it on 7 segment display. The user selects an operation then 8255 gets the operation and prints 0 on the 7 segment using handshaking. When the second operand is given by the user data is read using handshaking and the operations are calcualted then displayed in 7 segment display. The handshaking mode is used extensively for these operations. <br/>

When the operations are calculated since it is a 1-bit calculator the needed checks are also done at the same time when the result is shown correctly on the 7 segment display the 16 segment display shows a message "ONAY"(Confirmed) with a delay between letters. When the result is wrong then the 16 segment display shows "HATA"(Error) message to the user.
## Schema
<p align="center">
  <img src="https://user-images.githubusercontent.com/49107892/154812469-2e2406b8-7ad8-4977-ab84-18bd863ecf7f.SVG" width="1080">  
</p>

## Demostration
<p align="center">
  <img src="https://user-images.githubusercontent.com/49107892/154812578-e44b5f15-0574-4bf4-982c-2b8b29024cf8.gif" width="1080">  
</p>
