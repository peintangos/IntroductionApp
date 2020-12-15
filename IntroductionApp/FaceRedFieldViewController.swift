//
//  FaceRedFieldViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/05.
//

import UIKit
import RxSwift
import YogaKit
import ChameleonFramework

class FaceRedFieldViewController: BeforePlayViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .red
        // Do any additional setup after loading the view.
        doLayout()
        doRouterForRedFace()
    }
    override func viewWillAppear(_ animated: Bool) {
        conditionClearForRedFace()
    }
    override func doRouter() {
        self.nextButton.rx.tap.subscribe { (action) in
            self.dismiss(animated: true, completion: nil)
            let vc = BeforePlayThirdPlayer()
            vc.modalPresentationStyle = .fullScreen
            self.presentingViewController!.present(vc, animated: true, completion: nil)
        }.disposed(by: dispose)
    }
}
