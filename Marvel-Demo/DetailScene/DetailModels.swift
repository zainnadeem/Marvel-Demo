//
//  DetailModels.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright (c) 2020 Zain Nadeem. All rights reserved.

import UIKit
/**
 Objects are specific to the Detail scene
 */
enum Detail {
    enum Comic {
        /**
         Object passed to make API request
         */
        struct Request {
            var comicID: Int
        }
        /**
         Object received from API
         */
        struct Response {
            var title: String = ""
            var description: String = ""
            var coverImageURL: String = ""
            var id: Int = 0
            var error: String?
        }
        /**
         Formated object for viewcontroller
         */
        struct ViewModel {
            var title: String = ""
            var description: String = ""
            var coverImageURL: String = ""
            var id: Int = 0
        }
    }
}
