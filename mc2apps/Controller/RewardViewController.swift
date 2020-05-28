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
    
    var selectedProject : Project?
    var rewards = Rewards.fetchReward()
    var cellScale: CGFloat = 0.6
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showFirstAlert()
        setLayout()
        
        rewardCollectionView.dataSource = self
        rewardCollectionView.register(UINib(nibName: "RewardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RewardCollectionViewCell")
    }
    
    func showFirstAlert() {
        let alert = UIAlertController(title: "Recommendation" , message: "Here’s some recommendation from us for ‘Self Reward’", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setLayout() {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let instX = (view.bounds.width - cellWidth) / 2.0
        let instY = (view.bounds.height - cellHeight) / 2.0
        let layout = rewardCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        rewardCollectionView.contentInset = UIEdgeInsets(top: instY, left: instX, bottom: instY, right: instX)
        
    }
    
    @IBAction func wantButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reward Selected", message: "Please enjoy this reward", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default) { _ in
 //           self.navigationController?.popToRootViewController(animated: true)
//            let destination = MilestoneViewController(nibName: "MilestoneViewController", bundle: nil)
//            destination.selectedProject = self.selectedProject
//            destination.nameProject = self.selectedProject!.projectName
//            destination.nameClient = self.selectedProject!.clientName
//            destination.deadline = self.selectedProject!.deadline
//            destination.rewardProject = self.selectedProject!.projectCompletionReward
//            destination.isCompleted = self.selectedProject!.isCompleted
//            destination.colorProject = self.selectedProject!.color
//            destination.completionReward = self.selectedProject!.projectCompletionReward
//            self.navigationController?.popToViewController(destination, animated: true)
            self.popBack(4)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RewardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
