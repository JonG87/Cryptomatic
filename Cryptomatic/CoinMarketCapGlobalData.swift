//
//  CoinMarketCapGlobalData.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-06.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import Foundation

class CoinMarketCapGlobalData {
    var bitcoin_percentage_of_market_cap:   Double?
    var total_market_cap_usd:               Int?
    var total_24h_volume_usd:               Int?
    var active_currencies:                  Int?
    var active_assets:                      Int?
    var active_markets:                     Int?
    
    
    init(bitcoin_percentage_of_market_cap: Double?, total_market_cap_usd: Int?, total_24h_volume_usd: Int?, active_currencies: Int?,active_assets: Int?,active_markets: Int?){
        self.bitcoin_percentage_of_market_cap   = bitcoin_percentage_of_market_cap
        self.total_market_cap_usd               = total_market_cap_usd
        self.total_24h_volume_usd               = total_24h_volume_usd
        self.active_currencies                  = active_currencies
        self.active_assets                      = active_assets
        self.active_markets                     = active_markets
    }
}
