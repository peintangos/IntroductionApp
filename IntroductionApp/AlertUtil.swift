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
        var alert = UIAlertController(title: "参加人数を入力してね", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "４人", style: UIAlertAction.Style.default, handler: { (action) in
            let pf = PlayFieldViewController()
            pf.modalPresentationStyle = .fullScreen
            vc.present(pf, animated: true, completion: nil)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
}
