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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newstableView: UITableView!
    
    let resourceURL = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=aIqfQYhGbaAFb8ZKGXe4AzG7jWTQkzn5"
    var newsURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=890167f041854a3ba357170d891f36ab"
    var headlines = [String]()
    var abstracts = [String]()
    var images = [String]()
    var sources = [String]()
    var authors = [String]()
    var urls = [URL]()
    var publisheddates = [String]()
    var content = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
        print("This is the news URL: \(newsURL)")
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
                    var dates = res["publishedAt"].stringValue
                    let authors = res["author"].stringValue
                    let sources = res["source"]["name"].stringValue
                    let content = res["content"].stringValue
                    
                    //print(dates)
                    let dateFormatterGet = DateFormatter()
                    dates = dates.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
                    // dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "MMM dd, yyyy - h:mm a"

                    
                    if let date = dateFormatterGet.date(from: dates) {
                        //print(dateFormatterPrint.string(from: date))
                        self.publisheddates.append(dateFormatterPrint.string(from: date))
                    } else {
                        print("There was an error decoding the string")
                    }
                    
                    print(headlines)
                    
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
        if headlines.count == 0 {
            tableView.setEmptyView(title: "No results found.", message: "Try filtering results again.")
        }
        else {
            tableView.restore()
        }
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
    
    @IBAction func onclickFilter(_ sender: Any) {
        performSegue(withIdentifier: "toFilter", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transfer" {
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
        } else if segue.identifier == "toFilter" {
            print("toFilter")
            if let destination = segue.destination as? FilterViewController {
                destination.newsURL = self.resourceURL
            }
        }
    }
    
    func emptyArrays() {
        self.headlines.removeAll()
        self.abstracts.removeAll()
        self.images.removeAll()
        self.urls.removeAll()
        self.sources.removeAll()
        self.authors.removeAll()
        self.content.removeAll()
    }

    @IBAction func unwindToView(_ unwindSegue: UIStoryboardSegue) {
        if let tempFilterViewController = unwindSegue.source as? FilterViewController {
            print("unwind")
            let headline_name = tempFilterViewController.newsURL
            self.newsURL = headline_name!
        }
        print("This is the news URL from segue: \(newsURL)")
        emptyArrays()
        getJSON()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

} 

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
