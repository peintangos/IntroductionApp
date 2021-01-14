//
//  ImpressionResult.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/13.
//

import Foundation
import RealmSwift
import UIKit

class ImpressionResult: Object{
    @objc dynamic var id = Int.random(in: 0..<1000000)
    @objc dynamic var name = "デフォルト"
    @objc dynamic var playerId = 0
    @objc dynamic var questionId = 0
    @objc dynamic var answerId = 0
    @objc dynamic var gender = 0
    @objc dynamic var playerCounts = 4
    @objc dynamic var gameNumber = 0
}
