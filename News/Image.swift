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
        
        //Check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            self.image = cachedImage
            return
        }
        
        
        Alamofire.request(urlString).responseImage { response in
            if let downloadedImage = response.result.value {
                //image is here
                imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                self.image = downloadedImage
            }
        }
    }
}
