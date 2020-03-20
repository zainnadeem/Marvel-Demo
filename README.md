# Marvel-Demo

This repository allows developers to view Marvel comic book covers, titles & descriptions. All the information is received from Marvels API accessable through the portal at developer.marvel.com.

![alt text](https://github.com/zainnadeem/Marvel-Demo/blob/master/Silver-Surfer-Cates-min.png)

## Adding API Keys
In order to utilize the application please obtain a public and private key from Marvel.

[Get an API Key](https://developer.marvel.com)

The application will not build without creating an ApiKeys.plist file. Add a new file in your project and choose Property List from the resource template. 

Name the file **ApiKeys.plist**<br/>
Add two properties under root for your public and private keys:
```swift
Public <YOUR PUBLIC KEY>
Private <YOUR PRIVATE KEY>
```
*[Additional information of handling public and private keys with plists.](https://dev.iachieved.it/iachievedit/using-property-lists-for-api-keys-in-swift-applications/)

After creating this file and adding it to your project. Run your application, you will be able to search comic books by Id. 

**Some searchable ID's for testing:**<br/>
61756 - The Unstoppable Wasp (2017) #2<br/>
73111 - HOUSE OF X/POWERS OF X TPB (Trade Paperback)<br/>
76405 - League of Legends: Zed (2019) #6<br/>
89889 - EMPYRE MAGAZINE (2020) #1<br/>
81180 - Ant-Man (2020) #4<br/>
80120 - Star Wars: Bounty Hunters (2020) #2<br/>
88112 - True Believers: Empyre - Lyja (2020) #1<br/>
77236 - Captain America (2018) #20<br/>

## Features

- [x] Browse Comic By ID
- [x] Listen to app title & description

## XCODE Version
- Xcode 11.3.1

#### CocoaPods Used
This project the following [CocoaPods](http://cocoapods.org/:

[CrytoSwift](https://github.com/krzyzanowskim/CryptoSwift)<br/>
[Alamofire](https://github.com/Alamofire/Alamofire)<br/>
[SDWebImage](https://github.com/SDWebImage/SDWebImage)<br/>
[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)<br/>

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
## Accessibility 

The app offers the ability to have the title and description of the comic read aloud. To enable this function navigate to<br/> Settings > Accessibility > VoiceOver

## Scroll View

The decision to create scrollView for the detail screen will allow additional information to be displayed in future updates of this application
