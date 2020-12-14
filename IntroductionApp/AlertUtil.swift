//
//  AlertUtil.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/03.
//

import Foundation
import UIKit
import RealmSwift

class AlertUtil{
    func makeAlert(vc:UIViewController){
        let alert = UIAlertController(title: "参加人数を入力してね", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "3人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 3
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .fullScreen
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "４人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 4
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .fullScreen
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "5人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 5
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .fullScreen
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "6人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 6
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .fullScreen
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "7人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 7
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .fullScreen
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "8人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 8
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .fullScreen
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    func makeAnswer(vc:UIViewController,nextVc:UIViewController,databaseDriver:DatabaseDriver,player:Player){
        let alert = UIAlertController(title: "選んでね！", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        memberList.forEach { (playerElement) in
            alert.addAction(UIAlertAction(title: playerElement.getName(), style: UIAlertAction.Style.default, handler: { (action) in
                vc.dismiss(animated: true, completion: nil)
                databaseDriver.save(name: player.getName(), playerId: count, quesiontId: questionNumber, answerId: alert.actions.firstIndex(of: action)!, gender: player.getGender(), playerCounts: playerNumbers!, gameNumber: gameNumber)
                CountUp.countUpOne(count: &questionNumber)
                nextVc.modalPresentationStyle = .fullScreen
                vc.presentingViewController?.present(nextVc, animated: true, completion: nil)
            }))
        }
        vc.modalPresentationStyle = .fullScreen
        vc.present(alert, animated: true, completion: nil)
    }
//    対象相手が異性のみのアクションシートです。最後におくとめんどくさいのでその手の質問は最後より前の部分に置くこと
    func makeAnswerOtherGender(vc:UIViewController,nextVc:UIViewController,databaseDriver:DatabaseDriver,player:Player){
        let alert = UIAlertController(title: "選んでね！", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        memberList.forEach { (playerElement) in
            if player.hanteiOtherGender(aiteGender: playerElement.getGender()){
                alert.addAction(UIAlertAction(title: playerElement.getName(), style: UIAlertAction.Style.default, handler: { (action) in
                    vc.dismiss(animated: true, completion: nil)
                    alert.actions.firstIndex(of: action)
                    databaseDriver.save(name: player.getName(), playerId: count, quesiontId: questionNumber, answerId: alert.actions.firstIndex(of: action)!, gender: player.getGender(), playerCounts: playerNumbers!, gameNumber: gameNumber)
                    CountUp.countUpOne(count: &questionNumber)
                    nextVc.modalPresentationStyle = .fullScreen
                    vc.presentingViewController?.present(nextVc, animated: true, completion: nil)
                    
                }))
            }
        }
        vc.modalPresentationStyle = .fullScreen
        vc.present(alert, animated: true, completion: nil)
    }
    func makeLastAnswer(vc:UIViewController,databaseDriver:DatabaseDriver,player:Player){
        let alert = UIAlertController(title: "選んでね！", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        memberList.forEach { (playerElement) in
            alert.addAction(UIAlertAction(title: playerElement.getName(), style: UIAlertAction.Style.default, handler: { (action) in
//                ここで、参照元を消さないとうまく画面遷移できない。
                vc.dismiss(animated: true, completion: nil)
                databaseDriver.save(name: player.getName(), playerId: count, quesiontId: questionNumber, answerId: alert.actions.firstIndex(of: action)!, gender: player.getGender(), playerCounts: playerNumbers!, gameNumber: gameNumber)
                CountUp.countUpOne(count: &count)
                if count == playerNumbers {
                    self.showResult(vc: vc, nextVc: ResultsViewController())
                }else {
//                    vc.dismiss(animated: true, completion: nil)
                    self.makeTurn(vc: vc.presentingViewController!, nextVc: PlayFieldFirstViewController(), text: memberList[count].getName())
                }
            }))
        }
        vc.modalPresentationStyle = .fullScreen
        vc.present(alert, animated: true, completion: nil)
    }
    func makeTurn(vc:UIViewController,nextVc:UIViewController,text:String){
//        質問番号を初期化
        questionNumber = 0
        let alert = UIAlertController(title: text+"さんに回してね", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: {(action) in
            nextVc.modalPresentationStyle = .fullScreen
            vc.present(nextVc, animated: true, completion: nil)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    func showResult(vc:UIViewController,nextVc:UIViewController){
        let alert = UIAlertController(title: "結果発表へ🍺", message: "心の準備はいい？？", preferredStyle: UIAlertController.Style.alert)
        vc.dismiss(animated: true, completion: nil)
        alert.addAction(UIAlertAction.init(title: "見にいく", style: UIAlertAction.Style.default, handler: { (action) in
            nextVc.modalPresentationStyle = .fullScreen
            parentView.dismiss(animated: true, completion: nil)
            parentView.presentingViewController?.present(nextVc, animated: true, completion: nil)
        }))
        vc.presentingViewController?.present(alert, animated: true, completion: nil)
    }
}

