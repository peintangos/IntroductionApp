//
//  BaseViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/03.
//

/**
 土台のコントローラ（プレイヤー用の画面は別。）
 */
import UIKit
import RxSwift
import YogaKit

class BaseViewController: UIViewController {
    
    var titleLabel:UILabel!
    var contentView:UIView!
    var contentLabelTitle:UILabel!
    var contentLabel:UILabel!
    var answerButton:UIButton!
    let dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    func doLayout(){
        view.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(self.view.bounds.size.width)
            layout.height = YGValue(self.view.bounds.size.height)
            layout.flexDirection = .column
            layout.alignItems = .center
        }
        titleLabel = UILabel()
        titleLabel.backgroundColor = .blue
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(headerWidth)
            layout.height = YGValue(headerHeight)
            layout.marginTop = 50
        }
        view.addSubview(titleLabel)
        contentView = UIView()
        contentView.backgroundColor = .orange
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(contentWidth)
            layout.height = YGValue(contentHeight)
            layout.marginTop = 50
        }
        view.addSubview(contentView)
        
        contentLabelTitle = UILabel()
        contentLabelTitle.backgroundColor = .systemPink
        contentLabelTitle.textColor = .white
        contentLabelTitle.font = UIFont.systemFont(ofSize: 26)
        contentLabelTitle.textAlignment = .center
        contentLabelTitle.numberOfLines = 0
        contentLabelTitle.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = YGValue(headerHeight)
        }
        contentView.addSubview(contentLabelTitle)
        
        contentLabel = UILabel()
        contentLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexGrow = 1
        }
        contentLabel.numberOfLines = 0
        contentLabel.backgroundColor = .darkGray
        contentLabel.textColor = .white
        contentLabel.font = UIFont.systemFont(ofSize: 26)
        contentLabel.textAlignment = .center
        
        contentView.addSubview(contentLabel)
        
        answerButton = UIButton()
        answerButton.backgroundColor = .black
        answerButton.configureLayout { (layout) in
            layout.marginTop = 50
            layout.isEnabled = true
            layout.height = YGValue(footerButtonHeight)
            layout.width = YGValue(headerWidth)
        }
        view.addSubview(answerButton)
        
        view.yoga.applyLayout(preservingOrigin: true)
        doRouter()
    }
    func doRouter(){
//        self.answerButton.rx.tap.subscribe { (action) in
//            self.dismiss(animated: true, completion: nil)
//            let vc = BaseViewController()
//            self.presentingViewController!.present(vc, animated: true, completion: nil)
//        }.disposed(by: dispose)
    }
    func makeQuestionTitle(text:String){
        contentLabelTitle.text = text
    }
    func makeQuestionContent(text:String){
        contentLabel.text = text
    }
    func maketTitle(text:String){
        titleLabel.text = text
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
