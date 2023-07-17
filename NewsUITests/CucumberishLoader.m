//
//  CucumberishLoader.m
//  WeatherCucumberUITests
//
//  Created by Kenneth Poon on 5/3/18.
//  Copyright © 2018 Kenneth Poon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsUITests-Swift.h"

__attribute__((constructor))
void CucumberishInit(){
    [CucumberishInitializer setupCucumberish];
}



// cd /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib
