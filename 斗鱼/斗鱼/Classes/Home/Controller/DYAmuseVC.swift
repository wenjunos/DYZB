//
//  DYAmuseVC.swift
//  斗鱼
//
//  Created by pba on 2017/2/10.
//  Copyright © 2017年 wenjun. All rights reserved.
//  娱乐界面

import UIKit

private let kMenuViewH : CGFloat = 200

class DYAmuseVC: DYBaseCollectionVC {
    // MARK: - 懒加载的属性
    //VM
    fileprivate lazy var amuseVM = DYAmuseVM()
    //顶部菜单栏
    fileprivate lazy var amuseMenuView : DYAmuseMenuView = {
        let amuseMenuView = DYAmuseMenuView.menuView()
        amuseMenuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return amuseMenuView
    }()
}
// MARK: - 设置UI
extension DYAmuseVC {
    override func setUpUI() {
        //1.调用super
        super.setUpUI()
        
        //2.添加amuseMenuView
        collectionView.addSubview(amuseMenuView)
        
        //3.增加collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kMenuViewH, 0, 0, 0)
    }
}

// MARK: - 请求数据
extension DYAmuseVC {
    override func requestData() {
        //1.赋值给父类的VM
        baseVM = amuseVM
        
        //2.请求数据
        amuseVM.requestAmuseData {
            //传递数据给顶部menuView
            //删除“最热”
            var tempArray = self.amuseVM.AnchorGroups
            tempArray.removeFirst()
            self.amuseMenuView.AnchorGroups = tempArray
            //刷新数据
            self.collectionView.reloadData()
   
        }
    }
}
