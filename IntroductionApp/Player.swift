//
//  Player.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/12.
//

import Foundation
import UIKit
class Player{
    private var id = Int.random(in: 1..<100000)
    private var name:String
    private var gender:Int
    private var image:UIImage
    init(id:Int,name:String,image:UIImage,gender:Int) {
        self.id = id
        self.name = name
        self.image = image
        self.gender = gender
    }
    init(name:String,image:UIImage,gender:Int) {
        self.name = name
        self.image = image
        self.gender = gender
    }
    func getImage() -> UIImage{
        return self.image
    }
    func getName() ->String{
        return self.name
    }
    func getGender() -> Int{
        return self.gender
    }
    func hanteiOtherGender(aiteGender:Int) ->Bool{
        return gender != aiteGender ? true : false
    }
}
