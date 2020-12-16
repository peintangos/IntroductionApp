//
//  AllMembersShowUpViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/05.
//

import UIKit
import YogaKit
import RxSwift
import AVFoundation

var parentView:UIViewController!
class AllMembersShowUpViewController: UIViewController {
    
    var titleLabel:UILabel!
    var contentView:UIScrollView!
    var startButton:UIButton!
    let dispose = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.playSound()
        parentView = self
        self.view.backgroundColor = .systemIndigo
        view.configureLayout { (layout) in
        layout.isEnabled = true
        layout.width = YGValue(self.view.bounds.size.width)
        layout.height = YGValue(self.view.bounds.size.height)
        layout.alignItems = .center
            layout.flexWrap = .wrap
        }
        
        titleLabel = UILabel()
        titleLabel.backgroundColor = .systemIndigo
        titleLabel.layer.borderColor = UIColor.white.cgColor
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.cornerRadius = 10
        titleLabel.textColor = .white
        titleLabel.text = "今夜の参加者一覧"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginTop = 50
            layout.width = YGValue(headerWidth)
            layout.height = YGValue(headerHeight)
        }

        contentView = UIScrollView()
        contentView.contentSize =  CGSize(width:self.view.frame.width, height:eachPlayerTileHeight * 5) 
        contentView.backgroundColor = .white
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
            nameLabel.textColor = .systemIndigo
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
        startButton.backgroundColor = .systemIndigo
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.borderWidth = 1
        startButton.layer.cornerRadius = 10
        startButton.setTitle("第一印象ゲームを始める🍻", for: UIControl.State.normal)
        startButton.setTitleColor(.white, for: .normal)
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
var audioPlayerForAll: AVAudioPlayer!
extension AllMembersShowUpViewController: AVAudioPlayerDelegate {
    func playSound() {
        do {
            let path = Bundle.main.bundleURL.appendingPathComponent("nizu.mp3")
            // AVAudioPlayerのインスタンス化
            audioPlayerForAll = try AVAudioPlayer(contentsOf: path, fileTypeHint: nil)
            // AVAudioPlayerのデリゲートをセット
            audioPlayerForAll.delegate = self
            // 音声の再生
            print("a")
            audioPlayerForAll.play()
        } catch {
            print("b")
        }
    }
}
