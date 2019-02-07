//
//  NetworkManager.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-05.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    init() {}
    
    
        func getAllCoins(completed: @escaping (([Cryptocoin]?, Error?) -> Void)){
            
            let endpoint: String = EndPoints.allCoins
            guard let url = URL(string: endpoint) else {
                print("Error making connection to endpoint")
                return
            }
            let urlRequest = URLRequest(url: url)
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest,
                                        completionHandler: {(data: Data?, response: URLResponse?, error: Error?) in
                                            if let response = response {
                                                print(response)
                                            }
                                            if let error = error{
                                                print(error)
                                            }
                                            guard let responseData = data else {
                                                print("Error, did not receive data")
                                                return
                                            }
                                            do {
                                                guard let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [[String : Any]] else {
                                                    print("Error conversion from JSON failed")
                                                    return
                                                }
                                                
                                                var tempArray: [Cryptocoin] = []
                                                for coin in json {
                                                    let newCoin = Cryptocoin(data: coin)
                                                    tempArray.append(newCoin)
                                                }
                                                completed(tempArray, nil)
                                                
                                            } catch {
                                                print("Error trying to convert data to JSON")
                                                return
                                            }
            })
            task.resume()
        }


        func getTop3Coins(completed: @escaping (([Cryptocoin]?,  Error?) -> Void)) {
            
            let endpoint: String = EndPoints.top3Coins
            let url = URL(string: endpoint)
            let urlRequest = URLRequest(url: url!)
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest,
                                        completionHandler: {(data: Data?, response: URLResponse?, error: Error?) in
                                            
                                            if let response = response {
                                                print(response)
                                            }
                                            
                                            if let error = error{
                                                print(error)
                                            }
                                            
                                            guard let responseData = data else {
                                                print("Error, did not receive data")
                                                return
                                            }
                                            
                                            do {
                                                guard let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [[String : Any]] else {
                                                    print("Error conversion from JSON failed")
                                                    return
                                                }
                                                
                                                var tempArray: [Cryptocoin] = []
                                                
                                                for coin in json {
                                                    let newCoin = Cryptocoin(data: coin)
                                                    tempArray.append(newCoin)
                                                }
                                                completed(tempArray, nil)
                                                
                                            } catch {
                                                print("Error trying to convert data to JSON")
                                                return
                                            }
            })
            task.resume()
        }

        func getCoinMarketCapGlobalData(completed: @escaping ((CoinMarketCapGlobalData?,  Error?) -> Void)) {
            
            let endpoint: String = EndPoints.coinMarketCapGlobalData
            let url = URL(string: endpoint)
            let urlRequest = URLRequest(url: url!)
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest,
                                        completionHandler: {(data: Data?, response: URLResponse?, error: Error?) in
                                            
                                            if let response = response {
                                                print(response)
                                            }
                                            
                                            if let error = error{
                                                print(error)
                                            }
                                            
                                            guard let responseData = data else {
                                                print("Error, did not receive data")
                                                return
                                            }
                                            
                                            do {
                                                guard let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String : Any] else {
                                                    print("Error conversion from JSON failed")
                                                    return
                                                }
                                                
                                                let tempCMCGD = CoinMarketCapGlobalData(
                                                    bitcoin_percentage_of_market_cap:   json[GlobalData.bitcoinPercentageOfMarketCap] as? Double ?? 0.0,
                                                    total_market_cap_usd:               json[GlobalData.totalMarketCapUSD] as? Int ?? 0,
                                                    total_24h_volume_usd:               json[GlobalData.total24hVolumeUSD] as? Int ?? 0,
                                                    active_currencies:                  json[GlobalData.activeCurrencies] as? Int ?? 0,
                                                    active_assets:                      json[GlobalData.activeAssets] as? Int ?? 0,
                                                    active_markets:                     json[GlobalData.activeMarkets] as? Int ?? 0)
                                                
                                                completed(tempCMCGD, nil)
                                            } catch {
                                                print("Error trying to convert data to JSON")
                                                return
                                            }
            })
            task.resume()
        }
}
