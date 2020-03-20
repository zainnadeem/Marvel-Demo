//
//  DetailPresenter.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright (c) 2020 Zain Nadeem. All rights reserved.


import UIKit

protocol DetailPresentationLogic{
    func presentComic(response: Detail.Comic.Response)
}

class DetailPresenter: DetailPresentationLogic{
    weak var viewController: DetailDisplayLogic?
    /**
     Function formats the response object and gets it ready to be passed to the view contoller via a view model
     - parameter response: response object received from interactor
     */
    func presentComic(response: Detail.Comic.Response) {
        var viewModel = Detail.Comic.ViewModel()
        //Checks to see if error was received
        if let _ = response.error {
            viewModel = Detail.Comic.ViewModel(title: "Sorry", description: "There was an issue loading your comic, please check your network connection.", coverImageURL: "No image")
        } else {
            viewModel = Detail.Comic.ViewModel(title: response.title, description: response.description, coverImageURL: response.coverImageURL, id: response.id)
        }
        //Providing default information if API parameter was null
        if viewModel.title == "" { viewModel.title = "No Title Provided." }
        if viewModel.description == "" { viewModel.description = "No Description Provided." }
        //Pass viewmodel to the DetailViewController
        viewController?.displayComic(viewModel: viewModel)
    }
}
