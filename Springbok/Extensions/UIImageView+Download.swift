//
//  UIImageView+Download.swift
//  Springbok
//
//  Created by Maxime Maheo on 02/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func setImage(url: String,
                         fading: Bool = true,
                         duration: TimeInterval = 0.3,
                         placeholderImage: UIImage? = nil) {
        setPlaceholderImage(image: placeholderImage, fading: fading, duration: duration)
        
        accessibilityIdentifier = url
        
        if let image = getImageFromCache(url: url) {
            setImage(image: image, url: url, fading: false)
        } else if let url = URL(string: url) {
            SessionManager.default.downloadImage(from: url) { (image) in
                self.setImage(image: image, url: url.absoluteString, fading: fading, duration: duration)
            }
        }
    }
    
    public func cancelDownloadTask() {
        if let urlString = accessibilityIdentifier, let url = URL(string: urlString) {
            SessionManager.default.downloadImageTasks[url.absoluteString]?.cancel()
        }
    }
        
    private func setPlaceholderImage(image: UIImage?, fading: Bool, duration: TimeInterval) {
        if let placeholderImage = image {
            if fading {
                animate(image: placeholderImage, duration: duration)
            } else {
                self.image = placeholderImage
            }
        } else {
            self.image = nil
        }
    }
    
    private func setImage(image: UIImage?, url: String, fading: Bool, duration: TimeInterval = 0.3) {
        if accessibilityIdentifier == url, let image = image {
            if fading {
                animate(image: image, duration: duration)
            } else {
                self.image = image
            }
            setImageIntoCache(url: url, image: image)
        }
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        if let image = SessionManager.default.imageCache.object(forKey: url as NSString) {
            print("from cache")
            return image
        }
        
        return nil
    }
    
    private func setImageIntoCache(url: String, image: UIImage) {
        SessionManager.default.imageCache.setObject(image, forKey: url as NSString)
    }
    
    private func animate(image: UIImage?, duration: TimeInterval) {
        self.image = image
        alpha = 0
        UIView.animate(withDuration: duration) {
            self.alpha = 1
            self.superview?.layoutIfNeeded()
        }
    }
    
}