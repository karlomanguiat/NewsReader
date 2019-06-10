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
    let newsURL = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=daf873f4f4f047639bb2cfe67f90d1c9"
    var headlines = [String]()
    var abstracts = [String]()
    var images = [String]()
    var sources = [String]()
    var authors = [String]()
    var urls = [URL]()
    var publisheddates = [String]()
    var content = [String]()
    var webView: WKWebView!
    
    var headline_name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // webView = WKWebView()
        getJSON()
    }
    
    func getJSON() {
        Alamofire.request(newsURL).responseJSON { response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                let results = json["articles"].arrayValue
                
                for res in results {
                    let headlines =  res["title"].stringValue
                    let abstracts =  res["description"].stringValue
                    let images = res["urlToImage"].stringValue
                    let urls =  res["url"].url
                    let dates = res["publishedAt"].stringValue
                    let authors = res["author"].stringValue
                    let sources = res["source"]["name"].stringValue
                    let content = res["content"].stringValue
                    
                    //print(dates)
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "MMM dd, yyyy - h:mm a"

                    
                    if let date = dateFormatterGet.date(from: dates) {
                        //print(dateFormatterPrint.string(from: date))
                        self.publisheddates.append(dateFormatterPrint.string(from: date))
                    } else {
                        print("There was an error decoding the string")
                    }
                    
                    self.headlines.append(headlines)
                    self.abstracts.append(abstracts)
                    self.images.append(images)
                    self.urls.append(urls!)
                    self.sources.append(sources)
                    self.authors.append(authors)
                    self.content.append(content)
                    
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
        performSegue(withIdentifier: "transfer", sender: self)
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = newstableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            if let destination = segue.destination as? DetailsViewController {
                destination.temp_headline = self.headlines[selectedRow]
                destination.temp_imageURL = self.images[selectedRow]
                destination.temp_source = self.sources[selectedRow]
                destination.temp_url = self.urls[selectedRow]
                destination.temp_date = self.publisheddates[selectedRow]
                destination.temp_content = self.content[selectedRow]
                destination.temp_author = self.authors[selectedRow]
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

} 

