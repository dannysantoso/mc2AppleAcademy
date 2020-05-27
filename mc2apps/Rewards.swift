//
//  Reward.swift
//  mc2apps
//
//  Created by Agnes Felicia on 27/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import Foundation

struct Reward {
    var rewardName: String
    var rewardImage: String
}

class Rewards {

    static func fetchReward() -> [Reward] {
        return [
            Reward(rewardName: "music", rewardImage: "reward 1"),
            Reward(rewardName: "food", rewardImage: "reward 2"),
            Reward(rewardName: "air", rewardImage: "reward 3"),
            Reward(rewardName: "call", rewardImage: "reward 4"),
            Reward(rewardName: "game", rewardImage: "reward 5"),
            Reward(rewardName: "read", rewardImage: "reward 6"),
            Reward(rewardName: "video", rewardImage: "reward 7")
        ]
    }

}
