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
        doConfigureForRedFace()
        playSound(name: "aaa")
    }
    override func viewWillAppear(_ animated: Bool) {
        conditionClearForRedFace()
    }
    func doRouterForRedFace(){
        self.nextButton.rx.tap.subscribe { (action) in
            let isHowMuchRed:UIColor = AverageColorFromImage(image: self.faceImage)
            self.yourScoreRedFace = round(isHowMuchRed.cgColor.components![0] * 100)
            AlertUtil().showResultYourFace(vc: self, message: self.yourScoreRedFace!.description)
        }
    }
    override func doRouter() {
        self.nextButton.rx.tap.subscribe { (action) in
            self.dismiss(animated: true, completion: nil)
            let vc = BeforePlayThirdPlayer()
            vc.modalPresentationStyle = .fullScreen
            self.presentingViewController!.present(vc, animated: true, completion: nil)
        }.disposed(by: dispose)
    }
    func doConfigureForRedFace(){
        self.nextButton.setTitle("チェック", for: .normal)
    }
}
