//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {
    
    var businesses: [Business]!
    
    let yelpRed = UIColor(red: 196.0 / 255.0, green: 18.0 / 255.0, blue: 0.0, alpha: 1.0)
    
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    let searchBar = UISearchBar()
    var filterStore = [String: AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        
        
        searchBar.autoresizingMask = UIViewAutoresizing.flexibleRightMargin
        searchBar.backgroundColor = UIColor.clear
        searchBar.tintColor = UIColor.red
        searchBar.delegate = self
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = yelpRed
            navigationBar.tintColor = UIColor.white
        }
        
        
        self.navigationItem.titleView = searchBar
        
        
        Business.searchWithTerm(term: "restaurant", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        
        cell.row = indexPath.row
        cell.business = businesses[indexPath.row]
        
     
        return cell
    }
    
    func searchWithTerm(term: String) {
        Business.searchWithTerm(term: term, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
        }
        )
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let term = searchBar.text {
            searchWithTerm(term: term)
        }
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let term = searchBar.text {
            searchWithTerm(term: term)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWithTerm(term: searchText)
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String: AnyObject]) {
        
        filterStore = filters
        
        let categories = filters["categories"] as? [String]
        let dealState = filters["offeringDeal"] as? Bool
        let distance = filters["distance"] as? Int
        let sortByInt = filters["sortBy"] as? Int ?? 0
        let sortBy = YelpSortMode(rawValue: sortByInt)
        let term = searchBar.text ?? ""
        
        Business.searchWithTerm(term: term, sort: sortBy, categories: categories, deals: dealState, distance: distance, completion: {
            (businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses
                self.tableView.reloadData()
        })

        print("delegate fired in Business VC")
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.filters = filterStore
        filtersViewController.delegate = self
        
    }
    
}
