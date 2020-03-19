//
//  DetailPresenter.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright (c) 2020 Zain Nadeem. All rights reserved.


import UIKit

protocol DetailPresentationLogic
{
  func presentComic(response: Detail.Comic.Response)
}

class DetailPresenter: DetailPresentationLogic
{
  weak var viewController: DetailDisplayLogic?
  func presentComic(response: Detail.Comic.Response)
  {
    var viewModel = Detail.Comic.ViewModel(title: "", description: "", coverImageURL: "")
    if let _ = response.error {
        viewModel = Detail.Comic.ViewModel(title: "Sorry", description: "There was an issue loading your comic, please check your network connection.", coverImageURL: "No image")
    } else {
        viewModel = Detail.Comic.ViewModel(title: response.title, description: response.description, coverImageURL: response.coverImageURL)
    }
    
    if viewModel.title == "" {
           viewModel.title = "No Title Provided."
       }
    
    if viewModel.description == "" {
        viewModel.description = "No Description Provided."
    }
    viewController?.displayComic(viewModel: viewModel)
  }
}
