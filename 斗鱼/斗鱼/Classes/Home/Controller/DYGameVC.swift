//
//  DYGameVC.swift
//  斗鱼
//
//  Created by pba on 2017/2/9.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kTopViewH : CGFloat = 90

private let gameCellID : String = "gameCellID"
private let gameHeaderViewID : String = "gameHeaderViewID"

class DYGameVC: UIViewController {
    // MARK: - 定义的属性
    fileprivate lazy var gameVM : DYGameVM = DYGameVM()
    // MARK: - 懒加载的属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        //设置边距
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
        //头部视图
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //2. 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        //注册cell
        collectionView.register(UINib(nibName: "DYRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellID)
        //注册header
        collectionView.register(UINib(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: gameHeaderViewID)
        return collectionView
    }()
    //顶部的头部视图
    fileprivate lazy var topHeaderView : DYRecommendHeaderView = {
        let topHeaderView = DYRecommendHeaderView.headerView()
        topHeaderView.frame = CGRect(x: 0, y: -(kHeaderViewH+kTopViewH), width: kScreenW, height: kHeaderViewH)
        topHeaderView.moreBtn.isHidden = true
        topHeaderView.titleLabel.text = "常用"
        topHeaderView.iconView.image = UIImage(named: "Img_orange")
        return topHeaderView
    }()
    //顶部视图
    fileprivate lazy var topView : DYRecommendGameView = {
        let topView = DYRecommendGameView.recommendGameView()
        topView.frame = CGRect(x: 0, y: -kTopViewH, width: kScreenW, height: kTopViewH)
        return topView
    }()
    
    // MARK: - View life
    override func viewDidLoad() {
        super.viewDidLoad()

        //1.设置UI
        setUpUI()
        
        //2.请求数据
        requestData()
        
        
    }


}
// MARK: - 设置UI
extension DYGameVC {
    
    fileprivate func setUpUI() {
        //1. 添加UICollectionView
        view.addSubview(collectionView)
        
        //2. 添加顶部的header
        collectionView.addSubview(topHeaderView)
        
        //3. 添加顶部的View
        collectionView.addSubview(topView)
        
        //4. 增加collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewH+kTopViewH, 0, 0, 0)
    }
}

// MARK: - 请求数据
extension DYGameVC {
    fileprivate func requestData() {
        //1. 请求游戏数据
        gameVM.requestGameData {

            //1.1传递头部视图数据
            self.topView.groupArray = Array(self.gameVM.gameDatas[0..<10])
            
            //1.2 刷新数据
            self.collectionView.reloadData()
            
            
        }
    }
}

extension DYGameVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellID, for: indexPath) as! DYRecommendGameCell
        //取出模型数据
        let gameModel = gameVM.gameDatas[indexPath.item]
        //这里需要分割线
        gameModel.isNeedLine = true
        
        cell.baseGameModel = gameModel
        
        return cell
        
    }
    //头部视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: gameHeaderViewID, for: indexPath) as! DYRecommendHeaderView
        
        header.titleLabel.text = "全部"
        header.iconView.image = UIImage(named: "Img_orange")
        header.moreBtn.isHidden = true
        
        return header
        
    }
}


