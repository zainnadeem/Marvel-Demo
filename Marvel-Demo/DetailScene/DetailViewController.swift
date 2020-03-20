//
//  DetailViewController.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright (c) 2020 Zain Nadeem. All rights reserved.

import UIKit
import SDWebImage


protocol DetailDisplayLogic: class {
    func displayComic(viewModel: Detail.Comic.ViewModel)
}
/**
  Main View
*/
class DetailViewController: UIViewController, DetailDisplayLogic {
    
    // MARK: View Properties
    var interactor: DetailBusinessLogic?
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = marvelGrey
        view.frame = self.view.bounds
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + additionalHeightForDetailContent)
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height + additionalHeightForDetailContent)
        return view
    }()
    
    lazy var comicImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    
    lazy var comicTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.mainFont(ofSize: titleFontSize, weight: .bold)
        title.textColor = .white
        title.textAlignment = .center
        return title
    }()
    
    lazy var comicDescription: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.font = UIFont.mainFont(ofSize: descriptionFontSize, weight: .medium)
        textView.textAlignment = .center
        textView.textColor = .white
        textView.backgroundColor = .clear
        return textView
    }()
    
    lazy var descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = marvelGrey
        return view
        
    }()
    
    lazy var blurrView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let spinner = UIActivityIndicatorView(style: .large)

    // MARK: View lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
        setupNav()
        setConstraints()
        blurrView.makeBlurImage(blurrView)
        loadSpinner()
        loadComic(id: 61756)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
   
    // MARK: Setup creates links for the VIP cycle.
    private func setup(){
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: NAVBAR Sets up navbar button and handler
    func setupNav(){
         let rightButton = UIBarButtonItem(title: "Search By Id", style: .plain, target: self, action: #selector(rightButtonTapped))
         let leftButton = UIBarButtonItem(title: "VoiceOver", style: .plain, target: self, action: #selector(leftButtonTapped))
         self.navigationItem.rightBarButtonItem = rightButton
         self.navigationItem.leftBarButtonItem = leftButton
         self.navigationItem.title = appTitle
     }

    @objc func rightButtonTapped(){
        let alert = UIAlertController(title: "Search Comics", message: "Enter a comic Id", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if textField?.text == "" {
             //do nothing
            }else{
               self.loadSpinner()
               self.loadComic(id: Int(textField?.text! ?? "0") ?? 0)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func leftButtonTapped(){
        if UIAccessibility.isVoiceOverRunning {
             UIAccessibility.post(notification: .announcement, argument: "\(comicTitle.text!)\(comicDescription.text!)")
        } else {
            let alert = UIAlertController(title: "Enable VoiceOver", message: "(Settings > Accessibility > VoiceOver) to hear title & description", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    // MARK: View Constraints
    private func setConstraints(){
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [blurrView, comicImageView, descriptionView, comicTitle, lineView, comicDescription].forEach{ containerView.addSubview($0 ?? UIView())}
        blurrView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, leading: containerView.safeAreaLayoutGuide.leadingAnchor, trailing: containerView.safeAreaLayoutGuide.trailingAnchor, padding: .init(), size: .init(width: containerView.frame.width, height: containerView.frame.height * 0.6))
        comicImageView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, leading: containerView.safeAreaLayoutGuide.leadingAnchor, trailing: containerView.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: containerView.frame.width, height: containerView.frame.height * 0.5))
        descriptionView.anchor(top: comicImageView.safeAreaLayoutGuide.bottomAnchor, leading: containerView.safeAreaLayoutGuide.leadingAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, trailing: containerView.safeAreaLayoutGuide.trailingAnchor, padding: .init(), size: .init(width: containerView.frame.width, height: containerView.frame.height * 0.4))
        comicTitle.anchor( x: containerView.safeAreaLayoutGuide.centerXAnchor, top: descriptionView.safeAreaLayoutGuide.topAnchor, padding: .init(top: 4, left: 10, bottom: 0, right: 0), size: .init(width: containerView.frame.width, height: containerView.frame.height * 0.05))
        lineView.anchor(x: containerView.safeAreaLayoutGuide.centerXAnchor, top: comicTitle.safeAreaLayoutGuide.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 1, right: 0), size: .init(width: containerView.frame.width * 0.8, height: containerView.frame.height * 0.002))
        comicDescription.anchor(x: comicTitle.safeAreaLayoutGuide.centerXAnchor, top: comicTitle.safeAreaLayoutGuide.bottomAnchor, padding: .init(top: 3, left: 0, bottom: 0, right: 0), size: .init(width: containerView.frame.width * 0.9, height: containerView.frame.height * 0.3))
    }
     /**
        Function calls interactor to make API request through the DetailViewWorker
        - parameters Id: Id for comic to be retrieved
     */
    func loadComic(id: Int){
        if (MarvelCachedComics.shared.comicById[id] != nil){
            displayCachedComic(id: id)
        }else{
            let request = Detail.Comic.Request(comicID: id)
            interactor?.fetchComicInformation(request: request)
        }
    }
    
    /**
        Function populates views with a comic that has been cached
        - parameters: Id for comic to be retrieved
     */
    func displayCachedComic(id: Int){
        let comic = MarvelCachedComics.shared.comicById[id]
        if let cachedComic = comic {
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                [self.blurrView, self.comicImageView].forEach{$0.image = cachedComic.coverImage}
                self.comicTitle.text = cachedComic.title
                self.comicDescription.text = cachedComic.description
            }
        }
    }
    /**
       Function populates view with comic information received from the DetailPresenter
       - parameters viewModel: Id for comic to be retrieved
    */
    func displayComic(viewModel: Detail.Comic.ViewModel){
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            [self.blurrView, self.comicImageView].forEach{ $0.sd_setImage(with: URL(string: viewModel.coverImageURL + ".jpg"))}
            if viewModel.coverImageURL == "" {
                [self.blurrView, self.comicImageView].forEach{ $0.image = UIImage(named: "placeholder") }
            }
            self.comicTitle.text = viewModel.title
            self.comicDescription.text = viewModel.description
        }

    }
    /**
     Activity indicator will run until views are populated
    */
    func loadSpinner(){
        DispatchQueue.main.async {
            self.spinner.translatesAutoresizingMaskIntoConstraints = false
            self.spinner.startAnimating()
            self.view.addSubview(self.spinner)
            self.spinner.anchor(x: self.view.centerXAnchor, y: self.view.centerYAnchor)
        }
    }
}
