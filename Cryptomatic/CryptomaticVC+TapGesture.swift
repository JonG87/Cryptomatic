//
//  CryptomaticVC+TapGesture.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-08.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import Foundation
import UIKit

extension CryptomaticVC{
    @objc func handleGestures(){
        let tapGestureCoin = UITapGestureRecognizer(target: self, action: #selector(tapGestureCoin(_:)))
        coinLabel.addGestureRecognizer(tapGestureCoin)
        coinLabel.isUserInteractionEnabled = true
        
        let tapGestureUSD = UITapGestureRecognizer(target: self, action: #selector(tapGestureUSD(_:)))
        usdLabel.addGestureRecognizer(tapGestureUSD)
        usdLabel.isUserInteractionEnabled = true
        
        let tapGestureHourChange = UITapGestureRecognizer(target: self, action: #selector(tapGestureHourChange(_:)))
        hourChangeLabel.addGestureRecognizer(tapGestureHourChange)
        hourChangeLabel.isUserInteractionEnabled = true
        
//        let tapGestureRank = UITapGestureRecognizer(target: self, action: #selector(tapGestureRank(_:)))
//        rankLabel.addGestureRecognizer(tapGestureRank)
//        rankLabel.isUserInteractionEnabled = true
    }
    
    @objc func tapGestureRank(_ sender: UITapGestureRecognizer) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if !isRankedHighest{
                cryptocoins = cryptocoins.sorted {$0.rank! > $1.rank!}
                isRankedHighest = true
            } else {
                cryptocoins = cryptocoins.sorted {$0.rank! < $1.rank!}
                isRankedHighest = false
            }
            tableView.reloadData()
        case 1:
            if !favIsRankedHighest{
                cryptocoinsFavorite = cryptocoinsFavorite.sorted {$0.rank! > $1.rank!}
                favIsRankedHighest = true
            } else {
                cryptocoinsFavorite = cryptocoinsFavorite.sorted {$0.rank! < $1.rank!}
                favIsRankedHighest = false
            }
            tableView.reloadData()
        default:
            break
        }
    }
    
    @objc func tapGestureCoin(_ sender: UITapGestureRecognizer) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if !isAlphabetical{
                cryptocoins = cryptocoins.sorted {$0.symbol! > $1.symbol!}
                isAlphabetical = true
            } else {
                cryptocoins = cryptocoins.sorted {$0.symbol! < $1.symbol!}
                isAlphabetical = false
            }
            tableView.reloadData()
        case 1:
            if !favIsAlphabetical{
                cryptocoinsFavorite = cryptocoinsFavorite.sorted {$0.symbol! > $1.symbol!}
                favIsAlphabetical = true
            } else {
                cryptocoinsFavorite = cryptocoinsFavorite.sorted {$0.symbol! < $1.symbol!}
                favIsAlphabetical = false
            }
            tableView.reloadData()
        default:
            break
        }
    }
    
    @objc func tapGestureUSD(_ sender: UITapGestureRecognizer) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if !isPriceHighest{
                cryptocoins = cryptocoins.sorted {$0.price_usd! > $1.price_usd!}
                isPriceHighest = true
            } else {
                cryptocoins = self.cryptocoins.sorted {$0.price_usd! < $1.price_usd!}
                isPriceHighest = false
            }
            self.tableView.reloadData()
        case 1:
            if !favIsPriceHighest{
                cryptocoinsFavorite = cryptocoinsFavorite.sorted {$0.price_usd! > $1.price_usd!}
                favIsPriceHighest = true
            } else {
                cryptocoinsFavorite = cryptocoinsFavorite.sorted {$0.price_usd! < $1.price_usd!}
                favIsPriceHighest = false
            }
            self.tableView.reloadData()
        default:
            break
        }
    }
    
    @objc func tapGestureHourChange(_ sender: UITapGestureRecognizer){
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if !isChangeHighest{
                cryptocoins = self.cryptocoins.sorted {$0.percent_change_1h! > $1.percent_change_1h!}
                isChangeHighest = true
            } else {
                cryptocoins = self.cryptocoins.sorted {$0.percent_change_1h! < $1.percent_change_1h!}
                isChangeHighest = false
            }
            self.tableView.reloadData()
        case 1:
            if !favIsChangeHighest{
                cryptocoinsFavorite = cryptocoinsFavorite.sorted {$0.percent_change_1h! > $1.percent_change_1h!}
                favIsChangeHighest = true
            } else {
                cryptocoinsFavorite = cryptocoinsFavorite.sorted {$0.percent_change_1h! < $1.percent_change_1h!}
                favIsChangeHighest = false
            }
            tableView.reloadData()
        default:
            break
        }
    }
    
    //Tapped images event happens and changes the uiimage to a filled star or a hollow star. It also adds the string of the coin to an array called favorites
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let tappedLocation = tapGestureRecognizer.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: tappedLocation)
        let cell = tableView.cellForRow(at: indexPath!) as! CryptomaticTableViewCell
        
        if tappedImage.image != #imageLiteral(resourceName: "filled_star"){
            tappedImage.image = #imageLiteral(resourceName: "filled_star")
            favorites.append(cell.idLabel.text!)
            defaults.set(favorites, forKey: UserDefault.favoriteCoins)
            print(cell.idLabel.text!)
            dump(favorites)
        } else {
            tappedImage.image = #imageLiteral(resourceName: "hollow_star")
            favorites = favorites.filter{$0 != cell.idLabel.text}
            dump(favorites)
            defaults.set(favorites, forKey: UserDefault.favoriteCoins)
            print(cell.idLabel.text!)
            if (segmentControl.selectedSegmentIndex == 1){
                tableView.reloadData()
            }
        }
    }
}
