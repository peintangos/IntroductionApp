//
//  UIParts.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/05.
//

import UIKit
import YogaKit

/**
 
 */
class UIParts: NSObject {
//    大きな問題が起きている。
//    画像を設定すると、おそらくViewの大きさが狂う。（画像の大きさに引っ張られる。）
    func makeTopFieldLeftButton()->UIButton{
        let topButton = UIButton()
        topButton.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 100
            layout.height = 100
        }
        topButton.layer.shadowColor = UIColor.black.cgColor
        topButton.layer.shadowOpacity = 2
        topButton.layer.shadowOffset = .zero
        topButton.layer.shadowRadius = 10
        topButton.layer.borderColor = UIColor.white.cgColor
        topButton.layer.borderWidth = 1
        topButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        topButton.setTitle("Alcohol\nCheck\nGame", for: .normal)
        topButton.titleLabel?.numberOfLines = 0
        topButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        topButton.layer.cornerRadius = 10
        topButton.titleLabel?.textAlignment = .center
        return topButton
    }
    func makeTopFieldRightButton()->UIButton{
        let topButton = UIButton()
        topButton.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 100
            layout.height = 100
        }
        topButton.layer.borderColor = UIColor.white.cgColor
        topButton.layer.borderWidth = 1
        topButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        topButton.setTitle("First\nImpression\nGame", for: .normal)
        topButton.titleLabel?.numberOfLines = 0
        topButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        topButton.layer.cornerRadius = 10
        topButton.titleLabel?.textAlignment = .center
        return topButton
    }
    func makeContetnView(vc:UIViewController) -> UIView{
        let contentView = UIView()
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(vc.view.bounds.size.width)
//            layout.height = YGValue(vc.view.bounds.size.height)
            layout.flexDirection = .row
            layout.justifyContent = .spaceAround
            layout.alignItems = .center
            layout.marginBottom = YGValue(integerLiteral: safeAreaBottom!)
        }
        return contentView
    }
    func makeTitleView(vc:UIViewController) -> UIView{
        let titleView = UIView()
        titleView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(vc.view.bounds.size.width)
            layout.height = YGValue(vc.view.bounds.size.height / 2)
            layout.alignItems = .center
        }
        return titleView
    }
    func makeTitle(vc:UIViewController) -> UILabel{
        let titleLabel = UILabel()
        titleLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(vc.view.bounds.size.width / 1.5)
            layout.height = YGValue(vc.view.bounds.size.width / 3)
            layout.marginTop = 150
        }
        titleLabel.text = "Introduction Game"
        titleLabel.textColor = .white
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.layer.borderColor = UIColor.white.cgColor
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.cornerRadius = 10
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        return titleLabel
    }
    func makeHeaderView(vc:UIViewController) -> UIView{
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(vc.view.bounds.size.width)
            layout.height = 50
            layout.flexDirection = .row
            layout.justifyContent = .flexStart
            layout.marginTop = YGValue(integerLiteral: safeAreaTop!)
        }
        return headerView
    }
    func makeMenuButton() ->UIButton{
        let menuButton = UIButton()
        menuButton.backgroundColor = .systemRed
        menuButton.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = 50
            layout.width = 50
        }
        return menuButton
    }
    func button(vc:UIViewController) -> UIButton{
        let button = UIButton()
        button.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 100
            layout.height = 100
            layout.justifyContent = .center
        }
        button.backgroundColor = .red
        return button
    }
    func example(vc:UIViewController) ->UIView{
        let view = UIView()
        view.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(vc.view.bounds.size.width)
            layout.height = 80
//            layout.marginLeft = 10
//            layout.marginTop = 10
            layout.flexWrap = .wrap
            layout.marginBottom = 10
        }
        view.backgroundColor = UIColor.orange
        return view
    }
    func exampleTitle(vc:UIViewController) ->UIView{
        let view = UIView()
        view.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(vc.view.bounds.size.width)
            layout.height = 100
//            layout.marginLeft = 10
//            layout.marginTop = 10
            layout.marginBottom = 50
        }
        view.backgroundColor = UIColor.orange
        return view
    }
    func example2(vc:UIViewController) ->UIView{
        let view = UIView()
        view.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 200
            layout.height = 200
            layout.marginLeft = 10
            layout.marginTop = 10
        }
        view.backgroundColor = UIColor.brown
        return view
    }
    
}
