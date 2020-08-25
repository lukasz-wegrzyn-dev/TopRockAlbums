//
//  UIImageView+Extension.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

fileprivate class ImageCacher {
    static let shared = ImageCacher()
    private var cache: [String: UIImage] = [:]
    
    func addToCache(key: String, image: UIImage) {
        cache[key] = image
    }
    
    func removeFromCache(key: String){
        cache.removeValue(forKey: key)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache[key]
    }
}

extension UIImageView {
    func load(url: URL) {
        if let image = ImageCacher.shared.imageForKey(key: url.absoluteString) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            ImageCacher.shared.addToCache(key: url.absoluteString, image: image)
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}


