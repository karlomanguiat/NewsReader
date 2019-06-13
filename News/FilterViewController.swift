//
//  FilterViewController.swift
//  News
//
//  Created by Glenn Karlo Manguiat on 12/06/2019.
//  Copyright © 2019 Glenn Karlo Manguiat. All rights reserved.
//

import UIKit
import DropDown

class FilterViewController: UIViewController {
    
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
                                               "Tech": "technology",
                                               "N/A" : "none"]
    
    var keyword = ""
    var selectedCountry = ""
    var selectedCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDropdowns()
        initFilter()
        
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
        
        //getnewURL()
    }
    
    func initDropdowns() {
        CountryDropDown.anchorView = countryDD
        CountryDropDown.dropDownHeight = 300
        CountryDropDown.dataSource = CountryDictionary.keys.sorted()
        
        CategoryDropDown.anchorView = categoryDD
        CategoryDropDown.dropDownHeight = 300
        CategoryDropDown.dataSource = CategoryDictionary.keys.sorted()
        
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
    
    @IBAction func filterResults(_ sender: Any) {
        self.keyword = keywordSearch.text!
        
        let old_url = getnewURL()
        print(old_url)
    }
    
    func getnewURL() -> String {
        var newURL = ""
        var country = ""
        var category = ""
        
        if selectedCategory == "" && selectedCountry == "" {
            //print(self.keyword)
            newURL = "https://newsapi.org/v2/top-headlines?q=\(self.keyword)&apiKey=daf873f4f4f047639bb2cfe67f90d1c9"
        } else if self.keyword == "" && selectedCategory == "" {
            country = CountryDictionary[self.selectedCountry]!
            newURL = "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=daf873f4f4f047639bb2cfe67f90d1c9"
        } else if self.keyword == "" && selectedCategory == "" {
            category = CategoryDictionary[self.selectedCategory]!
            newURL = "https://newsapi.org/v2/top-headlines?category=\(category)&apiKey=daf873f4f4f047639bb2cfe67f90d1c9"
        } else if selectedCategory == "" {
            country = CountryDictionary[self.selectedCountry]!
            newURL = "https://newsapi.org/v2/top-headlines?q=\(self.keyword)&country=\(country)&apiKey=daf873f4f4f047639bb2cfe67f90d1c9"
        } else if selectedCountry == "" {
            category = CategoryDictionary[self.selectedCategory]!
            newURL = "https://newsapi.org/v2/top-headlines?q=\(self.keyword)&category=\(category)&apiKey=daf873f4f4f047639bb2cfe67f90d1c9"
        } else if self.keyword == "" {
            country = CountryDictionary[self.selectedCountry]!
            category = CategoryDictionary[self.selectedCategory]!
            newURL = "https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&apiKey=daf873f4f4f047639bb2cfe67f90d1c9"
        } else {
            country = CountryDictionary[self.selectedCountry]!
            category = CategoryDictionary[self.selectedCategory]!
            newURL = "https://newsapi.org/v2/top-headlines?q=\(self.keyword)&country=\(country)&category=\(category)&apiKey=daf873f4f4f047639bb2cfe67f90d1c9"
        }
       
        return newURL
    }
}
