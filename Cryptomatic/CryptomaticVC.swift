//
//  CryptomaticVC.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-08.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import UIKit

class CryptomaticVC: UIViewController, UISearchBarDelegate{

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hourChangeLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cryptocoins: [Cryptocoin]           = []
    var cryptocoinsFavorite: [Cryptocoin]   = []
    var cryptocoinsSearch: [Cryptocoin]     = []
    var sortedCryptocoins: [Cryptocoin]     = []
    var favorites: [String]                 = []
    var expandedRows                        = Set<Int>()
    var isAlphabetical      = Bool()
    var isPriceHighest      = Bool()
    var isChangeHighest     = Bool()
    var isRankedHighest     = Bool()
    var favIsAlphabetical   = Bool()
    var favIsPriceHighest   = Bool()
    var favIsChangeHighest  = Bool()
    var favIsRankedHighest  = Bool()
    let refreshControl      = UIRefreshControl()
    let defaults            = UserDefaults.standard
    let searchController    = UISearchController()
    let numberFormat        = NumberFormatter()
    let networkManager      = NetworkManager()
    let emptyFavoriteView   = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        setupNumberFormat()
        
        get100Coins()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.indicatorStyle = UIScrollView.IndicatorStyle.white
        
        //activityIndicator.startAnimating()
        tableView.isHidden = true
        view.setGradientBackground(colorOne: Colors.marinerBlue, colorTwo: Colors.pickledBlueWood)
        searchBar.delegate = self
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        //UserDefaults.standard.synchronize()
        favorites = defaults.stringArray(forKey: UserDefault.favoriteCoins) ?? [String]()
        
