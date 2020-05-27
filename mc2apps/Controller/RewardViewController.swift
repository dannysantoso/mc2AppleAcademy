//
//  RewardViewController.swift
//  mc2apps
//
//  Created by Agnes Felicia on 26/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit


class RewardViewController: UIViewController {

    @IBOutlet weak var rewardCollectionView: UICollectionView!
    @IBOutlet weak var wantButton: UIButton! {
        didSet {
            wantButton.layer.cornerRadius = 27.5
        }
    }
    
    var rewards = Rewards.fetchReward()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rewardCollectionView.dataSource = self
        rewardCollectionView.register(UINib(nibName: "RewardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RewardCollectionViewCell")
    }
}

extension RewardViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rewards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardCollectionViewCell", for: indexPath) as! RewardCollectionViewCell
        
        let reward = rewards[indexPath.item]
        
        cell.reward = reward
        
        return cell
    }
}
