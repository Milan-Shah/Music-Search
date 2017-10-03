//
//  ImageCacheLoader.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/3/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//

import Foundation
import UIKit
typealias ImageCacheLoaderCompletionHandler = ((UIImage) -> ())

class ImageCacheLoader {
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    func obtainImageWithPath(imagePath: String, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            /* placeholder image */
            let placeholder = #imageLiteral(resourceName: "no-image-found")
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            let url: URL! = URL(string: imagePath)
            
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
                
                guard let data = try? Data(contentsOf: url as URL) else {
                    print("Error parsing image data")
                    DispatchQueue.main.async {
                        completionHandler(placeholder)
                    }
                    return
                }
                let img: UIImage! = UIImage(data: data)
                self.cache.setObject(img, forKey: imagePath as NSString)
                DispatchQueue.main.async {
                    completionHandler(img)
                }
            })
            task.resume()
        }
    }
}
