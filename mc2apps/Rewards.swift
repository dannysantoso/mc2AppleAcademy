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
            Reward(rewardName: "Sing your heart out", rewardImage: "reward 1"),
            Reward(rewardName: "Savor some guilty pleasure", rewardImage: "reward 2"),
            Reward(rewardName: "Inhale..., Exhale....", rewardImage: "reward 3"),
            Reward(rewardName: "I just call to say I love you", rewardImage: "reward 4"),
            Reward(rewardName: "Slay your stress dragon", rewardImage: "reward 5"),
            Reward(rewardName: "Travel to the world of imagination", rewardImage: "reward 6"),
            Reward(rewardName: "Laugh your stress off", rewardImage: "reward 7")
        ]
    }

}
