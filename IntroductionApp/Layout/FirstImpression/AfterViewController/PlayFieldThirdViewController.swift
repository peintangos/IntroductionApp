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
//        self.view.backgroundColor = .systemPink
        doLayout()
        doRouter()
        makeQuestionTitle(text:Strings.qustion3 + Strings.contentType)
//        makeQuestionContent(text:Strings.contentType)
        
        maketTitle(text: memberList[count].getName())
        self.answerButton.addTarget(self, action: #selector(modal), for: .touchUpInside)
    }

    @objc func modal(){
        let vc = PlayFieldFourthViewController()
        vc.modalPresentationStyle = .fullScreen
        AlertUtil().makeAnswerOtherGender(vc: self,nextVc: vc,databaseDriver: DatabaseDriver(),player:memberList[count])
    }
}
