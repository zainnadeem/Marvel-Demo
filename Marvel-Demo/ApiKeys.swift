//
//  ApiKeys.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/19/20.
//  Copyright © 2020 Zain Nadeem. All rights reserved.

import Foundation

 
func valueForAPIKey(named keyname:String) -> String {
  let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
  let plist = NSDictionary(contentsOfFile:filePath!)
  let value = plist?.object(forKey: keyname) as! String
  return value
}
