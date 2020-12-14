//
//  PlayFieldFirstViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/12.
//

import Foundation
import RxSwift
class PlayFieldFirstViewController :BaseViewController{
    let d = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.view.backgroundColor = .systemPink
        doLayout()
        doRouter()
        makeQuestionTitle(text:Strings.qustion1 + Strings.contentGaijin)
        maketTitle(text: memberList[count].getName())
        self.answerButton.addTarget(self, action: #selector(modal), for: .touchUpInside)
    }

    @objc func modal(){
        AlertUtil().makeAnswer(vc: self,nextVc: PlayFieldSecondViewController(),databaseDriver: DatabaseDriver(),player: memberList[count])
    }
}
