//
//  ViewController.swift
//  News
//
//  Created by Glenn Karlo Manguiat on 07/06/2019.
//  Copyright © 2019 Glenn Karlo Manguiat. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import WebKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newstableView: UITableView!
    
    let resourceURL = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=aIqfQYhGbaAFb8ZKGXe4AzG7jWTQkzn5"
    var headlines = [String]()
    var abstracts = [String]()
    var images = [String]()
    var urls = [URL]()
    var publisheddates = [String]()
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        getJSON()
        
        // Do any additional setup after loading the view.
    }
    
    func getJSON() {
        Alamofire.request(resourceURL).responseJSON { response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                let results = json["results"].arrayValue
                
                for res in results {
                    let headlines =  res["title"].stringValue
                    let abstracts =  res["abstract"].stringValue
                    let images =  res["multimedia"][0]["url"].stringValue
                    let urls =  res["url"].url
                    let dates = res["published_date"].stringValue
                    
                    self.headlines.append(headlines)
                    self.abstracts.append(abstracts)
                    self.images.append(images)
                    self.urls.append(urls!)
                    self.publisheddates.append(dates)
                }
                
                DispatchQueue.main.async {
                    self.newstableView.reloadData()
                }
            }
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ViewControllerTableViewCell
        
        cell.headerText.text = self.headlines[indexPath.row]
        cell.detailsText.text = self.abstracts[indexPath.row]
        cell.dateLabel.text = self.publisheddates[indexPath.row]
        cell.articleImage.loadImageUsingCacheWithUrlString(self.images[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        webView.load(URLRequest(url:self.urls[indexPath.row]))
        webView.allowsBackForwardNavigationGestures = true
        view = webView
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goBack))
    }
    
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

