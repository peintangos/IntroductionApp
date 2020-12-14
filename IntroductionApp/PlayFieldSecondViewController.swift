//
//  PlayFieldSecondViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/12.
//

import Foundation

class PlayFieldSecondViewController:BaseViewController{
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.view.backgroundColor = .systemPink
        doLayout()
        doRouter()
        makeQuestionTitle(text:Strings.qustion2 + Strings.contentAlcohol)
//        makeQuestionContent(text:Strings.contentAlcohol)
        maketTitle(text: memberList[count].getName())
        self.answerButton.addTarget(self, action: #selector(modal), for: .touchUpInside)
    }

    @objc func modal(){
        let vc = PlayFieldThirdViewController()
        vc.modalPresentationStyle = .fullScreen
        AlertUtil().makeAnswer(vc: self,nextVc: vc,databaseDriver: DatabaseDriver(),player: memberList[count])
    }
}
