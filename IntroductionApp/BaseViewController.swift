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
import AVFoundation
import YogaKit

class BaseViewController: UIViewController {
    
    var titleLabel:UILabel!
    var contentView:UIView!
    var contentLabelTitle:UILabel!
    var contentLabel:UIScrollView!
    var answerButton:UIButton!
    let dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemIndigo
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
        titleLabel.backgroundColor = .systemIndigo
        titleLabel.textColor = .white
        titleLabel.layer.borderColor = UIColor.white.cgColor
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.cornerRadius = 10
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
        contentLabelTitle.backgroundColor = .white
        contentLabelTitle.textColor = .systemGreen
        contentLabelTitle.font = UIFont.systemFont(ofSize: 26)
        contentLabelTitle.textAlignment = .center
        contentLabelTitle.numberOfLines = 0
        contentLabelTitle.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = YGValue(headerHeight)
        }
        contentView.addSubview(contentLabelTitle)
        
//        contentLabel = UILabel()
        contentLabel = UIScrollView()
        contentLabel.contentSize =  CGSize(width:contentWidth, height:eachPlayerTileHeight * 5)
        contentLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexWrap = .wrap
            layout.flexDirection = .row
            layout.justifyContent = .center
            layout.height = YGValue(halfViewHeight - 100)
            layout.alignItems = .center
        }
        memberList.forEach { (player) in
            let eachView = UIView()
            eachView.configureLayout { (layout) in
                layout.isEnabled = true
                layout.flexShrink = 1
            }
            let nameLabel = UILabel()
            nameLabel.textAlignment = .center
            nameLabel.text = player.getName()
            nameLabel.textColor = .black
            nameLabel.configureLayout { (layout) in
                layout.isEnabled = true
            }
            let eachViewImage = UIImageView()
            eachViewImage.configureLayout { (layout) in
                layout.isEnabled = true
                layout.width = YGValue(eachPlayerTileWidth)
                layout.height = YGValue(eachPlayerTileHeight)
                layout.marginTop = 10
            }
            eachViewImage.image = player.getImage()
            eachViewImage.contentMode = .scaleAspectFit
            eachViewImage.clipsToBounds = false
            eachView.addSubview(eachViewImage)
            eachView.addSubview(nameLabel)
            contentLabel.addSubview(eachView)
        }
        contentLabel.backgroundColor = .white
        contentView.addSubview(contentLabel)
        
        answerButton = UIButton()
        answerButton.backgroundColor = .systemIndigo
        answerButton.layer.cornerRadius = 10
        answerButton.layer.borderColor = UIColor.white.cgColor
        answerButton.layer.borderWidth = 1
        answerButton.setTitle("選ぶ！🍻", for: UIControl.State.normal)
        answerButton.layer.shadowOpacity = 1
        answerButton.layer.shadowOffset = .zero
        answerButton.configureLayout { (layout) in
//            このマージントップ100は無理やりすぎる。なぜか、画像に重なってしまう。
            layout.marginTop = 200
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
//    func makeQuestionContent(text:String){
//        contentLabel.text = text
//    }
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

