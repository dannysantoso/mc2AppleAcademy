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
        
        showFirstAlert()
        
        rewardCollectionView.dataSource = self
        rewardCollectionView.register(UINib(nibName: "RewardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RewardCollectionViewCell")
    }
    
    func showFirstAlert() {
        let alert = UIAlertController(title: "Recommendation" , message: "Here’s some recommendation from us for ‘Self Reward’", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func wantButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reward Selected", message: "Please enjoy this reward", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
//            let destination = MilestoneViewController(nibName: "MilestoneViewController", bundle: nil)
//            self.navigationController?.pushViewController(destination, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RewardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.75
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
}
