# Adaptive Runtime Platform for iOS / OSX 
[![Build Status](https://travis-ci.org/AdaptiveMe/adaptive-arp-darwin.svg?branch=master)](https://travis-ci.org/AdaptiveMe/adaptive-arp-darwin)
[![GitHub tag](https://img.shields.io/github/tag/AdaptiveMe/adaptive-arp-darwin.svg)](https://github.com/AdaptiveMe/adaptive-arp-darwin) 
[![License](https://img.shields.io/badge/license-apache%202-blue.svg)](https://raw.githubusercontent.com/AdaptiveMe/adaptive-arp-api/master/LICENSE) 
[![Adaptive Runtime Platform for iOS/OSX](https://img.shields.io/badge/arp-ios/osx-cccccc.svg)](https://github.com/AdaptiveMe/adaptive-arp-darwin)
[![adaptive.me](https://img.shields.io/badge/adaptive-me-fdcb0e.svg)](http://adaptive.me)
[![Adaptive Runtime Platform](https://raw.githubusercontent.com/AdaptiveMe/AdaptiveMe.github.io/master/assets/logos/normal/arp_for_iOS.png)](#)

## Introduction

### About This Project

The Adaptive Runtime Platform for Darwin is the Native Layer for deploying Adaptive HTML5 project on Apple devices (iOS & OSX). This layers provides to HTML5 apps all the interfaces and methods for using all the native functionalities for Darwin devices.

#### Project Specifications

ARP for Darwin is configued for **iOS Devices** (>=8.0) and **OSX Machines** (>=10.10)

### About Adaptive Runtime Platform

Hybrid apps are applications that are built using HTML5/CSS3/JavaScript web technologies and use a native "containers" to package the app to enable access to the native functionalities of a device. In essence, you can write a rich mobile/wearable/tv application using HTML and JavaScript and package that application as a native app for multiple mobile/wearable/tv platforms and distribute them on the different app stores and markets.

The Adaptive Runtime Platform (ARP) provides these native "containers" to package apps for the main mobile, wearable and desktop platforms... and other platforms as they emerge. Adaptive Runtime Platform (ARP) and sub-projects are open-source under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html). The Adaptive Runtime Platform (ARP) project was created by [Carlos Lozano Diez](https://github.com/carloslozano) as part of the [adaptive.me](http://adaptive.me) set of products.

Please refer to the [project site](http://adaptiveme.github.io) for more information.

### Project Structure

The Darwin Runtime Platform is composed by a set of files and libraries

```
adaptive-arp-rt (Project & Build Settings)
├── App 
│   │   apppack.realm (Encrypted/Compressed file with app resources)
├── App.Source
│   ├── assets (Graphical Assets)
│   ├── config (App Configuration files)
│   ├── www (HTML5 application)
├── AdaptiveArpRtiOS (AppDelegates & ViewControllers)
├── AdaptiveArpRtiOSTests (Unit Tests)
├── Frameworks (Result Frameworks)
├── Pods (CocoaPods configuration)
├── Products (Result products)
├── Sources.Common
│   ├── Compression (Compression utility classes)
│   ├── Core (Core Platform classes)
│   ├── Resources (Resource utility readers)
│   ├── StreamUtils (Stream extensions)
│   ├── Utils (Utility classes)
├── Sources.Impl (Implementation of ARP Bridges)
Pods (CocoaPods project)
```
## Set-Up Environment

### Prerequisites

- **[XCode](https://developer.apple.com/xcode/)** >= 7.0.1 (7A1001) with **[Swift](https://developer.apple.com/swift/)** 2.1 for compiling the project and building the application
- **[CocoaPods](https://cocoapods.org/)** >= 0.39 Dependency manager for Swift. For installing cocoapods just follow the instructions provided [here](https://cocoapods.org/#install)

### Importing the project

1. _Clone_ or _Fork_ this project into your machine
2. Open a terminal and run:
  ```git submodule update --init --recursive```
3. Open a terminal in the the **adaptive-arp-rt** folder where the **Podfile** is located and run:
  ``` pod install```
4. Open the **adaptive-arp-rt.xcworkspace** file with Xcode and Run the **AdaptiveArpiOs -> iOS Device** target into the simulator or a plugged device.

## Work Backlog

#### Board: [![Stories in Ready](https://badge.waffle.io/AdaptiveMe/adaptive-arp-darwin.svg?label=ready&title=Ready)](https://waffle.io/AdaptiveMe/adaptive-arp-darwin)

[![Throughput Graph](https://graphs.waffle.io/AdaptiveMe/adaptive-arp-darwin/throughput.svg)](https://waffle.io/AdaptiveMe/adaptive-arp-darwin/metrics)

## Contributing

We'd *love to accept your patches and contributions to this project*.  There are a just a few small guidelines you need to follow to ensure that you and/or your company and our project are safeguarded from inadvertent copyright infringement. I know, this can be a pain but we want fair-play from the very start so that we're all on the same page. Please refer to the [project site](http://adaptiveme.github.io) for more information.

## Attributions

* Adaptive Runtime Platform (ARP) artwork by [Jennifer Lasso](https://github.com/Jlassob).
* Project badge artwork by [shields.io](http://shields.io/).
* All other logos are copyright of their respective owners.

## License
All the source code of the Adaptive Runtime Platform (ARP), including all Adaptive Runtime Platform (ARP) sub-projects curated by [Carlos Lozano Diez](https://github.com/carloslozano), are distributed, and must be contributed to, under the terms of the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html). The [license](https://raw.githubusercontent.com/AdaptiveMe/adaptive-arp-api/master/LICENSE) is included in this [repository](https://raw.githubusercontent.com/AdaptiveMe/adaptive-arp-api/master/LICENSE).

Forged with :heart: in Barcelona, Catalonia · © 2013 - 2015 [adaptive.me](http://adaptive.me) / [Carlos Lozano Diez](http://google.com/+CarlosLozano).

