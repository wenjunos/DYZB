//
//  DYRecommendGameView.swift
//  斗鱼
//
//  Created by pba on 2017/2/8.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

private let gameViewItemID : String = "gameViewItemID"
private let kInsetValue : CGFloat = 10

class DYRecommendGameView: UIView {
    
    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    //数据数组
    var groupArray : [DYAnchorGroupModel]?{
        didSet{
            //1. 删除前两个数据
            groupArray?.removeFirst()
            groupArray?.removeFirst()
            //2. 增加更多
            let moreData = DYAnchorGroupModel()
            moreData.tag_name = "更多"
            groupArray?.append(moreData)
            //3. 刷新数据
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        //1. 设置数据源
        collectionView.dataSource = self
        
        //2. 注册cell
        collectionView.register(UINib(nibName: "DYRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: gameViewItemID)
        
        //3. 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(0, kInsetValue, 0, kInsetValue)
    }

}

// MARK: - 快速创建的方法
extension DYRecommendGameView {
    
    class func recommendGameView() -> DYRecommendGameView {
        
        return Bundle.main.loadNibNamed("DYRecommendGameView", owner: nil, options: nil)?.first as! DYRecommendGameView
    }
}

extension DYRecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: gameViewItemID, for: indexPath) as! DYRecommendGameCell

        item.anchorGroup = groupArray?[indexPath.item]
        
        return item
        
    }
    
    
}
