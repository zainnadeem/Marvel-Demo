//
//  MarvelAPI.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright © 2020 Zain Nadeem. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift
import SDWebImage
import SwiftyJSON


let publicKey = valueForAPIKey(named:"Public")
let privateKey = valueForAPIKey(named:"Private")

class MarvelCachedImages {
    static let shared = MarvelCachedImages()
    var images = [String : UIImage]()
}

class MarvelAPICall {
    static let shared = MarvelAPICall()
    func requestComicById(id: String, completion: @escaping  (_ response: Any?,  _ error: Error?)->Void){

        guard let url = URL(string: "https://gateway.marvel.com/v1/public/comics/\(id)") else { return }

        let ts = NSDate().timeIntervalSince1970.description
        
        let params: Parameters = [
            "apikey": publicKey,
            "ts": ts,
            "hash": (ts + privateKey + publicKey).md5(),
        ]
        
        var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.get.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
        
        AF.request(url, parameters: params).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                     completion(value, nil)
                 case .failure(let error):
                     completion(nil, error)

            }
            })
        }
    

   func requestAllComics(completion: @escaping  (_ response: Any)->Void){

                let url = "https://gateway.marvel.com/v1/public/comics"
                let ts = NSDate().timeIntervalSince1970.description
                
                let params: Parameters = [
                    "apikey": publicKey,
                    "ts": ts,
                    "hash": (ts + privateKey + publicKey).md5(),
                    "orderBy": "-focDate",
                ]
        var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = HTTPMethod.get.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
        
        AF.request(url, parameters: params).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                     print ("finish")
                     print(response)
                     completion(value)
                 case .failure(let error):
                     print(error.localizedDescription)

            }
            })
        }
    
    
}
