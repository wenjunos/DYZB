//
//  DYRecommendVC.swift
//  斗鱼
//
//  Created by pba on 2017/1/17.
//  Copyright © 2017年 wenjun. All rights reserved.
//  推荐模块

import UIKit

// MARK: - 定义的常量
private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) * 0.5
private let kItemH : CGFloat = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let DYRecommendItemID = "DYRecommendItemID"
private let DYRecommendPrettyItemID = "DYRecommendPrettyItemID"
private let DYRecommendHeaderID = "DYRecommendHeaderID"

class DYRecommendVC: UIViewController {
    
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
    //recommendVM
    lazy var recommendVM : DYRecommendVM = DYRecommendVM()
    //顶部banner
    lazy var cycleView : DYRecommendCycleView = {
        let cycleView = DYRecommendCycleView.cycleView()
        //设置frame（此时cycleView跟随父控件缩放，未显示出来）
        //解决方案1：去掉use auto layout,并把跟随父控件缩放的约束去除
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH-kGameViewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    //游戏模块
    lazy var gameView : DYRecommendGameView = {
        let gameView = DYRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    // MARK: - View life
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        //请求数据
        requestData()
    }

}
// MARK: - 设置UI
extension DYRecommendVC {
    func setupUI() {
        
        //1. 添加collectionView
        view.addSubview(collectionView)
        //2. 添加顶部banner
        collectionView.addSubview(cycleView)
        //3. 添加gameView
        collectionView.addSubview(gameView)
        //4. 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH+kGameViewH, 0, 0, 0)
    }
}

// MARK: - 请求数据
extension DYRecommendVC {
    func requestData() {
        //1.请求推荐数据
        recommendVM.requestRecommendData {
            //1.1 刷新表格
            self.collectionView.reloadData()
            
            //1.2 传递数据给gameView
            var groupArray = self.recommendVM.AnchorGroups
            //1.3 删除前两个数据
            groupArray.removeFirst()
            groupArray.removeFirst()
            //1.4 增加更多
            let moreData = DYAnchorGroupModel()
            moreData.tag_name = "更多"
            groupArray.append(moreData)
            
            self.gameView.groupArray = groupArray
        }
        
        //2.请求banner数据
        recommendVM.requestCycleData {
            //将数据传递给cycleView
            self.cycleView.cycleDatas = self.recommendVM.cycleDatas
        }
    }
    
    
}

// MARK: - UICollectionViewDataSource
extension DYRecommendVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommendVM.AnchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommendVM.AnchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //0.取出模型
        let group = recommendVM.AnchorGroups[indexPath.section]
        //1.定义cell
        var item : DYCollectionBaseCell!
        
        if indexPath.section == 1 { //颜值
            item = collectionView.dequeueReusableCell(withReuseIdentifier: DYRecommendPrettyItemID, for: indexPath) as! DYRecommendPrettyCell
        }else{
            item = collectionView.dequeueReusableCell(withReuseIdentifier: DYRecommendItemID, for: indexPath) as! DYCollectionNormalCell
        }
        //2.设置模型
        item.anchorModel = group.anchors[indexPath.item]
        
        //3.返回item
        return item
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.创建header
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DYRecommendHeaderID, for: indexPath) as! DYRecommendHeaderView
        
        //2.设置header
        headerView.anchorGroup = recommendVM.AnchorGroups[indexPath.section]
        
        //3.返回header
        return headerView
    }
    
    //设置item的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 { //颜值
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kItemW, height: kItemH)
        }
    }
    

}











