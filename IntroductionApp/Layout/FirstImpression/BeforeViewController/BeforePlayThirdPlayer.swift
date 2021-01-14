//
//  BeforePlayThirdPlayer.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/12.
//

import Foundation
import RxSwift
class BeforePlayThirdPlayer:BeforePlayViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .red
        // Do any additional setup after loading the view.
        doLayout()
        doRouter()
    }
    override func viewWillAppear(_ animated: Bool) {
        conditionClear()
    }
    override func doRouter() {
        self.nextButton.rx.tap.subscribe { (action) in
            self.dismiss(animated: true, completion: nil)
            var vc:UIViewController!
            if playerNumbers == 3 {
                vc = AllMembersShowUpViewController()
            }else {
                vc = BeforePlayFourthPlayer()
            }
            vc.modalPresentationStyle = .fullScreen
            self.presentingViewController!.present(vc, animated: true, completion: nil)
        }.disposed(by: dispose)
}
}
