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

var safeAreaTop:Int?
var safeAreaBottom:Int?
class ViewController: UIViewController {
    
    let dispose = DisposeBag()
    let parts = UIParts()
    var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        makeLayout()
//        imageView = UIImageView(frame: self.view.frame)
//        imageView.image = UIImage(named: "background_bar")
//        imageView.alpha = 0.7
//        imageView.contentMode = .scaleAspectFit
//        self.view.addSubview(imageView)
//        self.view.sendSubviewToBack(imageView)
//        print(self.imageView.frame)
    }
    override func viewWillLayoutSubviews() {
        safeAreaTop = Int(self.view.safeAreaInsets.top)
        safeAreaBottom = Int(self.view.safeAreaInsets.bottom)
        makeLayout()
        imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(named: "background_bar")
        imageView.alpha = 0.7
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        print(self.imageView.frame)
        
    }
    func makeLayout(){
        view.configureLayout { (layout) in
          layout.isEnabled = true
          layout.width = YGValue(self.view.bounds.size.width)
          layout.height = YGValue(self.view.bounds.size.height)
          layout.alignItems = .center
        layout.justifyContent = .center
        }
//        背景色を白にしないと、画面が真っ黒になってしまう。
//        view.backgroundColor = .white
        
        let contentView = parts.makeContetnView(vc:self)
        let leftContentView = parts.makeTopFieldLeftButton()
        let rightContentView = parts.makeTopFieldRightButton()
        let title = parts.makeTitle(vc: self)
        
        contentView.addSubview(leftContentView)
        contentView.addSubview(rightContentView)
        view.addSubview(title)
        view.addSubview(contentView)
        
//        練習用に作る後で消す
        let tempo = parts.button(vc: self)
        contentView.addSubview(tempo)
        tempo.rx.tap.subscribe { (action) in
            let am = AllMembersShowUpViewController()
            am.modalPresentationStyle = .pageSheet
            self.present(am, animated: true, completion: nil)
        }
        
        view.yoga.applyLayout(preservingOrigin: true)

//        Rxを用いて、タップ時の画面遷移を整理
        do{
            rightContentView.rx.tap.subscribe { (action) in
                AlertUtil().makeAlert(vc: self)
            }.disposed(by: dispose)
            
            leftContentView.rx.tap.subscribe { (action) in
                let fv = FaceRedFieldViewController()
                self.present(fv, animated: true, completion: nil)
            }.disposed(by: dispose)
        }
    
    }

}

