//
//  Constants.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright © 2020 Zain Nadeem. All rights reserved.
//

import Foundation
import UIKit

/**
   Extension for writing programmatic constraints.
   - parameter name: searches plist for value associated with this key
   - returns: plist value associated with the key
*/
extension UIView  {
/**
       Function places views at a given location
       - parameter x: searches plist for value associated with this key
       - returns: plist value associated with the key
*/
    func anchor(x: NSLayoutXAxisAnchor? = nil, y: NSLayoutYAxisAnchor? = nil, top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        if let x = x { centerXAnchor.constraint(equalTo: x).isActive = true }
        if let y = y { centerYAnchor.constraint(equalTo: y).isActive = true }
        if let top = top { topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true }
        if let leading = leading { leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true }
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true }
        if let trailing = trailing { trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true }
        if size.width != 0 { widthAnchor.constraint(equalToConstant: size.width).isActive = true }
        if size.height != 0 { heightAnchor.constraint(equalToConstant: size.height).isActive = true }
    }
}

extension UIImageView{
    func makeBlurImage(_ imageView: UIImageView?){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView?.addSubview(blurEffectView)
    }
}

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func mainFont(ofSize size: CGFloat, weight: FontWeight) -> UIFont {
        return customFont(name: "HelveticaNeue-\(weight.rawValue)", size: size)
    }
}

