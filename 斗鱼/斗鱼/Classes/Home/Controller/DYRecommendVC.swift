//
//  DYRecommendVC.swift
//  斗鱼
//
//  Created by pba on 2017/1/17.
//  Copyright © 2017年 wenjun. All rights reserved.
//  推荐模块

import UIKit

// MARK: - 定义的常量
private let kPrettyItemH : CGFloat = kBaseItemW * 4 / 3
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90


class DYRecommendVC: DYBaseCollectionVC {
    
    //recommendVM
    fileprivate lazy var recommendVM : DYRecommendVM = DYRecommendVM()
    //顶部banner
    fileprivate lazy var cycleView : DYRecommendCycleView = {
        let cycleView = DYRecommendCycleView.cycleView()
        //设置frame（此时cycleView跟随父控件缩放，未显示出来）
        //解决方案1：去掉use auto layout,并把跟随父控件缩放的约束去除
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH-kGameViewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    //游戏模块
    fileprivate lazy var gameView : DYRecommendGameView = {
        let gameView = DYRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
}
// MARK: - 设置UI
extension DYRecommendVC {
    //重写父类方法设置UI
    override func setUpUI() {
        //1.调用父类
        super.setUpUI()
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
    override func requestData(){
        //0.赋值VM给父类
        baseVM = recommendVM
        
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
extension DYRecommendVC :UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

    //设置item的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 { //颜值
            return CGSize(width: kBaseItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kBaseItemW, height: kBaseItemH)
        }
    }
    

}











