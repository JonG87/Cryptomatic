//
//  Cryptocoin.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-06.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import Foundation
import UIKit

class Cryptocoin {
    var rank:               Int?
    var price_usd:          Double?
    var daily_volume_usd:   Double?
    var market_cap_usd:     Double?
    var percent_change_1h:  Double?
    var id:                 String?
    var name:               String?
    var symbol:             String?
    var price_btc:          String?
    var available_supply:   String?
    var total_supply:       String?
    var percent_change_24h: String?
    var percent_change_7d:  String?
    var last_updated:       String?
    
    init(data: [String: Any?]) {
        id                  = data[Coin.id] as? String ?? "unknown"
        symbol              = data[Coin.symbol] as? String ?? "UNKWN"
        name                = data[Coin.name] as? String ?? "Unknown"
        price_btc           = data[Coin.priceBTC] as? String ?? "N/A"
        available_supply    = data[Coin.availableSupply] as? String ?? "N/A"
        percent_change_7d   = data[Coin.percentChange7d] as? String ?? "N/A"
        percent_change_24h  = data[Coin.percentChange24h] as? String ?? "N/A"
        rank                = convertRankToInt(rankString: data[Coin.rank] as? String)
        price_usd           = convertToDouble(doubleString: data[Coin.priceUSD] as? String)
        daily_volume_usd    = convertToDouble(doubleString: data[Coin.dailyVolumeUSD] as? String)
        market_cap_usd      = convertToDouble(doubleString: data[Coin.marketCapUSD] as? String)
        percent_change_1h   = convertToDouble(doubleString: data[Coin.percentChange1h] as? String)
        total_supply        = data[Coin.totalSupply] as? String                                       //I dont use
        last_updated        = data[Coin.lastUpdated] as? String                                       //I dont use
    }
    
    func convertRankToInt(rankString: String?) -> Int{
        var intRank: Int
        if rankString != nil{
            intRank = Int(rankString!)!
        } else {
            intRank = 0
        }
        return intRank
    }
    
    func convertToDouble(doubleString: String?) -> Double{
        var double: Double
        if doubleString != nil{
            double = Double(doubleString!)!
        } else {
            double = 0
        }
        return double
    }
}
