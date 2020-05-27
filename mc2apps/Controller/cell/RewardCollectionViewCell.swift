//
//  RewardCollectionViewCell.swift
//  mc2apps
//
//  Created by Agnes Felicia on 27/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class RewardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var rewardView: UIImageView!
    
    var reward: Reward! {
        didSet {
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI() {
        if let reward = reward {
            rewardView.image = UIImage(named: reward.rewardImage)
        } else {
            rewardView.image = nil
        }
    }

}
