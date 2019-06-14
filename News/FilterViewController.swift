//
//  FilterViewController.swift
//  News
//
//  Created by Glenn Karlo Manguiat on 12/06/2019.
//  Copyright © 2019 Glenn Karlo Manguiat. All rights reserved.
//

import UIKit
import DropDown

class FilterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var countryDD: UIView!
    @IBOutlet weak var categoryDD: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var keywordSearch: UITextField!
    
    let CountryDropDown = DropDown()
    let CategoryDropDown = DropDown()
    
    
    let CountryDictionary: [String:String] = ["United Arab Emirates" : "ae",
                                                "Argentina" : "ar",
                                                "Austria" : "at",
                                                "Australia" : "au",
                                                "Belgium" : "be",
                                                "Bulgaria" : "bg",
                                                "Brazil" : "br",
                                                "Canada" : "ca",
                                                "Switzerland" : "ch",
                                                "China" : "cn",
                                                "Cuba" : "cu",
                                                "Colombia" : "co",
                                                "Czech Republic" : "cz",
                                                "Germany" : "de",
                                                "Egypt" : "eg",
                                                "France" : "fr",
                                                "United Kingdom" : "gb",
                                                "Greece" : "gr",
                                                "Hongkong" : "hk",
                                                "Hungary" : "hu",
                                                "Indonesia" : "id",
                                                "Ireland" : "ie",
                                                "Israel" : "il",
                                                "India" : "in",
                                                "Italy" : "it",
                                                "Japan" : "jp",
                                                "Republic of Korea" : "kr",
                                                "Lithuania" : "lt",
                                                "Latvia" : "lv",
                                                "Morocco" : "ma",
                                                "Mexico" : "mx",
                                                "Malaysia": "my",
                                                "Nigeria" : "ng",
                                                "Netherlands" : "nl",
                                                "Norway" : "no",
                                                "New Zealand" : "nz",
                                                "Philippines" : "ph",
                                                "Poland" : "pl",
                                                "Portugal" : "pt",
                                                "Romania" : "ro",
                                                "Serbia" : "rs",
                                                "Russia" : "ru",
                                                "Saudi Arabia" : "sa",
                                                "Sweden" : "se",
                                                "Singapore" : "sg",
                                                "Slovenia" : "si",
                                                "Slovakia" : "sk",
                                                "Thailand" : "th",
                                                "Turkey" : "tr",
                                                "Taiwan" : "tw",
                                                "Ukraine" : "ua",
                                                "United States" : "us",
                                                "Venezuela" : "ve",
                                                "South Africa" : "za" ]
    
    let CategoryDictionary: [String:String] = ["Business": "business",
                                               "Entertainment": "entertainment",
                                               "General": "general",
                                               "Health": "health",
                                               "Science" : "science",
                                               "Sports": "sports",
                                               "Tech": "technology"]
    
    var keyword = ""
    var selectedCountry = ""
    var selectedCategory = ""
    var newsURL : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keywordSearch.delegate = self
        
        initDropdowns()
        initFilter()
        
        print(newsURL!)
        
        
        CountryDropDown.selectionAction = { (index: Int, item: String) in
            print("Country item: \(item) at index: \(index)")
            self.countryButton.setTitle(item, for: .normal)
            self.selectedCountry = item
        }
        
        CategoryDropDown.selectionAction = { (index: Int, item: String) in
            print("Category item: \(item) at index: \(index)")
            self.categoryButton.setTitle(item, for: .normal)
            self.selectedCategory = item
        }
    }
    
    func initDropdowns() {
        CountryDropDown.anchorView = countryDD
        CountryDropDown.dropDownHeight = 300
        CountryDropDown.dataSource = CountryDictionary.keys.sorted()
        
        CategoryDropDown.anchorView = categoryDD
        CategoryDropDown.dropDownHeight = 300
        CategoryDropDown.dataSource = CategoryDictionary.keys.sorted()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keywordSearch.resignFirstResponder()
        keyword = keywordSearch.text!
        return true
    }
    
    func initFilter() {
        filterButton.layer.cornerRadius = 4
    }
    
    @IBAction func openCountryDrop(_ sender: Any) {
        CountryDropDown.show()
    }
    
    @IBAction func openCategoryDrop(_ sender: Any) {
        CategoryDropDown.show()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cancelFilter" {
            print("cancelFilter")
            newsURL = "Chris Yabut"
            //newsURL = getnewURL()
        }
    }
    func getnewURL() -> String {
        var newURL = ""
        var country = ""
        var category = ""
        
        if selectedCategory == "" && selectedCountry == "" {
            //print(self.keyword)
            newURL = "https://newsapi.org/v2/top-headlines?q=\(self.keyword)&apiKey=890167f041854a3ba357170d891f36ab"
        } else if self.keyword == "" && selectedCategory == "" {
            country = CountryDictionary[self.selectedCountry]!
            newURL = "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=890167f041854a3ba357170d891f36ab"
        } else if self.keyword == "" && selectedCategory == "" {
            category = CategoryDictionary[self.selectedCategory]!
            newURL = "https://newsapi.org/v2/top-headlines?category=\(category)&apiKey=890167f041854a3ba357170d891f36ab"
        } else if selectedCategory == "" {
            country = CountryDictionary[self.selectedCountry]!
            newURL = "https://newsapi.org/v2/top-headlines?q=\(self.keyword)&country=\(country)&apiKey=890167f041854a3ba357170d891f36ab"
        } else if selectedCountry == "" {
            category = CategoryDictionary[self.selectedCategory]!
            newURL = "https://newsapi.org/v2/top-headlines?q=\(self.keyword)&category=\(category)&apiKey=890167f041854a3ba357170d891f36ab"
        } else if self.keyword == "" {
            country = CountryDictionary[self.selectedCountry]!
            category = CategoryDictionary[self.selectedCategory]!
            newURL = "https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&apiKey=890167f041854a3ba357170d891f36ab"
        } else {
            country = CountryDictionary[self.selectedCountry]!
            category = CategoryDictionary[self.selectedCategory]!
            newURL = "https://newsapi.org/v2/top-headlines?q=\(self.keyword)&country=\(country)&category=\(category)&apiKey=890167f041854a3ba357170d891f36ab"
        }
       
        return newURL
    }
}
