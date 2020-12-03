//
//  PlayFieldViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/03.
//

import UIKit

class PlayFieldViewController: UIViewController,UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "名前を入力してね", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (text) in
            text.delegate = self
        }
        alert.addAction(UIAlertAction.init(title: "完了", style: UIAlertAction.Style.default, handler: { (action) in
            print("きてる")
        }))
        self.present(alert, animated: true, completion: nil)
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
