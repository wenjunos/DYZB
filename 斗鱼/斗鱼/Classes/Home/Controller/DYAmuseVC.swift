//
//  DYAmuseVC.swift
//  斗鱼
//
//  Created by pba on 2017/2/10.
//  Copyright © 2017年 wenjun. All rights reserved.
//  娱乐界面

import UIKit

// MARK: - 定义的常量
private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) * 0.5
private let kItemH : CGFloat = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50

private let DYRecommendItemID = "DYRecommendItemID"
private let DYRecommendPrettyItemID = "DYRecommendPrettyItemID"
private let DYRecommendHeaderID = "DYRecommendHeaderID"

class DYAmuseVC: UIViewController {
    
    // MARK: - 懒加载的属性
    lazy var collectionView : UICollectionView = {[unowned self] in
        //1.设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        //2.创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册item
        collectionView.register(UINib(nibName: "DYCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: DYRecommendItemID)
        collectionView.register(UINib(nibName: "DYRecommendPrettyCell", bundle: nil), forCellWithReuseIdentifier: DYRecommendPrettyItemID)
        //注册头部视图
        collectionView.register(UINib(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: DYRecommendHeaderID)
        
        return collectionView
        }()


    override func viewDidLoad() {
        super.viewDidLoad()

        //1.设置UI
        setUpUI()
    }
    
}
// MARK: - 设置UI
extension DYAmuseVC {
    
    fileprivate func setUpUI() {
        //1. 添加collectionView
        view.addSubview(collectionView)
    }
    
}

// MARK: - UICollectionViewDataSource
extension DYAmuseVC : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DYRecommendItemID, for: indexPath) as! DYCollectionNormalCell
        
        cell.titleLabel.text = "英雄联盟"
        
        
        return cell
    }

}
