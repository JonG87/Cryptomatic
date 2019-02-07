//
//  Constants.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-05.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
    static let marinerBlue      = UIColor.init(red: 41/255.0, green: 128/255.0, blue: 185/255.0, alpha: 1)
    static let pickledBlueWood  = UIColor.init(red: 44/255.0, green: 62/255.0, blue: 80/255.0, alpha: 1)
}

struct UserDefault {
    static let favoriteCoins    = "FavoriteCoins"
}

struct Cell {
    static let cryptomaticCell  = "CryptomaticCell"
}

struct Coin {
    static let id               = "id"
    static let symbol           = "symbol"
    static let name             = "name"
    static let priceBTC         = "price_btc"
    static let availableSupply  = "available_supply"
    static let percentChange7d  = "percent_change_7d"
    static let percentChange24h = "percent_change_24h"
    static let rank             = "rank"
    static let priceUSD         = "price_usd"
    static let dailyVolumeUSD   = "24h_volume_usd"
    static let marketCapUSD     = "market_cap_usd"
    static let percentChange1h  = "percent_change_1h"
    static let totalSupply      = "total_supply"                                      //I dont use
    static let lastUpdated      = "last_updated"                                      //I dont use
}

struct GlobalData {
    static let bitcoinPercentageOfMarketCap = "bitcoin_percentage_of_market_cap"
    static let totalMarketCapUSD            = "total_market_cap_usd"
    static let total24hVolumeUSD            = "total_24h_volume_usd"
    static let activeCurrencies             = "active_currencies"
    static let activeAssets                 = "active_assets"
    static let activeMarkets                = "active_markets"
}

struct EndPoints {
    static let allCoins                     = "https://api.coinmarketcap.com/v1/ticker/?limit=0"
    static let top3Coins                    = "https://api.coinmarketcap.com/v1/ticker/?limit=3"
    static let coinMarketCapGlobalData      = "https://api.coinmarketcap.com/v1/global/"
}
