//
//  CucumberishInitializer.swift
//  WeatherCucumberUITests
//
//  Created by Kenneth Poon on 5/3/18.
//  Copyright © 2018 Kenneth Poon. All rights reserved.
//

import XCTest
import Foundation
import Cucumberish

class CucumberishInitializer: NSObject {
    @objc class func setupCucumberish(){        
        before({ _ in
            XCUIApplication().launch()
        })
        
        Given("I am on All News") { (args, userInfo) -> Void in
            self.waitForElementToAppear(XCUIApplication().buttons["FilterButton"])
        }
        
        When("I Tap on Filter CTA") { (args, userInfo) -> Void in
            let filterButton = XCUIApplication().buttons["FilterButton"]
            filterButton.tap()
        }
        
        Then("I can see the popup dialog with the little Select Category") { (args, userInfo) -> Void in
            self.waitForElementToAppear(XCUIApplication().otherElements["FilterView"])
        }
        
        
        
        let bundle = Bundle(for: CucumberishInitializer.self)
        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags: self.getTags(), excludeTags: nil)

    }
    
    class func waitForElementToAppear(_ element: XCUIElement){
        let result = element.waitForExistence(timeout: 5)
        guard result else {
            XCTFail("Element does not appear")
            return
        }
    }
    
    fileprivate class func getTags() -> [String]? {
        var itemsTags: [String]? = nil        
        for i in ProcessInfo.processInfo.arguments {
            if i.hasPrefix("-Tags:") {
                let newItems = i.replacingOccurrences(of: "-Tags:", with: "")
                itemsTags = newItems.components(separatedBy: ",")
            }
        }
        return itemsTags
    }
    
}
