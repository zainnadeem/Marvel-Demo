//
//  DetailViewController.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright (c) 2020 Zain Nadeem. All rights reserved.

import UIKit
import SDWebImage

protocol DetailDisplayLogic: class
{
    func displayComic(viewModel: Detail.Comic.ViewModel)
}

class DetailViewController: UIViewController, DetailDisplayLogic
{
    var interactor: DetailBusinessLogic?
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = UIColor.init(red: 32/255, green: 33/255, blue: 34/255, alpha: 1)
        view.frame = self.view.bounds
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 50)
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height + 50)
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    
    lazy var comicTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.mainFont(ofSize: 15, weight: .bold)
        title.textColor = .white
        title.textAlignment = .center
        return title
    }()
    
    lazy var comicDescription: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.font = UIFont.mainFont(ofSize: 13, weight: .medium)
        textView.textAlignment = .center
        textView.textColor = .white
        textView.backgroundColor = .clear
        return textView
    }()
    
    lazy var descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 32/255, green: 33/255, blue: 34/255, alpha: 1)
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
    
    // MARK: Setup
    private func setup(){
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupNav()
        setConstraints()
        loadComic(id:"61756")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
    
    func setupNav(){
         let rightButton = UIBarButtonItem(title: "Search By Id", style: .plain, target: self, action: #selector(rightButtonTapped))
         self.navigationItem.rightBarButtonItem = rightButton
         self.navigationItem.title = "Marvel"
     }
    
    @objc func rightButtonTapped(){
        let alert = UIAlertController(title: "Search Comics", message: "Enter a comic ID", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
        }
        
       
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.loadComic(id: textField?.text! ?? "61756")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setConstraints(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [blurrView, imageView, descriptionView, comicTitle, lineView, comicDescription].forEach{ containerView.addSubview($0 ?? UIView())}
        blurrView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, leading: containerView.safeAreaLayoutGuide.leadingAnchor, trailing: containerView.safeAreaLayoutGuide.trailingAnchor, padding: .init(), size: .init(width: containerView.frame.width, height: containerView.frame.height * 0.6))
        blurrView.makeBlurImage(targetImageView: blurrView)
        imageView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, leading: containerView.safeAreaLayoutGuide.leadingAnchor, trailing: containerView.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: containerView.frame.width, height: containerView.frame.height * 0.5))
        descriptionView.anchor(top: imageView.safeAreaLayoutGuide.bottomAnchor, leading: containerView.safeAreaLayoutGuide.leadingAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, trailing: containerView.safeAreaLayoutGuide.trailingAnchor, padding: .init(), size: .init(width: containerView.frame.width, height: containerView.frame.height * 0.4))
        comicTitle.anchor( x: containerView.safeAreaLayoutGuide.centerXAnchor, top: descriptionView.safeAreaLayoutGuide.topAnchor, padding: .init(top: 4, left: 10, bottom: 0, right: 0), size: .init(width: containerView.frame.width, height: containerView.frame.height * 0.05))
        lineView.anchor(x: containerView.safeAreaLayoutGuide.centerXAnchor, top: comicTitle.safeAreaLayoutGuide.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 1, right: 0), size: .init(width: containerView.frame.width * 0.8, height: containerView.frame.height * 0.002))
        comicDescription.anchor(x: comicTitle.safeAreaLayoutGuide.centerXAnchor, top: comicTitle.safeAreaLayoutGuide.bottomAnchor, padding: .init(top: 3, left: 0, bottom: 0, right: 0), size: .init(width: containerView.frame.width * 0.9, height: containerView.frame.height * 0.3))
    }

    // MARK:
    func loadComic(id: String){
        let request = Detail.Comic.Request(comicID: id)
        interactor?.fetchComicInformation(request: request)
    }
    
    func displayComic(viewModel: Detail.Comic.ViewModel)
    {
        [blurrView, imageView].forEach{ $0.sd_setImage(with: URL(string: viewModel.coverImageURL + ".jpg"))}
        if viewModel.coverImageURL == "" {
            [blurrView, imageView].forEach{ $0.image = UIImage(named: "placeholder") }
        }
        
        comicTitle.text = viewModel.title
        comicDescription.text = viewModel.description
    }
}
