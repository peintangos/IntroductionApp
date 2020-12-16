//
//  PlayFieldViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/03.
//

import UIKit
import YogaKit
import RxSwift
import AVFoundation


class BeforePlayViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var yourName:UILabel!
    var gender:Int!
    var cameraView:UIImageView!
    var footerButtonsView:UIView!
    var retakeButton:UIButton!
    var nextButton:UIButton!
    var isPicked:Bool!
    var faceImage:UIImage!
    var yourScoreRedFace:CGFloat?
    let dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemIndigo
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isPicked = true
        let image = info[.originalImage] as! UIImage
//         "Use Photo"を使用した際に画像をフォトライブラリーに保存する。あってもなくても良い。
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        if let pickedImage = info[.originalImage] as? UIImage {
            cameraView.contentMode = .scaleAspectFill
            cameraView.clipsToBounds = true
            cameraView.image = pickedImage
            faceImage = pickedImage
            if gender != nil {
                saveMember(player: Player(name:yourName.text!,image:pickedImage,gender:gender))
                
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    
    func doLayout(){
    view.configureLayout { (layout) in
        layout.isEnabled = true
        layout.width = YGValue(self.view.bounds.size.width)
        layout.height = YGValue(self.view.bounds.size.height)
        layout.flexDirection = .column
        layout.alignItems = .center
    }
        self.yourName = UILabel()
        yourName.backgroundColor = .systemIndigo
        yourName.text = "Player1"
        yourName.textAlignment = NSTextAlignment.center
        yourName.textColor = .white
        yourName.layer.borderWidth = 1
        yourName.layer.cornerRadius = 10
        yourName.layer.borderColor = UIColor.white.cgColor
        yourName.font = UIFont.systemFont(ofSize: 26)
        self.yourName.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(headerWidth)
            layout.height = YGValue(headerHeight)
            layout.marginTop = 50
        }
        self.view.addSubview(yourName)
        
        self.cameraView = UIImageView()
        cameraView.backgroundColor = .white
        self.cameraView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(contentWidth)
            layout.height = YGValue(contentHeight)
            layout.marginTop = 50
        }
        self.view.addSubview(cameraView)
        
        self.footerButtonsView = UIView()
//        footerButtonsView.backgroundColor = .systemGray5
        footerButtonsView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(footerViewWidth)
            layout.height = YGValue(footerViewHeight)
            layout.justifyContent = .spaceAround
            layout.flexDirection = .row
            layout.alignItems = .center
            layout.marginTop = 50
        }
//        Retakeボタンは要らないという判断
//        self.retakeButton = UIButton()
//        self.retakeButton.backgroundColor = .magenta
//        self.retakeButton.configureLayout { (layout) in
//            layout.isEnabled = true
//            layout.height = YGValue(footerButtonHeight)
//            layout.width = YGValue(footerButtonWidth)
//        }
//        footerButtonsView.addSubview(self.retakeButton)
        self.nextButton = UIButton()
        self.nextButton.backgroundColor = .systemIndigo
        self.nextButton.layer.borderColor = UIColor.white.cgColor
        self.nextButton.layer.borderWidth = 1
        self.nextButton.layer.cornerRadius = 10
        self.nextButton.setTitle(" 次の人へ！", for: UIControl.State.normal)
        self.nextButton.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = YGValue(footerButtonHeight)
            layout.width = YGValue(footerButtonWidth)
        }
        footerButtonsView.addSubview(self.nextButton)
        self.view.addSubview(footerButtonsView)
        view.yoga.applyLayout(preservingOrigin: true)
    }
    func doRouter(){
        self.nextButton.rx.tap.subscribe { (action) in
            let vc = BeforePlaySeoncdPlayer()
            self.present(vc, animated: true, completion: nil)
        }
    }
    func conditionClear(){
        //        本当は、AlertUtilの中に持っていきたいが、UITextFieldDelegateの処理がわからないので一旦ここに記述する。もしかすると、Delegateも引数で渡せるかもと思うけど、一回たんま
                if isPicked == nil {
                    let alert = UIAlertController(title: "名前を入力してね", message: nil, preferredStyle: UIAlertController.Style.alert)
                    alert.addTextField { (text) in
                        text.delegate = self
                    }
                    alert.addAction(UIAlertAction.init(title: "完了", style: UIAlertAction.Style.default, handler: { (action) in
                        self.yourName.text = alert.textFields![0].text! + "🍺"
                        let genderAlert = UIAlertController(title: "あなたの性別を教えてください", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
                        genderAlert.addAction(UIAlertAction.init(title: "男性", style: UIAlertAction.Style.default, handler: { (action) in
                            self.gender = 0
                            self.takePictureAlert()
                        }))
                        genderAlert.addAction(UIAlertAction.init(title: "女性", style: UIAlertAction.Style.default, handler: { (action) in
                            self.gender = 1
                            self.takePictureAlert()
                        }))
                        self.present(genderAlert, animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else {
                    print("a")
                }
    }
    func saveMember(player:Player){
        memberList.append(player)
    }
    func takePictureAlert(){
        let jidoriAlert = UIAlertController(title: "自撮りに進むよ！精一杯の変顔を準備してね", message: nil, preferredStyle: .alert)
        jidoriAlert.addAction(UIAlertAction(title: "変顔へGo!", style: .default, handler: { (UIAlertAction) in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }))
        self.present(jidoriAlert, animated: true, completion: nil)
    }
    func conditionClearForRedFace(){
           //        本当は、AlertUtilの中に持っていきたいが、UITextFieldDelegateの処理がわからないので一旦ここに記述する。もしかすると、Delegateも引数で渡せるかもと思うけど、一回たんま
                   if isPicked == nil {
                       let alert = UIAlertController(title: "名前を入力してね", message: nil, preferredStyle: UIAlertController.Style.alert)
                       alert.addTextField { (text) in
                           text.delegate = self
                       }
                       alert.addAction(UIAlertAction.init(title: "完了", style: UIAlertAction.Style.default, handler: { (action) in
                           self.yourName.text = alert.textFields![0].text! + "🍶"
                           self.takePictureAlertForRedFace()
                       }))
                       self.present(alert, animated: true, completion: nil)
                   }else {
                       print("a")
                   }
       }
    func takePictureAlertForRedFace(){
            let jidoriAlert = UIAlertController(title: "どのくらい顔が赤いかチェックするよ！画面いっぱいに写してね", message: nil, preferredStyle: .alert)
            jidoriAlert.addAction(UIAlertAction(title: "チェック！", style: .default, handler: { (UIAlertAction) in
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }))
            self.present(jidoriAlert, animated: true, completion: nil)
        }
        
    }
    var audioPlayer: AVAudioPlayer!
    extension BeforePlayViewController: AVAudioPlayerDelegate {
        func playSound(name: String) {
    //        guard let path = Bundle.main.bundlePath.ap else {
    //            print("音源ファイルが見つかりません")
    //            return
    //        }
            do {
                let path = Bundle.main.bundleURL.appendingPathComponent("nizu.mp3")
                // AVAudioPlayerのインスタンス化
                audioPlayer = try AVAudioPlayer(contentsOf: path, fileTypeHint: nil)
                // AVAudioPlayerのデリゲートをセット
                audioPlayer.delegate = self
                // 音声の再生
                print("a")
                audioPlayer.play()
            } catch {
                print("b")
            }
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
