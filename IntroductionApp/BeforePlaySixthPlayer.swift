//
//  BeforePlaySixthPlayer.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/13.
//

import Foundation
import RxSwift
class BeforePlaySixthPlayer:BeforePlayViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .blue
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
            if playerNumbers! == 6 {
                vc = AllMembersShowUpViewController()
                vc.modalPresentationStyle = .fullScreen
            }else {
                vc = BeforePlaySeventhPlayer()
            }
            self.presentingViewController!.present(vc, animated: true, completion: nil)
        }.disposed(by: dispose)
    }
}
