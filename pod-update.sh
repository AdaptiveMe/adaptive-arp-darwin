#!/bin/bash

cd adaptive-arp-impl-ios
pod update --no-integrate

cd ..
cd adaptive-arp-impl-osx
pod update --no-integrate

cd ..
cd adaptive-arp-rt-ios
pod update --no-integrate

cd ..
cd adaptive-arp-rt-osx
pod update --no-integrate
