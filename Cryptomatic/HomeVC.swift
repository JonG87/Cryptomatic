//
//  HomeVC.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-06.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var totalMarketCapLabel: UILabel!
    @IBOutlet weak var totalDailyVolumeLabel: UILabel!
    @IBOutlet weak var bitcoinPercentOfMarketLabel: UILabel!
    @IBOutlet weak var activeCurrenciesLabel: UILabel!
    @IBOutlet weak var activeAssetsLabel: UILabel!
    @IBOutlet weak var activeMarketsLabel: UILabel!
    
    
    @IBOutlet weak var cryptocoinNameRank1: UILabel!
    @IBOutlet weak var cryptocoinNameRank2: UILabel!
    @IBOutlet weak var cryptocoinNameRank3: UILabel!
    
    @IBOutlet weak var cryptocoinPriceRank1: UILabel!
    @IBOutlet weak var cryptocoinPriceRank2: UILabel!
    @IBOutlet weak var cryptocoinPriceRank3: UILabel!
    
    @IBOutlet weak var activityIndicatorPriceRank1: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorPriceRank2: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorPriceRank3: UIActivityIndicatorView!
    
    let imageArray: [UIImage]           = [#imageLiteral(resourceName: "bitcoin"),#imageLiteral(resourceName: "digitalcoin"),#imageLiteral(resourceName: "dogecoin"),#imageLiteral(resourceName: "feathercoin"),#imageLiteral(resourceName: "litecoin"),#imageLiteral(resourceName: "ethereum"),#imageLiteral(resourceName: "ripple"),#imageLiteral(resourceName: "namecoin_black")]
    var top3Coins: [Cryptocoin]         = []
    var top3CoinsArray: [Cryptocoin]    = []
    var tempArray: [Cryptocoin]         = []
    let networkManager                  = NetworkManager()
    let numberFormat                    = NumberFormatter()
    var CMCGD: CoinMarketCapGlobalData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.marinerBlue, colorTwo: Colors.pickledBlueWood)
        makeItRainCoins()
        setupNumberFormat()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        startActivityIndicator()
        getTop3Coins()
        getGlobalData()
    }
    
    func startActivityIndicator() {
        activityIndicatorPriceRank1.startAnimating()
        activityIndicatorPriceRank2.startAnimating()
        activityIndicatorPriceRank3.startAnimating()
    }
    
    func getGlobalData() {
        networkManager.getCoinMarketCapGlobalData{( CoinMarketCapData, error) in
            self.CMCGD = CoinMarketCapData
            DispatchQueue.main.async {
                self.totalMarketCapLabel.text = self.numberFormat.string(from: NSNumber(value: self.CMCGD.total_market_cap_usd!))
                self.totalDailyVolumeLabel.text = self.numberFormat.string(from: NSNumber(value: self.CMCGD.total_24h_volume_usd!))
                self.bitcoinPercentOfMarketLabel.text = "\(String(self.CMCGD.bitcoin_percentage_of_market_cap!))%"
                self.activeCurrenciesLabel.text = String(self.CMCGD.active_currencies!)
                self.activeAssetsLabel.text = String(self.CMCGD.active_assets!)
                self.activeMarketsLabel.text = String(self.CMCGD.active_markets!)
            }
        }
    }
    
    func getTop3Coins() {
        networkManager.getTop3Coins{(coins, error) in
            DispatchQueue.main.async {
                self.top3Coins.removeAll()
                for coin in coins! {
                    self.top3Coins.append(coin)
                }
                
                
                self.cryptocoinNameRank1.text = self.top3Coins[0].name ?? "None"
                self.cryptocoinNameRank2.text = self.top3Coins[1].name ?? "None"
                self.cryptocoinNameRank3.text = self.top3Coins[2].name ?? "None"
                
                self.cryptocoinPriceRank1.text = self.numberFormat.string(from: NSNumber(value: self.top3Coins[0].price_usd!))
                self.activityIndicatorPriceRank1.stopAnimating()
                self.activityIndicatorPriceRank1.hidesWhenStopped = true
                self.cryptocoinPriceRank2.text = self.numberFormat.string(from: NSNumber(value: self.top3Coins[1].price_usd!))
                self.activityIndicatorPriceRank2.stopAnimating()
                self.activityIndicatorPriceRank2.hidesWhenStopped = true
                self.cryptocoinPriceRank3.text = self.numberFormat.string(from: NSNumber(value: self.top3Coins[2].price_usd!))
                self.activityIndicatorPriceRank3.stopAnimating()
                self.activityIndicatorPriceRank3.hidesWhenStopped = true
            }
            
        }
    }

    
    func makeItRainCoins(){
        let emitter = Emitter.get(with: randomImageGenerator())
        emitter.emitterPosition = CGPoint(x: view.frame.width/2, y:0)
        emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
        view.layer.addSublayer(emitter)
    }
    
    func randomImageGenerator() -> UIImage {
        let randomIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
        let randomImage = imageArray[randomIndex]
        return randomImage
    }
    
    func setupNumberFormat(){
        numberFormat.currencySymbol = "$"
        numberFormat.groupingSeparator = ","
        numberFormat.numberStyle = NumberFormatter.Style.currency
    }
}
