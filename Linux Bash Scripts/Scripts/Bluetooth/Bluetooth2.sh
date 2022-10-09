#!/bin/bash
bluetoothctl disconnect 00:1A:7D:DA:71:10
sleep 0.7
bluetoothctl trust 00:1A:7D:DA:71:10;
bluetoothctl connect 00:1A:7D:DA:71:10


