//
//  DYAmuseMenuCell.swift
//  斗鱼
//
//  Created by pba on 2017/2/13.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

private let menuCellID = "menuCellID"

class DYAmuseMenuCell: UICollectionViewCell {
    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - 定义的属性
    var AnchorGroups : [DYAnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        //注册cell
        collectionView.register(UINib(nibName: "DYRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: menuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.frame.width / 4
        let itemH = collectionView.frame.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
    }

}

extension DYAmuseMenuCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AnchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellID, for: indexPath) as! DYRecommendGameCell

        let anchor = AnchorGroups?[indexPath.item]
        anchor?.isNeedLine = false
        cell.baseGameModel = anchor
        
        return cell
    }
}





