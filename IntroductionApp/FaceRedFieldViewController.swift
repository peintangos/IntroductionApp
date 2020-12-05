//
//  FaceRedFieldViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/05.
//

import UIKit
import RxSwift
import ChameleonFramework

class FaceRedFieldViewController: UIViewController {

    var backButton:UIButton!
    let dispose = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        backButton = UIButton()
        backButton.layer.cornerRadius = 50
        backButton.backgroundColor = .red
        self.view.addSubview(backButton)
        backButton.rx.tap.subscribe { (action) in
            self.dismiss(animated: true, completion: nil)
//            AverageColorFromImageの戻り値はUIDeviceRGBColorである。UIColorとして宣言できたのでこれをRGBに変換し、Redの要素を取り出す。
            let isHowMuchRed:UIColor = AverageColorFromImage(image: UIImage(named: "example")!)
            let a = isHowMuchRed.cgColor.components!
            print(a[0])
            let isHowMuchRed2:UIColor = AverageColorFromImage(image: UIImage(named: "redTell")!)
            let b = isHowMuchRed2.cgColor.components!
            print(b[0])
        }.disposed(by: dispose)
    }
    override func viewDidLayoutSubviews() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        backButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
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
