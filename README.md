# Marvel-Demo

This repository allows developers to view Marvel comic book covers, titles & descriptions. All the information is received from Marvels API accessable through the portal at developer.marvel.com.

![alt text](https://github.com/zainnadeem/Marvel-Demo/blob/master/Silver-Surfer-Cates-min.png)

## Adding API Keys
In order to utilize the application please obtain a public and private key from Marvel.

[Get an API Key](https://developer.marvel.com)

Create a file named ApiKeys.plist and at two items under root.

```swift
Public <YOUR PUBLIC KEY>
Private <YOUR PRIVATE KEY>
```

After creating this file and adding it to your project, you will be able to search comic books by Id. Some searchable ID's for testing:


## Features

- [x] Search Comic By ID

## XCODE Version
- Xcode 11.3.1

#### CocoaPods Used
This project the following [CocoaPods](http://cocoapods.org/:

[CrytoSwift](https://github.com/krzyzanowskim/CryptoSwift)
[Alamofire](https://github.com/Alamofire/Alamofire)
[SDWebImage](https://github.com/SDWebImage/SDWebImage)
[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

Your Podfile should look like this: 

```ruby
use_frameworks!
  pod 'CryptoSwift', '~> 1.0'
  pod 'Alamofire', '~> 5.0'
  pod 'SDWebImage', '~> 5.0'
  pod 'SwiftyJSON', '~> 4.0'
```


## Architecture 
This project uses [clean-swift](https://clean-swift.com/clean-swift-ios-architecture) & the VIP cycle. 

The most important thing to remember here is that view controller’s output connects to the interactor’s input. The interactor’s output connects to the presenter’s input. The presenter’s output connects to the view controller’s input. 

The DetailScene contains special objects located at DetailModels to pass data through the VIP cycle. This decouples the underlying data models from the components. These connections are setup through protocols in the initializer of the DetailViewController.

```swift
    private func setup(){
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
```

