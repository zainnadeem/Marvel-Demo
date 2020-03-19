//
//  DetailWorker.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright (c) 2020 Zain Nadeem. All rights reserved.


import UIKit
import SwiftyJSON

class DetailWorker
  {
     func submitRequest(request: Detail.Comic.Request, completion: @escaping  (_ response: Detail.Comic.Response)->Void){
        MarvelAPICall.shared.requestComicById(id: request.comicID) { (response, error) in
            var comic = Detail.Comic.Response(title: "", description: "", coverImageURL: "")
            if let err = error {
                comic.error = err.localizedDescription
                completion(comic)
            }
            guard let res = response else { return }
            completion(self.comicDetailParser(res))
        }
    }

    public func comicDetailParser(_ json: Any)->Detail.Comic.Response{
        var comic = Detail.Comic.Response(title: "", description: "", coverImageURL: "")
        let json = JSON(json)
        let data = json["data"].dictionaryValue
        let results = data["results"]?.arrayObject
        let resultObject = results as? [[String : Any]] ?? []
            
        if let first = resultObject.first {
                comic.description = first["description"] as? String ?? ""
                comic.title = first["title"] as? String ?? ""
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
