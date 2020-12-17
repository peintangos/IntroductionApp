//
//  ResultsViewController.swift
//  IntroductionApp
//
//  Created by 松尾淳平 on 2020/12/12.
//

import UIKit
import YogaKit
import RealmSwift
class ResultsViewController: UIViewController {

    var scrollView:UIScrollView!
    var contentAlcohol:UIView!
    var contentAlcoholTitle:UILabel!
    var contentAlcoholMain:UIView!
    var contentGaijin:UIView!
    var contentGaijinTitle:UILabel!
    var contentGaijinMain:UIView!
    var contentType:UIView!
    var contentPlay:UIView!
    var contentPlayTitle:UILabel!
    var contentPlayMain:UIView!
    var contentTypeTitle:UILabel!
    var contentTypeMain:UIView!
    var endButton:UIButton!
    
//    データベースから持ってきた配列
    var impressionResults:Results<ImpressionResult>!
    var impressionResultsGaijinRanking:Results<ImpressionResult>!
    var impressionResultsAlcoholRanking:Results<ImpressionResult>!
    var impressionResultsPlayRanking:Results<ImpressionResult>!
    var impressionResultsTypeRanking:Results<ImpressionResult>!
    
//    表示用に作成した配列
    var displayGaijinRanking = Array<ResultDisplay>()
    var displayAlcoholRanking = Array<ResultDisplay>()
    var displayPlayRanking = Array<ResultDisplay>()
    var displayTypeRanking = Array<ResultDisplay>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        impressionResults = realm.objects(ImpressionResult.self).filter("gameNumber == %@", gameNumber)
        impressionResultsGaijinRanking = impressionResults.filter("questionId == %@", 0).sorted(byKeyPath: "playerId")
        impressionResultsAlcoholRanking = impressionResults.filter("questionId == %@", 1).sorted(byKeyPath: "playerId")
        impressionResultsPlayRanking = impressionResults.filter("questionId == %@", 2).sorted(byKeyPath: "playerId")
        impressionResultsTypeRanking = impressionResults.filter("questionId == %@", 3).sorted(byKeyPath: "playerId")
        
        print(impressionResults)
        print(impressionResultsGaijinRanking)
        print(impressionResultsAlcoholRanking)
        print(impressionResultsTypeRanking)
        
        
        self.makeScrhollView()
        self.makeContentGaijinArea()
        self.makeContentAlcoholArea()
        self.makeContentPlayArea()
        self.makeContentTypeArea()
        self.makeEndButton()
//        スクロールビューの高さを決定するために子要素の高さを合計する必要があるため、ここだけ抜き出す。
        self.makeScrhollViewConfigure()
        
