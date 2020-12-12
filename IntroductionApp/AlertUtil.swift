//
//  AlertUtil.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/03.
//

import Foundation
import UIKit

class AlertUtil{
    func makeAlert(vc:UIViewController){
        let alert = UIAlertController(title: "参加人数を入力してね", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "3人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 3
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .formSheet
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "４人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 4
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .formSheet
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "5人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 5
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .formSheet
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "6人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 6
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .formSheet
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "7人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 7
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .formSheet
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "8人", style: UIAlertAction.Style.default, handler: { (action) in
            playerNumbers = 8
            let pf = BeforePlayFirstPlayer()
            pf.modalPresentationStyle = .formSheet
            vc.present(pf, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    func makeAnswer(vc:UIViewController,nextVc:UIViewController){
        questionNumber += 1
        let alert = UIAlertController(title: "選んでね！", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        memberList.forEach { (player) in
            alert.addAction(UIAlertAction(title: player.getName(), style: UIAlertAction.Style.default, handler: { (action) in
                vc.dismiss(animated: true, completion: nil)
                vc.presentingViewController?.present(nextVc, animated: true, completion: nil)
            }))
        }
        vc.modalPresentationStyle = .fullScreen
        vc.present(alert, animated: true, completion: nil)
    }
    func makeLastAnswer(vc:UIViewController){
        count += 1
        let alert = UIAlertController(title: "選んでね！", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        memberList.forEach { (player) in
            alert.addAction(UIAlertAction(title: player.getName(), style: UIAlertAction.Style.default, handler: { (action) in
//                vc.dismiss(animated: true, completion: nil)
                if count == playerNumbers {
                    self.showResult(vc: vc, nextVc: ResultsViewController())
                }else {
                    vc.dismiss(animated: true, completion: nil)
                    self.makeTurn(vc: vc.presentingViewController!, nextVc: PlayFieldFirstViewController(), text: memberList[count].getName())
                }
                
            }))
        }
        vc.present(alert, animated: true, completion: nil)
    }
    func makeTurn(vc:UIViewController,nextVc:UIViewController,text:String){
        let alert = UIAlertController(title: text+"さんに回してね", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: {(action) in
            vc.present(nextVc, animated: true, completion: nil)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    func showResult(vc:UIViewController,nextVc:UIViewController){
        let alert = UIAlertController(title: "結果発表へ🍺", message: "心の準備はいい？？", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "見にいく", style: UIAlertAction.Style.default, handler: { (action) in
            print(vc)
            print(vc.presentingViewController)
            print(vc.presentationController?.presentingViewController)
            print(vc.presentingViewController?.presentingViewController?.presentingViewController)
            print(vc.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController)
            vc.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.present(nextVc, animated: true, completion: nil)
        }))
        vc.presentingViewController?.present(alert, animated: true, completion: nil)
    }
}

