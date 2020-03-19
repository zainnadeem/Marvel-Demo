//
//  DetailModels.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright (c) 2020 Zain Nadeem. All rights reserved.

import UIKit

enum Detail
{
    enum Comic
    {
        struct Request
        {
            var comicID: String
        }
        struct Response
        {
            var title: String
            var description: String
            var coverImageURL: String
            var error: String?
        }
        struct ViewModel
        {
            var title: String
            var description: String
            var coverImageURL: String
        }
    }
}
