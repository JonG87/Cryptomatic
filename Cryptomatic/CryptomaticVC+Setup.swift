//
//  CryptomaticVC+Setup.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-08.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import Foundation
import UIKit

extension CryptomaticVC{
    func setupNumberFormat(){
        numberFormat.maximumFractionDigits = 4
        numberFormat.currencySymbol = "$"
        numberFormat.groupingSeparator = ","
        numberFormat.numberStyle = NumberFormatter.Style.currency
    }
    
    func setupRefreshControl(){
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = UIColor.white
        refreshControl.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
    }
    func setupActivityIndicator(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.white
        view.addSubview(activityIndicator)
    }
    
    func setupEmptyFavoriteView(){
        emptyFavoriteView.textColor = UIColor.white
        emptyFavoriteView.text = "Your favorites is empty!"
        emptyFavoriteView.center = self.view.center
        emptyFavoriteView.isHidden = true
        view.addSubview(emptyFavoriteView)
    }
    
    func setupSearchBar(){
        searchBar.delegate = self
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        addToolbarToSearchBarKeyboard()
    }
}
