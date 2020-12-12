//
//  AllMembersShowUpViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/05.
//

import UIKit
import YogaKit
import RxSwift

class AllMembersShowUpViewController: UIViewController {
    
    var titleLabel:UILabel!
    var contentView:UIView!
    var startButton:UIButton!
    let dispose = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = .white
        view.configureLayout { (layout) in
        layout.isEnabled = true
        layout.width = YGValue(self.view.bounds.size.width)
        layout.height = YGValue(self.view.bounds.size.height)
        layout.alignItems = .center
            layout.flexWrap = .wrap
        }
        
        titleLabel = UILabel()
        titleLabel.backgroundColor = .brown
        titleLabel.text = "今夜の参加者一覧"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginTop = 50
            layout.width = YGValue(headerWidth)
            layout.height = YGValue(headerHeight)
        }
        
        contentView = UIView()
        contentView.backgroundColor = .black
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexWrap = .wrap
            layout.flexDirection = .row
            layout.justifyContent = .center
            layout.height = YGValue(halfViewHeight)
            layout.marginTop = 50
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
            eachView.addSubview(eachViewImage)
            eachView.addSubview(nameLabel)
            contentView.addSubview(eachView)
        }
        
        startButton = UIButton()
        startButton.backgroundColor = .blue
        startButton.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginTop = 50
            layout.height = YGValue(footerButtonHeight)
            layout.width = YGValue(headerWidth)
        }
        
        view.addSubview(titleLabel)
        view.addSubview(contentView)
        view.addSubview(startButton)
        
        view.yoga.applyLayout(preservingOrigin: true)
     
        doRouter()
    }
    func doRouter(){
        self.startButton.rx.tap.subscribe { (action) in
            AlertUtil().makeTurn(vc: self, nextVc:PlayFieldFirstViewController(),text: memberList[count].getName())
//            TODO 人数で分岐する

        }.disposed(by: dispose)
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
