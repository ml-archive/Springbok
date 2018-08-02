//
//  SessionManager+DownloadImage.swift
//  Springbok
//
//  Created by Maxime Maheo on 02/08/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import UIKit

extension SessionManager {
    
    public func downloadImage(from url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        downloadImageTasks[url.absoluteString] = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error == nil, let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                    self.downloadImageTasks.removeValue(forKey: url.absoluteString)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                completion(nil)
                self.downloadImageTasks.removeValue(forKey: url.absoluteString)
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            self.downloadImageTasks[url.absoluteString]?.resume()
        }
    }
    
}
