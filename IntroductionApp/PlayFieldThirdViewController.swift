//
//  PlayFieldThirdViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/12.
//

import Foundation
import RxSwift
class PlayFieldThirdViewController:BaseViewController{
    let d = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doLayout()
        doRouter()
        makeQuestionTitle(text:Strings.qustion3)
        makeQuestionContent(text:Strings.content3)
        maketTitle(text: memberList[count].getName())
        self.answerButton.addTarget(self, action: #selector(modal), for: .touchUpInside)
    }

    @objc func modal(){
        AlertUtil().makeAnswer(vc: self,nextVc: PlayFieldFourthViewController())
    }
}
