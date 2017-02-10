//
//  DYAmuseVC.swift
//  斗鱼
//
//  Created by pba on 2017/2/10.
//  Copyright © 2017年 wenjun. All rights reserved.
//  娱乐界面

import UIKit

class DYAmuseVC: DYBaseCollectionVC {
    //VM
    fileprivate lazy var amuseVM = DYAmuseVM()

}

// MARK: - 请求数据
extension DYAmuseVC {
    override func requestData() {
        //1.赋值给父类的VM
        baseVM = amuseVM
        
        //2.请求数据
        amuseVM.requestAmuseData {
            //刷新数据
            self.collectionView.reloadData()
        }
    }
}
