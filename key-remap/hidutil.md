# Key remapping with `hidutil`

## Resources
[Guide on how to remap Keyboard keys on macOS](https://gist.github.com/paultheman/808be117d447c490a29d6405975d41bd) (2024)

[macOS function key remapping with hidutil - nanoANT](https://www.nanoant.com/mac/macos-function-key-remapping-with-hidutil) (2019)


This is what he gives

```
$ ioreg -l|grep FnFunctionUsageMap|grep -Eo 0x[0-9a-fA-F]+,0x[0-9a-fA-F]+
0x0007003a,0xff010021 # F1
0x0007003b,0xff010020 # F2
0x0007003c,0xff010010 # F3
0x0007003d,0xff010002 # F4
0x00070040,0x000C00B4 # F7
0x00070041,0x000C00CD # F8
0x00070042,0x000C00B3 # F9
0x00070043,0x000C00E2 # F10
0x00070044,0x000C00EA # F11
0x00070045,0x000C00E9 # F12
```
`
```sh
# Right Command -> Right Alt
# Fn+F3-F4,F7-F10 <-> F3-F4,F7-F10 on Apple Magic Keyboard gen 1
hidutil property --set '{"UserKeyMapping":[
{"HIDKeyboardModifierMappingSrc":0x0007000000e7,
 "HIDKeyboardModifierMappingDst":0x0007000000e6}, // Right Command -> Right Alt

{"HIDKeyboardModifierMappingSrc":0x00070000003c,
 "HIDKeyboardModifierMappingDst":0xff0100000010}, // F3
{"HIDKeyboardModifierMappingSrc":0xff0100000010,
 "HIDKeyboardModifierMappingDst":0x00070000003c}, // F3

{"HIDKeyboardModifierMappingSrc":0x00070000003d,
 "HIDKeyboardModifierMappingDst":0xff0100000002}, // F4
{"HIDKeyboardModifierMappingSrc":0xff0100000002,
 "HIDKeyboardModifierMappingDst":0x00070000003d}, // F4

{"HIDKeyboardModifierMappingSrc":0x000700000040,
 "HIDKeyboardModifierMappingDst":0x000C000000B4}, // F7
{"HIDKeyboardModifierMappingSrc":0x000C000000B4,
 "HIDKeyboardModifierMappingDst":0x000700000040}, // F7

{"HIDKeyboardModifierMappingSrc":0x000700000041,
 "HIDKeyboardModifierMappingDst":0x000C000000CD}, // F8
{"HIDKeyboardModifierMappingSrc":0x000C000000CD,
 "HIDKeyboardModifierMappingDst":0x000700000041}, // F8

{"HIDKeyboardModifierMappingSrc":0x000700000042,
 "HIDKeyboardModifierMappingDst":0x000C000000B3}, // F9
{"HIDKeyboardModifierMappingSrc":0x000C000000B3,
 "HIDKeyboardModifierMappingDst":0x000700000042}, // F9

{"HIDKeyboardModifierMappingSrc":0x000700000043,
 "HIDKeyboardModifierMappingDst":0x000C000000E2}, // F10
{"HIDKeyboardModifierMappingSrc":0x000C000000E2,
 "HIDKeyboardModifierMappingDst":0x000700000043}, // F10

{"HIDKeyboardModifierMappingSrc":0x000700000044,
 "HIDKeyboardModifierMappingDst":0x000C000000EA}, // F11
{"HIDKeyboardModifierMappingSrc":0x000C000000EA,
 "HIDKeyboardModifierMappingDst":0x000700000044}, // F11

{"HIDKeyboardModifierMappingSrc":0x000700000045,
 "HIDKeyboardModifierMappingDst":0x000C000000E9}, // F12
{"HIDKeyboardModifierMappingSrc":0x000C000000E9,
 "HIDKeyboardModifierMappingDst":0x000700000045}, // F12
]}'
```

On a Macbook Pro M4 I have a slightly different output:


```
ioreg -l | rg '"Fn'  
    | |   |         +-o keyboard  <class AppleHIDTransportInterface, id 0x100000ba8, registered, matched, active, busy 0 (660 ms), retain 10>
    | |   |         | |   "InterfaceName" = "keyboard"
    | |   |         | +-o AppleHIDTransportHIDDevice  <class AppleHIDTransportHIDDevice, id 0x100000ba9, registered, matched, active, busy 0 (659 ms), retain 10>
    | |   |         |   |   "Product" = "Apple Internal Keyboard / Trackpad"
    | |   |         |   +-o IOHIDInterface  <class IOHIDInterface, id 0x100000bb3, registered, matched, active, busy 0 (621 ms), retain 9>
    | |   |         |   | +-o AppleHIDKeyboardEventDriverV2  <class AppleHIDKeyboardEventDriverV2, id 0x100000bc1, registered, matched, active, busy 0 (153 ms), retain 8>

    | |   |         |   |   |   "FnKeyboardUsageMap" = "0x00070050,0x0007004a,0x00070052,0x0007004b,0x0007002a,0x0007004c,0x0007004f,0x0007004d,0x00070051,0x0007004e,0x00070028,0x00070058"
    | |   |         |   |   |   "FnFunctionUsageMap" = "0x0007003a,0x00ff0005,0x0007003b,0x00ff0004,0x0007003c,0xff010010,0x0007003d,0x000c0221,0x0007003e,0x000c00cf,0x0007003f,0x0001009b,0x00070040,0x000c00b4,0x00070041,0x000c00cd,0x00070042,0x000c00b3,0x00070043,0x000c00e2,0x00070044,0x000c00ea,0x00070045,0x000c00e9"
    | |   |         |   |   |   "FnFunctionTable" = {"no-fn-cl"=<1616>,"fn"=<010602070311041905180617070a080c090b0a0d0b0e0c0f>,"fn-cl"=<010602070311041905180617070a080c090b0a0d0b0e0c0f1616>,"fn-right-to-left"=<010702060311041905180617070a080c090b0a0f0b0e0c0d>}
    | |   |         |   |   |   "FnModifierUsage" = 3
    | |   |         |   |   |   "FnModifierUsagePage" = 255
```