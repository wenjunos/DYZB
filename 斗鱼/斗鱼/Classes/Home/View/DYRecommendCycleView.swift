//
//  DYRecommendCycleView.swift
//  斗鱼
//
//  Created by pba on 2017/1/22.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

private let cycleItemID : String = "cycleItemID"
private let kCycleViewH : CGFloat = kScreenW * 3 / 8

class DYRecommendCycleView: UIView {
    
    // MARK: - 定义的属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    //数据源
    var cycleDatas : [DYRecommendCycleModel]? {
        didSet {
            //1.刷新数据
            collectionView.reloadData()
            //2.设置页数
            pageControl.numberOfPages = cycleDatas?.count ?? 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        
        //1.注册cell
        collectionView.register(UINib(nibName: "DYRecommendCycleCell", bundle: nil), forCellWithReuseIdentifier: cycleItemID)
        
        //2.设置collectionView属性
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    override func layoutSubviews() {
        //1.设置layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = collectionView.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
    
    
}

// MARK: - 构造方法
extension DYRecommendCycleView {
    class func cycleView() -> DYRecommendCycleView {
        return Bundle.main.loadNibNamed("DYRecommendCycleView", owner: nil, options: nil)?.first as! DYRecommendCycleView
    }
}

// MARK: - UICollectionViewDataSource
extension DYRecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleDatas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: cycleItemID, for: indexPath) as! DYRecommendCycleCell
        
        //2.给cell赋值
        item.cycleModel = cycleDatas?[indexPath.item]
        
        //3.返回cell
        return item
    }
    
}