        handleGestures()
        // setupNumberFormat()
        setupRefreshControl()
        setupEmptyFavoriteView()
        //setupActivityIndicator()
        setupSearchBar()
    }

    func get100Coins() {
        networkManager.get100Coins{(coins, error) in
            DispatchQueue.main.async {
                self.cryptocoins.removeAll()
                for coin in coins! {
                    self.cryptocoins.append(coin)
                }
                //self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    func addToolbarToSearchBarKeyboard() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        let actionButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        actionButton.tintColor = UIColor.black
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, actionButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        searchBar.inputAccessoryView = toolBar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    func setupCell(indexPath: IndexPath, cell: CryptomaticTableViewCell, cryptocoinsArray: [Cryptocoin]) -> CryptomaticTableViewCell{
        
        cell.idLabel.text                                = cryptocoinsArray[indexPath.row].id
        cell.tickerLabel.text                              = cryptocoinsArray[indexPath.row].symbol
        cell.coinNameLabel.text                         = cryptocoinsArray[indexPath.row].name
        //cell.bitcoinPrice.text                      = cryptocoinsArray[indexPath.row].price_btc
        //cell.rankLabel.text                         = String(describing: cryptocoinsArray[indexPath.row].rank!)
        //cell.coinAvailabilityLabel.text             = cryptocoinsArray[indexPath.row].available_supply
        cell.volumeLabel.text                       = numberFormat.string(from: NSNumber(value: cryptocoinsArray[indexPath.row].daily_volume_usd!))
        cell.marketCapLabel.text                    = numberFormat.string(from: NSNumber(value: cryptocoinsArray[indexPath.row].market_cap_usd!))
        
        //        let usdprice                                = cryptocoinsArray[indexPath.row].price_usd!
        //        cell.usd_Price.text                         = numberFormat.string(from: NSNumber(value: usdprice))
        cell.priceLabel.text                         = numberFormat.string(from: NSNumber(value: cryptocoinsArray[indexPath.row].price_usd!))
        
        let hourPercentChange                       = cryptocoinsArray[indexPath.row].percent_change_1h!
        cell.hourlyChangeLabel.text                     = "\(String(describing:hourPercentChange))%"
        cell.hourlyChangeLabel.textColor                = getColorRating(colorRating: hourPercentChange)
        cell.hourlyLabel.text                       = "\(String(describing:hourPercentChange))%"
        cell.hourlyLabel.textColor                  = getColorRating(colorRating: hourPercentChange)
        
        cell.priceLabel.textColor                    = cell.hourlyChangeLabel.textColor
        cell.hourlyChangeBarView.backgroundColor    = cell.hourlyLabel.textColor
        
        let dailyPercentChance = cryptocoinsArray[indexPath.row].percent_change_24h!
        if (dailyPercentChance != "N/A"){
            cell.dailyLabel.text = "\(String(describing:dailyPercentChance))%"
            cell.dailyLabel.textColor = getColorRating(colorRating: (Double)(dailyPercentChance)!)
        } else {
            cell.dailyLabel.text = "N/A"
            cell.dailyLabel.textColor = UIColor.white
        }
        
        let weeklyPercentChance = cryptocoinsArray[indexPath.row].percent_change_7d!
        if (weeklyPercentChance != "N/A"){
            cell.weeklyLabel.text = "\(String(describing:weeklyPercentChance))%"
            cell.weeklyLabel.textColor = getColorRating(colorRating: (Double)(weeklyPercentChance)!)
        } else {
            cell.weeklyLabel.text = "N/A"
            cell.weeklyLabel.textColor = UIColor.white
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cell.favoriteImageView.isUserInteractionEnabled = true
        cell.favoriteImageView.addGestureRecognizer(tapGestureRecognizer)
        
        displayStarOrNot(cell: cell)
        
        cell.isExpanded = expandedRows.contains(indexPath.row)
        
        return cell
    }
    
    func displayStarOrNot(cell : CryptomaticTableViewCell){
        if favorites.count == 0 {
            cell.favoriteImageView.image = #imageLiteral(resourceName: "hollow_star")
        } else{
            for coin in favorites{
                if coin == cell.idLabel.text! {
                    cell.favoriteImageView.image = #imageLiteral(resourceName: "filled_star")
                    break
                } else {
                    cell.favoriteImageView.image = #imageLiteral(resourceName: "hollow_star")
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if let searchText = searchBar.text, !searchText.isEmpty {
            self.cryptocoinsSearch = cryptocoins.filter { coin in
                return (coin.name?.lowercased().contains(searchText.lowercased()))!
            }
        } else {
            //emptyFavoriteView.isHidden = false
            //tableView.isHidden = true
            //self.cryptocoinsSearch = self.cryptocoins
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
    
    @objc  func refreshData(sender: UIRefreshControl){
        get100Coins()
    }
    
    @IBAction func switchSegments(_ sender: Any) {
        if(self.segmentControl.selectedSegmentIndex == 0){
            emptyFavoriteView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
        if(self.segmentControl.selectedSegmentIndex == 1){
            if favorites.count == 0{
                tableView.isHidden = true
                emptyFavoriteView.isHidden = false
                tableView.reloadData()
            }else{
                tableView.isHidden = false
                emptyFavoriteView.isHidden = true
                tableView.reloadData()
            }
        }
    }
    
    
    func getColorRating(colorRating: Double ) -> UIColor{
        var color = UIColor()
        let indianRed = UIColor.init(red: 255/255, green: 92/255, blue: 92/255, alpha: 1)
        color = (colorRating > 0 ? UIColor.green : indianRed)
        return color
    }
    
    
}

    
    // MARK: - UITableViewDelegate
    extension CryptomaticVC: UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 155.0
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let cell = tableView.cellForRow(at: indexPath) as? CryptomaticTableViewCell
                else { return }
            
            switch cell.isExpanded
            {
            case true:
                expandedRows.remove(indexPath.row)
            case false:
                expandedRows.insert(indexPath.row)
            }
            
            cell.isExpanded = !cell.isExpanded
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
    }

    
    // MARK: - UITableViewDataSource
    
    extension CryptomaticVC: UITableViewDataSource{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            var count: Int = 0
            if (segmentControl.selectedSegmentIndex == 0){
                count = cryptocoins.count
                expandedRows.removeAll()
            }
            if (segmentControl.selectedSegmentIndex == 1){
                count = favorites.count
                expandedRows.removeAll()
                
            }
            if (searchBar.text != ""){
                count = cryptocoinsSearch.count
                expandedRows.removeAll()
            }
            return count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: Cell.cryptomaticCell, for: indexPath) as! CryptomaticTableViewCell
            
            if segmentControl.selectedSegmentIndex == 1 {
                let count = favorites.count > 0 ? favorites.count - 1 : 0
                if(favorites.count == cryptocoinsFavorite.count && favorites.count != 0){
                    cell = setupCell(indexPath: indexPath, cell: cell, cryptocoinsArray: cryptocoinsFavorite)
                }else if(favorites.count == 0){
                    print("Nothing to display")
                }else{
                    cryptocoinsFavorite.removeAll()
                    for i in 0...count{
                        cryptocoinsFavorite += cryptocoins.filter {$0.id == favorites[i]}
                    }
                    cell = setupCell(indexPath: indexPath, cell: cell, cryptocoinsArray: cryptocoinsFavorite)
                }
            }
            
            if segmentControl.selectedSegmentIndex == 0 {
                cell = setupCell(indexPath: indexPath, cell: cell, cryptocoinsArray: cryptocoins)
            }
            
            if (searchBar.text != ""){
                cell = setupCell(indexPath: indexPath, cell: cell, cryptocoinsArray: cryptocoinsSearch)
            }
            return cell
        }
    }


