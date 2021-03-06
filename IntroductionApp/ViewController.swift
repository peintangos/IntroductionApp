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
import SideMenu

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
var isLayout:Bool = false
var switchButton = UISwitch(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
var isOneByOne = false
class ViewController: UIViewController {
    
    let dispose = DisposeBag()
    let parts = UIParts()
    var menu: UISideMenuNavigationController?
    lazy var menuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.done, target: self, action: #selector(didTapMenu))

//    var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        memberList = Array()
        gameNumber = Int.random(in: 1..<1000000)
        self.view.backgroundColor = .systemIndigo
        title = "Side Menu"
        menu = UISideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.menuLeftNavigationController = menu
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.view)
        navigationItem.setLeftBarButton(menuBarButtonItem, animated: false)
        self.navigationController?.navigationBar.barTintColor = .systemIndigo

        count = 0
        // create the NavigationController with my VC as root
    }
    @objc func didTapMenu(){
        present(menu!,animated: true)
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
//        セーフリアの取得の都合上、viewWillLayoutSubviews()以降でメソッドを呼ぶ必要があるが、このメソッドは画面進入時に毎回呼ばれてしまうので、フラグで制御する
        if !isLayout {
            makeLayout()
        }
    }
    func makeLayout(){
        view.configureLayout { (layout) in
          layout.isEnabled = true
          layout.width = YGValue(self.view.bounds.size.width)
          layout.height = YGValue(self.view.bounds.size.height)
          layout.flexDirection = .column
          layout.alignItems = .center
            layout.justifyContent = .spaceAround
        }
//        背景色を白にしないと、画面が真っ黒になってしまう。
//        view.backgroundColor = .white
        
        let contentView = parts.makeContetnView(vc:self)
        let leftContentView = parts.makeTopFieldLeftButton()
        let rightContentView = parts.makeTopFieldRightButton()
        let titleView = parts.makeTitleView(vc:self)
        let title = parts.makeTitle(vc: self)

        titleView.addSubview(title)
        view.addSubview(titleView)
        
        contentView.addSubview(leftContentView)
        contentView.addSubview(rightContentView)
        view.addSubview(contentView)
        
//        練習用に作る後で消す
//        let tempo = parts.button(vc: self)
//        contentView.addSubview(tempo)
//        tempo.rx.tap.subscribe { (action) in
//            let am = ResultsViewController()
//            am.modalPresentationStyle = .fullScreen
//            self.present(am, animated: true, completion: nil)
//        }
        
        view.yoga.applyLayout(preservingOrigin: true)

//        Rxを用いて、タップ時の画面遷移を整理
        do{
            rightContentView.rx.tap.subscribe { (action) in
                AlertUtil().makeAlert(vc: self)
            }.disposed(by: dispose)
            
            leftContentView.rx.tap.subscribe { (action) in
                let fv = FaceRedFieldViewController()
                fv.modalPresentationStyle = .fullScreen
                self.present(fv, animated: true, completion: nil)
            }.disposed(by: dispose)
            
//            menuButton.rx.tap.subscribe { [self] (action) in
//                sideMenuController.showMenu(view: sideMenuView)
//            }.disposed(by: dispose)
        }
        isLayout = true
    }


}
class MenuListController: UITableViewController{
    let dispose = DisposeBag()
    var items = ["OneByOne"]
    let darkColor = UIColor.init(red: 33 / 255, green: 33 / 255, blue: 33 / 255, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        if indexPath.row == 0{
            cell.accessoryView = switchButton
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

