//
//  ImageManager.swift
//  Springbok
//
//  Created by Maxime Maheo on 02/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit
import Foundation

class ImageManager {
    
    // MARK: - Properties -
    public static let shared = ImageManager()
    
    private var downloadTasks: [String: URLSessionDataTask]
    private var imageCache: NSCache<NSString, UIImage>
    
    // MARK: - Lifecycle -
    private init() {
        downloadTasks = [:]
        imageCache = NSCache()
    }
    
    // MARK: - Methods -
    public func downloadImage(from url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        downloadTasks[url.absoluteString] = URLSession.shared.dataTask(with: url) { (data, _, error) in
            self.downloadTasks.removeValue(forKey: url.absoluteString)
            
            if error == nil, let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            self.downloadTasks[url.absoluteString]?.resume()
        }
    }
    
    public func cancelTask(url: String) {
        downloadTasks[url]?.cancel()
        downloadTasks.removeValue(forKey: url)
    }
    
    public func cancelTasks() {
        for task in downloadTasks {
            task.value.cancel()
        }
        downloadTasks.removeAll()
    }
    
    public func setImageToCache(image: UIImage, url: String) {
        imageCache.setObject(image, forKey: url as NSString)
    }
    
    public func getImageFromCache(url: String) -> UIImage? {
        if let image = imageCache.object(forKey: url as NSString) {
            return image
        }
        
        return nil
    }
}
