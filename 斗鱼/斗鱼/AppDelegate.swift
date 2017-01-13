//
//  AppDelegate.swift
//  斗鱼
//
//  Created by pba on 2017/1/12.
//  Copyright © 2017年 pba. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //设置tabbar选中颜色
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }



}

