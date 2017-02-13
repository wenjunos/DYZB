//
//  DYFunnyVC.swift
//  斗鱼
//
//  Created by pba on 2017/2/13.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

private let topEdge : CGFloat = 10

class DYFunnyVC: DYBaseCollectionVC {

    // MARK: - 懒加载的属性
    fileprivate lazy var funnyVM = DYFunnyVM()

    
}
// MARK: - 设置UI
extension DYFunnyVC {
    override func setUpUI() {
        super.setUpUI()
        
        //重写布局,此界面无头部视图
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        //增加collectionView的顶部间距
        collectionView.contentInset = UIEdgeInsetsMake(topEdge, 0, 0, 0)
    }
}

// MARK: - 请求数据
extension DYFunnyVC {
    override func requestData() {
        //1.赋值给父类的VM
        baseVM = funnyVM
        
        //2.请求数据
        funnyVM.requestFunnyData {
            //刷新数据
            self.collectionView.reloadData()
        }
    }
}



