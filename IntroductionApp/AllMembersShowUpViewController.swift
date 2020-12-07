//
//  AllMembersShowUpViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/05.
//

import UIKit
import YogaKit

class AllMembersShowUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        view.configureLayout { (layout) in
        layout.isEnabled = true
        layout.width = YGValue(self.view.bounds.size.width)
        layout.height = YGValue(self.view.bounds.size.height)
        }
        let first1 = parts.exampleTitle(vc:self)
        let first2 = parts.example(vc: self)
        let first3 = parts.example(vc: self)
        
        let second1 = parts.example2(vc: self)
        let second2 = parts.example2(vc: self)
        let second3 = parts.example2(vc: self)
        let second4 = parts.example2(vc: self)
        let second5 = parts.example2(vc: self)
        let second6 = parts.example2(vc: self)
        
        first2.addSubview(second1)
        first2.addSubview(second2)
        first2.addSubview(second3)
        first2.addSubview(second4)
        first2.addSubview(second5)
        first2.addSubview(second6)
        
        view.addSubview(first1)
        view.addSubview(first2)
        view.addSubview(first3)
        
        view.yoga.applyLayout(preservingOrigin: true)
        
    }
    let parts = UIParts()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
