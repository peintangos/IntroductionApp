//
//  ResultDisplay.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/13.
//

import Foundation

class ResultDisplay{
    private var player:Player!
//    memberListのindex
    private var countId:Int!
    private var questionNumber:Int!
    private var answer:Int!
    private var demandedSum:Int!
    init(player:Player,countId:Int,questionNumber:Int,answer:Int,demandedSum:Int) {
        self.player = player
        self.countId = countId
        self.questionNumber = questionNumber
        self.answer = answer
        self.demandedSum = demandedSum
    }
    func getPlayer() ->Player{
        return self.player
    }
    func getCountId() ->Int{
        return self.countId
    }
    func getQuestionNumber() ->Int{
        return self.questionNumber
    }
    func getAnswer() ->Int{
        return self.answer
    }
    func getDemandedSum() ->Int{
        return self.demandedSum
    }
}
