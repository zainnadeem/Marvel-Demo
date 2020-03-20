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


let publicKey = valueForAPIKey(name:"Public")
let privateKey = valueForAPIKey(name:"Private")

struct Comic {
    var id : Int
    var title : String
    var description : String
    var coverImageURL: String
    var coverImage : UIImage?
}

class MarvelCachedComics {
    static let shared = MarvelCachedComics()
    var comicById = [Int : Comic]()
    
    func cacheComic(comic: Comic) {
        comicById[comic.id] = comic
    }
}

class MarvelAPICall {
    static let shared = MarvelAPICall()
    func requestComicById(id: Int, completion: @escaping  (_ response: Comic?,  _ error: Error?)->Void){
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
                var comic = self.comicDetailParser(value)
                completion(comic, nil)
                //Cache comic once fetching image is complete
                DispatchQueue.global(qos: .background).async {
                    SDWebImageDownloader.shared.downloadImage(with: URL(string: (comic.coverImageURL + ".jpg")), completed: { (image, data, error, bool) in
                        comic.coverImage = image
                        MarvelCachedComics.shared.cacheComic(comic: comic)
                    })
                }
            case .failure(let error):
                completion(nil, error)
            }
        })
    }
    
    /**
     Function parses json object given.
     - parameters: Any object utilized by SwiftyJson to parse parameter
     - Returns: response object with updated parameters from json
     */
    public func comicDetailParser(_ json: Any)->Comic{
        var comic = Comic(id: 0, title: "", description: "", coverImageURL: "")
        let json = JSON(json)
        let data = json["data"].dictionaryValue
        let results = data["results"]?.arrayObject
        let resultObject = results as? [[String : Any]] ?? []
        
        if let first = resultObject.first {
            comic.description = first["description"] as? String ?? ""
            comic.title = first["title"] as? String ?? ""
            comic.id = first["id"] as? Int ?? 0
            if let images = first["images"] {
                let imagesArray = images as! [[String : Any]]
                if let firstImageArray = imagesArray.first {
                    comic.coverImageURL = firstImageArray["path"] as! String
                }
            }
        }
        return comic
    }
}
