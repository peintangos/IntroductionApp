//
//  PlayFieldFourthViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/12.
//

import Foundation
import RxSwift
class PlayFieldFourthViewController :BaseViewController{
    let d = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.view.backgroundColor = .systemPink
        doLayout()
        doRouter()
        makeQuestionTitle(text:Strings.qustion4 + Strings.contentPlay)
//        makeQuestionContent(text:Strings.contentPlay)
        maketTitle(text: memberList[count].getName())
        self.answerButton.addTarget(self, action: #selector(modal), for: .touchUpInside)
    }
    @objc func modal(){
        AlertUtil().makeLastAnswer(vc: self,databaseDriver: DatabaseDriver(),player: memberList[count])
    
    }
}
