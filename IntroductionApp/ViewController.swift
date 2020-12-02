//
//  ViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/02.
//

import UIKit
import YogaKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let dispose = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeLayout()
    }
    func makeLayout(){
        view.configureLayout { (layout) in
          layout.isEnabled = true
          layout.width = YGValue(self.view.bounds.size.width)
          layout.height = YGValue(self.view.bounds.size.height)
          layout.alignItems = .center
        layout.justifyContent = .center
        }
        view.backgroundColor = .white
        
        let contentView = UIView()
        contentView.backgroundColor = .red
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 100
            layout.height = 100
            layout.flexDirection = .row
            layout.justifyContent = .center
            layout.alignItems = .center
        }
        let leftContentview = UIButton()
        leftContentview.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 30
            layout.height = 30
        }
        leftContentview.backgroundColor = .black
        let rightContentview = UIButton()
        rightContentview.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 30
            layout.height = 30
        }
        rightContentview.backgroundColor = .blue
        contentView.addSubview(leftContentview)
        contentView.addSubview(rightContentview)
        view.addSubview(contentView)
        view.yoga.applyLayout(preservingOrigin: true)
        
        rightContentview.rx.tap.subscribe { (action) in
            print("aaa")
        }.disposed(by: dispose)
        
        leftContentview.rx.tap.subscribe { (action) in
            print("bbb")
        }
    }
}

