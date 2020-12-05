//
//  PlayFieldViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/03.
//

import UIKit

class PlayFieldViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        本当は、AlertUtilの中に持っていきたいが、UITextFieldDelegateの処理がわからないので一旦ここに記述する。もしかすると、Delegateも引数で渡せるかもと思うけど、一回たんま
        let alert = UIAlertController(title: "名前を入力してね", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (text) in
            text.delegate = self
        }
        alert.addAction(UIAlertAction.init(title: "完了", style: UIAlertAction.Style.default, handler: { (action) in
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

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        // "写真を使用"を押下した際、写真アプリに保存する
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        // UIImagePickerController カメラが閉じる
        self.dismiss(animated: true, completion: nil)
        
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
