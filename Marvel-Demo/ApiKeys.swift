//
//  ApiKeys.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/19/20.
//  Copyright © 2020 Zain Nadeem. All rights reserved.

import Foundation

/**
 Reads APIKeys.plist to retrieve values
 - parameter name: searches plist for value associated with this key
 - returns: plist value associated with the key
 */

func valueForAPIKey(name: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: name) as! String
    return value
}
