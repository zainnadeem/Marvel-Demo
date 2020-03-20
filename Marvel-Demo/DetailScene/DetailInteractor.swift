//
//  DetailInteractor.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright (c) 2020 Zain Nadeem. All rights reserved.

import UIKit

protocol DetailBusinessLogic
{
    func fetchComicInformation(request: Detail.Comic.Request)
}


class DetailInteractor: DetailBusinessLogic{
  var presenter: DetailPresentationLogic?
  var worker: DetailWorker?
  
  func fetchComicInformation(request: Detail.Comic.Request)
  {
    worker = DetailWorker()
    worker?.submitRequest(request: request, completion: { (response) in
        self.presenter?.presentComic(response: response)
    })
    

  }
}
