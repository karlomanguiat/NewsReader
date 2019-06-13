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
    @IBOutlet weak var CountryOpen: UIButton!
    @IBOutlet weak var categoryDD: UIView!
    @IBOutlet weak var CategoryOpen: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
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
                                               "Tech": "technology" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDropdowns()
        initFilter()
    }
    
    func initFilter() {
        filterButton.layer.cornerRadius = 4
    }
    
    @IBAction func OpenCountryDrop(_ sender: Any) {
        CountryDropDown.show()
    }
    
    @IBAction func OpenCategoryDrop(_ sender: Any) {
        CategoryDropDown.show()
    }
    
    func initDropdowns() {
        CountryDropDown.anchorView = countryDD // UIView or UIBarButtonItem
        CountryDropDown.dropDownHeight = 300
        CountryDropDown.dataSource = CountryDictionary.keys.sorted()
        
        CategoryDropDown.anchorView = categoryDD
        CategoryDropDown.dropDownHeight = 300
        CategoryDropDown.dataSource = CategoryDictionary.keys.sorted()
        
    }
}
