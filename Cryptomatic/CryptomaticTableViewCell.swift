//
//  CryptomaticTableVIewCell.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-08.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import UIKit

class CryptomaticTableViewCell: UITableViewCell {
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var hourlyChangeBarView: UIView!
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var hourlyChangeLabel: UILabel!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var hourlyLabel: UILabel!
    @IBOutlet weak var dailyLabel: UILabel!
    @IBOutlet weak var weeklyLabel: UILabel!
    
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var coinAvailabilityLabel: UILabel!
    
    
    @IBOutlet weak var viewContainerHeightConstant: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var isExpanded: Bool = false
    {
        didSet
        {
            if !isExpanded {
                viewContainerHeightConstant.constant = 0.0
                //hourlyChangeBarHeight.constant = 29
            } else {
                viewContainerHeightConstant.constant = 100
                //hourlyChangeBarHeight.constant = 145
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
