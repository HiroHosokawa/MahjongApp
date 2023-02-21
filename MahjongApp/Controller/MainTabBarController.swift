//
//  ViewController.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/09.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //    var myTabBar = UITabBar()
    //
    //    let width = UITabBar.view.frame.width
    //    let height = UITabBar.view.frame.height
    //    let tabBarHeight:CGFloat = 49
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        myTabBar.delegate = self
        settingTabBar()
        
    }
    func settingTabBar() {
        let startGameViewController = StartGameViewController()
        let startGameViewNav = UINavigationController(rootViewController: startGameViewController)
        
        let gameDataViewController = GameDataViewController()
        let memberViewController = MemberViewController()
        let checkerViewController = CheckerViewController()
        
        let systemViewController = SystemViewController()
        let systemNav = UINavigationController(rootViewController: systemViewController)
        
        //        myTabBar.frame = CGRect(x: 0, y: height - tabBarHeight, width: width, height: tabBarHeight)
        //        myTabBar.barTintColor = UIColor(red: 244/255, green: 178/255, blue: 64/255, alpha: 1.0)
        //        myTabBar.unselectedItemTintColor = UIColor.lightGray
        //        myTabBar.tintColor = UIColor(red: 103/255, green: 190/255, blue: 141/255, alpha: 1.0)
        
        startGameViewController.tabBarItem = UITabBarItem(title: "対局！", image: UIImage(named: "startGameIcon"), tag: 1)
        gameDataViewController.tabBarItem = UITabBarItem(title: "履歴", image: UIImage(named: "gameDataIcon"), tag: 2)
        memberViewController.tabBarItem = UITabBarItem(title: "面子", image: UIImage(named: "memberIcon"), tag: 3)
        checkerViewController.tabBarItem = UITabBarItem(title: "チェッカー", image: UIImage(named: "checkIcon"), tag: 4)
        systemViewController.tabBarItem = UITabBarItem(title: "設定", image: UIImage(named: "systemIcon"), tag: 5)
        
        viewControllers = [startGameViewNav,gameDataViewController,memberViewController,checkerViewController,systemNav]
        
//        UITabBar.appearance().barTintColor = UIColor(red: 244/255, green: 178/255, blue: 64/255, alpha: 1.0)
        //        UITabBar.appearance().tintColor = UIColor(red: 103/255, green: 190/255, blue: 141/255, alpha: 1.0)
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(red: 244/255, green: 178/255, blue: 64/255, alpha: 1.0)
        self.tabBar.standardAppearance = tabBarAppearance
        
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
    
}

