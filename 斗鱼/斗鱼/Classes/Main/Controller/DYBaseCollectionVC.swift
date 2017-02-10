//
//  DYBaseCollectionVC.swift
//  斗鱼
//
//  Created by pba on 2017/2/10.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50
private let DYRecommendHeaderID = "DYRecommendHeaderID"

let kBaseItemW : CGFloat = (kScreenW - 3 * kItemMargin) * 0.5
let kBaseItemH : CGFloat = kBaseItemW * 3 / 4
let DYRecommendItemID = "DYRecommendItemID"
let DYRecommendPrettyItemID = "DYRecommendPrettyItemID"

class DYBaseCollectionVC: UIViewController {
    // MARK: - 懒加载的属性
    //VM
    var baseVM : DYAnchorBaseViewModel!
    //collectionView
    lazy var collectionView : UICollectionView = {[unowned self] in
        //1.设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kBaseItemW, height: kBaseItemH)
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
        //设置UI
        setUpUI()
        //请求数据
        requestData()
    }
    
}

// MARK: - 设置UI,子类可重写此方法增加UI
extension DYBaseCollectionVC {
    
    func setUpUI() {
        //1. 添加collectionView
        view.addSubview(collectionView)
    }
    
}

// MARK: - 请求数据,子类重写此方法可请求数据
extension DYBaseCollectionVC {
    func requestData() {

    }
}

// MARK: - UICollectionViewDataSource
extension DYBaseCollectionVC : UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.AnchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let groupModel = baseVM.AnchorGroups[section]
        return groupModel.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DYRecommendItemID, for: indexPath) as! DYCollectionNormalCell
        
        let groupModel = baseVM.AnchorGroups[indexPath.section]
        cell.anchorModel = groupModel.anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DYRecommendHeaderID, for: indexPath) as! DYRecommendHeaderView
        
        headerView.anchorGroup = baseVM.AnchorGroups[indexPath.section]
        
        return headerView
    }

}


