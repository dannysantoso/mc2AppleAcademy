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
            Reward(rewardName: "Read a Book", rewardImage: "read"),
            Reward(rewardName: "Call Someone", rewardImage: "call"),
            Reward(rewardName: "Play Game", rewardImage: "game"),
            Reward(rewardName: "Watch Funny Video", rewardImage: "video")
        ]
    }

}
