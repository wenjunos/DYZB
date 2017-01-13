//
//  MainTabBarVC.swift
//  斗鱼
//
//  Created by pba on 2017/1/13.
//  Copyright © 2017年 pba. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Me")

    }

    

}

extension MainTabBarVC {
    // MARK: - 添加子控制器
    func addChildVC(storyName : String) {
        //通过storyboard得到控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //添加到子控制器
        addChildViewController(childVC)
    }
}
