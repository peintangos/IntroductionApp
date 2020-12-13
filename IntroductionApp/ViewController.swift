//
//  ViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/02.
//

import UIKit
import YogaKit
import RxSwift
import RealmSwift
import RxCocoa

var safeAreaTop:Int?
var safeAreaBottom:Int?
var memberList:Array<Player>!
var headerWidth:CGFloat!
var headerHeight:CGFloat!
var contentWidth:CGFloat!
var contentHeight:CGFloat!
var footerViewWidth:CGFloat!
var footerViewHeight:CGFloat!
var footerButtonWidth:CGFloat!
var footerButtonHeight:CGFloat!
var eachPlayerTileWidth:CGFloat!
var eachPlayerTileHeight:CGFloat!
var halfViewWidth:CGFloat!
var halfViewHeight:CGFloat!
var playerNumbers:Int?
var questionNumberTotal = 4
//プレイヤーのターンを数える
var count = 0
//各プレイヤーの質問目数をカウントする
var questionNumber = 0
var questionNumberReal = 0
var gameNumber = 0
class ViewController: UIViewController {
    
    let dispose = DisposeBag()
    let parts = UIParts()
//    var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        memberList = Array()
        gameNumber = Int.random(in: 1..<1000000)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        headerWidth = self.view.bounds.size.width / 1.5
        headerHeight = self.view.bounds.size.width / 4
        contentWidth = self.view.bounds.size.width / 1.2
        contentHeight = self.view.bounds.size.width / 1.2
        footerViewWidth = self.view.bounds.size.width
        footerViewHeight = self.view.bounds.size.height / 5
        footerButtonWidth = self.view.bounds.size.width / 4
        footerButtonHeight = self.view.bounds.size.width / 4
        eachPlayerTileWidth = self.view.bounds.size.width / 2.5
        eachPlayerTileHeight = self.view.bounds.size.width / 2.5
        halfViewWidth = self.view.bounds.width / 2
        halfViewHeight = self.view.bounds.height / 2
    }
    override func viewWillLayoutSubviews() {
        safeAreaTop = Int(self.view.safeAreaInsets.top)
        safeAreaBottom = Int(self.view.safeAreaInsets.bottom)
        makeLayout()
//        なぜか、こいつがあるせいでサスペンドしたときに落ちるので画像は生成ないことにする
//        imageView = UIImageView(frame: self.view.frame)
//        imageView.image = UIImage(named: "background_bar")
//        imageView.alpha = 0.7
//        imageView.contentMode = .scaleAspectFit
//        self.view.addSubview(imageView)
//        self.view.sendSubviewToBack(imageView)
        
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
            let am = ResultsViewController()
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

