//
//  PlayFieldViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/03.
//

import UIKit
import YogaKit
import RxSwift

class BeforePlayViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var yourName:UILabel!
    var cameraView:UIImageView!
    var footerButtonsView:UIView!
    var retakeButton:UIButton!
    var nextButton:UIButton!
    var isPicked:Bool!
    let dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isPicked = true
        let image = info[.originalImage] as! UIImage
//         "Use Photo"を使用した際に画像をフォトライブラリーに保存する。あってもなくても良い。
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        if let pickedImage = info[.originalImage] as? UIImage {
            cameraView.contentMode = .scaleAspectFit
            cameraView.image = pickedImage
            saveMember(player: Player(name:yourName.text!,image:pickedImage))
        }
        picker.dismiss(animated: true, completion: nil)
    }

    
    func doLayout(){
//        let headerWidth = self.view.bounds.size.width / 1.5
//        let headerHeight = self.view.bounds.size.width / 4
//        let contentWidth = self.view.bounds.size.width / 1.2
//        let contentHeight = self.view.bounds.size.width / 1.2
//        let footerViewWidth = self.view.bounds.size.width
//        let footerViewHeight = self.view.bounds.size.height / 5
//        let footerButtonWidth = self.view.bounds.size.width / 4
//        let footerButtonHeight = self.view.bounds.size.width / 4
    view.configureLayout { (layout) in
        layout.isEnabled = true
        layout.width = YGValue(self.view.bounds.size.width)
        layout.height = YGValue(self.view.bounds.size.height)
        layout.flexDirection = .column
        layout.alignItems = .center
    }
        self.yourName = UILabel()
        yourName.backgroundColor = .orange
        yourName.text = "Player1"
        yourName.textAlignment = NSTextAlignment.center
        yourName.textColor = .white
        yourName.font = UIFont.systemFont(ofSize: 16)
        self.yourName.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(headerWidth)
            layout.height = YGValue(headerHeight)
            layout.marginTop = 10
        }
        self.view.addSubview(yourName)
        
        self.cameraView = UIImageView()
        cameraView.backgroundColor = .green
        self.cameraView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(contentWidth)
            layout.height = YGValue(contentHeight)
            layout.margin = 30
        }
        self.view.addSubview(cameraView)
        
        self.footerButtonsView = UIView()
        footerButtonsView.backgroundColor = .brown
        footerButtonsView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(footerViewWidth)
            layout.height = YGValue(footerViewHeight)
            layout.justifyContent = .spaceAround
            layout.flexDirection = .row
            layout.alignItems = .center
        }
        self.retakeButton = UIButton()
        self.retakeButton.backgroundColor = .magenta
        self.retakeButton.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = YGValue(footerButtonHeight)
            layout.width = YGValue(footerButtonWidth)
        }
        footerButtonsView.addSubview(self.retakeButton)
        self.nextButton = UIButton()
        self.nextButton.backgroundColor = .purple
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
                        self.yourName.text = alert.textFields![0].text
                        let jidoriAlert = UIAlertController(title: "自撮りに進むよ！盛れるように準備してね", message: nil, preferredStyle: .alert)
                        jidoriAlert.addAction(UIAlertAction(title: "自撮りに進む", style: .default, handler: { (UIAlertAction) in
                            let picker = UIImagePickerController()
                            picker.sourceType = .camera
                            picker.delegate = self
                            self.present(picker, animated: true, completion: nil)
                        }))
                        self.present(jidoriAlert, animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else {
                    print("a")
                }
    }
    func saveMember(player:Player){
        memberList.append(player)
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