        scrollView.yoga.applyLayout(preservingOrigin: true)
        self.endButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
    }
    func makeScrhollView(){
        
        // Do any additional setup after loading the view.
        scrollView = UIScrollView()
        //scrollViewの大きさを設定。
        scrollView.frame = self.view.frame
        //スクロール領域の設定
//        scrollView.contentSize = CGSize(width:self.view.frame.width, height:contentGaijin.frame.height + contentAlcohol.frame.height + contentPlay.frame.height + contentType.frame.height)
        //scrollViewをviewのSubViewとして追加
        self.view.addSubview(scrollView)
        
        scrollView.backgroundColor = .systemRed
        scrollView.configureLayout { (layout) in
        layout.isEnabled = true
        layout.width = YGValue(self.view.bounds.size.width)
        layout.height = YGValue(self.view.bounds.size.height)
        }
       
    }
    func makeScrhollViewConfigure(){
        //スクロール領域を再設定する
        scrollView.contentSize = CGSize(width:self.view.frame.width, height:4000 + footerButtonHeight)

    }
    override func viewDidLayoutSubviews() {
        makeScrhollViewConfigure()
    }
    func makeContentGaijinArea(){
        contentGaijin = UIView()
        contentGaijin.backgroundColor = .systemGray
        contentGaijin.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = 1000
            layout.flexWrap = .wrap
            layout.flexDirection = .row
        }
        
        contentGaijinTitle = UILabel()
        contentGaijinTitle.text = Strings.rankingGaijinTitle
        contentGaijinTitle.textAlignment = .center
        contentGaijinTitle.font = UIFont.systemFont(ofSize: 26)
        contentGaijinTitle.tintColor = .white
        contentGaijinTitle.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginTop = 50
            layout.justifyContent = .center
        }
        contentGaijinMain = UIView()
        contentGaijinMain.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexWrap = .wrap
            layout.flexDirection = .column
            layout.alignItems = .center
        }

        var index = 0
        impressionResultsGaijinRanking.forEach { (element) in
            let sum = impressionResultsGaijinRanking.filter("answerId== %@", index).count
            displayGaijinRanking.append(ResultDisplay.init(player: memberList[index], countId: index, questionNumber: element.questionId, answer: element.answerId, demandedSum: sum))
            index += 1
        }
        displayGaijinRanking.sort { (before, after) -> Bool in
            before.getDemandedSum() > after.getDemandedSum()
        }
        makeDisplay(list: displayGaijinRanking, parentViewMain: contentGaijinMain)
        contentGaijin.addSubview(contentGaijinTitle)
        contentGaijin.addSubview(contentGaijinMain)
        
        scrollView.addSubview(contentGaijin)
    }

    func makeContentAlcoholArea(){
        
        contentAlcohol = UIView()
        contentAlcohol.backgroundColor = .systemPink
        contentAlcohol.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = 1000
        }
        
        contentAlcoholTitle = UILabel()
        contentAlcoholTitle.text = Strings.rankingAlcoholTitle
        contentAlcoholTitle.font = UIFont.systemFont(ofSize: 26)
        contentAlcoholTitle.textAlignment = .center
        contentGaijinTitle.textColor = .white
        contentAlcoholTitle.configureLayout { (layout) in
            layout.isEnabled = true
            layout.justifyContent = .center
        }
        contentAlcoholMain = UIView()
        contentAlcoholMain.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexWrap = .wrap
            layout.justifyContent = .center
        }
        var index = 0
        impressionResultsAlcoholRanking.forEach { (element) in
            let sum = impressionResultsAlcoholRanking.filter("answerId== %@", index).count
            displayAlcoholRanking.append(ResultDisplay.init(player: memberList[index], countId: index, questionNumber: element.questionId, answer: element.answerId, demandedSum: sum))
            index += 1
        }
        displayAlcoholRanking.sort { (before, after) -> Bool in
            before.getDemandedSum() > after.getDemandedSum()
        }
        makeDisplay(list: displayAlcoholRanking, parentViewMain: contentAlcoholMain)
        contentAlcohol.addSubview(contentAlcoholTitle)
        contentAlcohol.addSubview(contentAlcoholMain)
        scrollView.addSubview(contentAlcohol)
    }
    func makeContentPlayArea(){
        contentPlay = UIView()
        contentPlay.backgroundColor = .systemBlue
        contentPlay.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = 1000
        }
        contentPlayTitle = UILabel()
        contentPlayTitle.text = Strings.rankingPlayTitle
        contentPlayTitle.textAlignment = .center
        contentPlayTitle.font = UIFont.systemFont(ofSize: 26)
        contentPlayTitle.tintColor = .white
        contentPlayTitle.configureLayout { (layout) in
            layout.isEnabled = true
            layout.justifyContent = .center
        }
        contentPlayMain = UIView()
        contentPlayMain.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexWrap = .wrap
            layout.justifyContent = .center
        }
        var index = 0
        impressionResultsPlayRanking.forEach { (element) in
            let sum = impressionResultsPlayRanking.filter("answerId== %@", index).count
            displayPlayRanking.append(ResultDisplay.init(player: memberList[index], countId: index, questionNumber: element.questionId, answer: element.answerId, demandedSum: sum))
            index += 1
        }
        displayPlayRanking.sort { (before, after) -> Bool in
            before.getDemandedSum() > after.getDemandedSum()
        }
        makeDisplay(list: displayPlayRanking, parentViewMain: contentPlayMain)
        contentPlay.addSubview(contentPlayTitle)
        contentPlay.addSubview(contentPlayMain)
        scrollView.addSubview(contentPlay)
    }
    func makeContentTypeArea(){
        contentType = UIView()
        contentType
            .backgroundColor = .systemOrange
        contentType.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = 1000
        }
        contentTypeTitle = UILabel()
        contentTypeTitle.text = Strings.rankingPlayTitle
        contentTypeTitle.textAlignment = .center
        contentTypeTitle.font = UIFont.systemFont(ofSize: 26)
        contentTypeTitle.tintColor = .white
        contentTypeTitle.configureLayout { (layout) in
            layout.isEnabled = true
            layout.justifyContent = .center
        }
        contentTypeMain = UIView()
        contentTypeMain.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexWrap = .wrap
            layout.justifyContent = .center
        }
        var index = 0
        impressionResultsTypeRanking.forEach { (element) in
            let sum = impressionResultsTypeRanking.filter("answerId== %@", index).count
            displayTypeRanking.append(ResultDisplay.init(player: memberList[index], countId: index, questionNumber: element.questionId, answer: element.answerId, demandedSum: sum))
            index += 1
        }
        
        displayTypeRanking.sort { (before, after) -> Bool in
            before.getDemandedSum() > after.getDemandedSum()
        }
        makeDisplay(list: displayTypeRanking, parentViewMain: contentTypeMain)
        contentType.addSubview(contentTypeTitle)
        contentType.addSubview(contentTypeMain)
        scrollView.addSubview(contentType)
    }
    func makeDisplay(list:Array<ResultDisplay>,parentViewMain:UIView){
        var index = 1
        list.forEach { (resultDisplay) in
            var contentEachView = UIView()
//            contentEachView.backgroundColor = .red
            contentEachView.configureLayout { (layout) in
                layout.isEnabled = true
                layout.flexDirection = .column
            }
            let name = UILabel()
            name.configureLayout { (layout) in
                layout.isEnabled = true
            }
            name.text =  "\(index)位　\(resultDisplay.getPlayer().getName()) \(resultDisplay.getDemandedSum())ポイント"
            let eachViewImage = UIImageView()
            eachViewImage.configureLayout { (layout) in
                layout.isEnabled = true
                layout.width = YGValue(eachPlayerTileWidth)
                layout.height = YGValue(eachPlayerTileHeight)
                layout.marginTop = 10
            }
            eachViewImage.image = resultDisplay.getPlayer().getImage()
            eachViewImage.contentMode = .scaleAspectFit
            
            contentEachView.addSubview(name)
            contentEachView.addSubview(eachViewImage)
            parentViewMain.addSubview(contentEachView)
            index += 1
        }
    }
    
    func makeEndButton(){
        endButton = UIButton()
        endButton.backgroundColor = .systemIndigo
        endButton.configureLayout { [self] (layout) in
        endButton.setTitle("トップ画面に戻る", for: UIControl.State.normal)
        endButton.setTitleColor(.white, for: .normal)
        endButton.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginTop = 50
            layout.height = YGValue(footerButtonHeight)
            layout.width = YGValue(headerWidth)
            layout.alignSelf = .center
        }
            scrollView.addSubview(endButton)
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
    @objc func reset(){
        //初期化
        count = 0
        //各プレイヤーの質問目数をカウントする
        questionNumber = 0
        questionNumberReal = 0
        gameNumber = Int.random(in: 1..<1000000)
        memberList = Array()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
