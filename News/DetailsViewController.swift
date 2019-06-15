//
//  DetailsViewController.swift
//  News
//
//  Created by Glenn Karlo Manguiat on 10/06/2019.
//  Copyright © 2019 Glenn Karlo Manguiat. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var headlineText: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var authorText: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var readMore: UIButton!
    
    var temp_headline = ""
    var temp_imageURL = ""
    var temp_date = ""
    var temp_source = ""
    var temp_author = ""
    var temp_content = ""
    var temp_url : URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headlineText.text = temp_headline
        publishedDate.text = temp_date
        authorText.text = "By: \(temp_author) from \(temp_source)"
        content.text = temp_content
        articleImage.loadImageUsingCacheWithUrlString(temp_imageURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clickReadMore(_ sender: Any) {
        UIApplication.shared.open(temp_url, options: [:], completionHandler: nil)
    }
}
