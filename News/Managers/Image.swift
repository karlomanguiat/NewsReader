//
//  NewsImage.swift
//  News
//
//  Created by Glenn Karlo Manguiat on 07/06/2019.
//  Copyright © 2019 Glenn Karlo Manguiat. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage


let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(_ urlString: String){
        self.image = nil
        
        var notLoaded: Bool = false
        //Check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            self.image = cachedImage
            return
        }
        
        print(urlString)
        
        let tempstring = "https://rvf-smtown.com/img/day6/eKqme0q332.jpg"
        
        Alamofire.request(urlString).responseImage { response in
            if let downloadedImage = response.result.value {
                print(downloadedImage)
                imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                self.image = downloadedImage
                
                print("Image is loaded")
            } else {
                print("Not loaded")
                notLoaded = true
                print(notLoaded)
                
                Alamofire.request(tempstring).responseImage { response in
                    if let downloadedImage = response.result.value {
                        print(downloadedImage)
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                        
                        print("Image is loaded pt. 2")
                    }
                }
            }
        }
    }
}

