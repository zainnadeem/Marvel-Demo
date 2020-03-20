//
//  DetailWorker.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright (c) 2020 Zain Nadeem. All rights reserved.


import UIKit
import SwiftyJSON

class DetailWorker {
    /**
     Hits the request comic by Id function inside of the Marvel API and passes the response back to the DetailViewInteractor.
     - parameter request: request object received from interactor
     */
    func submitRequest(request: Detail.Comic.Request, completion: @escaping  (_ response: Detail.Comic.Response)->Void){
        MarvelAPICall.shared.requestComicById(id: request.comicID) { (response, error) in
            var comic = Detail.Comic.Response()
            //If request returns an error, the response object is populated with an error.
            if let err = error {
                comic.error = err.localizedDescription
                //Consider refactoring, It is unknown if the API can return an error and still return an object.
                completion(comic)
            }
            //Retrun response object after parsing
            guard let res = response else { return }
            completion(Detail.Comic.Response(title: res.title, description: res.description, coverImageURL: res.coverImageURL, id: res.id, error: nil))
        }
    }
    

}
