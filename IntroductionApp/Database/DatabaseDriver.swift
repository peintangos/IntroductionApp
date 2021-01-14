//
//  DatabaseDriver.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/13.
//

import Foundation
import Realm
import RealmSwift

class DatabaseDriver{
    func save(name:String,playerId:Int,quesiontId:Int,answerId:Int,gender:Int,playerCounts:Int,gameNumber:Int){
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let impression = ImpressionResult()
        impression.name = name
        impression.playerId = playerId
        impression.questionId = quesiontId
        impression.answerId = answerId
        impression.gender = gender
        impression.playerCounts = playerCounts
        impression.gameNumber = gameNumber
        try! realm.write{
            realm.add(impression)
        }
    }
}
