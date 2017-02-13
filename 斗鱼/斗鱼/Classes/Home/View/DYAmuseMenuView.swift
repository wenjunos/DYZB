//
//  DYAmuseMenuView.swift
//  斗鱼
//
//  Created by pba on 2017/2/13.
//  Copyright © 2017年 wenjun. All rights reserved.
//  娱乐界面的顶部菜单

import UIKit

private let menuViewCellID = "menuViewCellID"

class DYAmuseMenuView: UIView {
    // MARK: - 控件属性
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - 定义的属性
    var AnchorGroups : [DYAnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - 系统回调
    override func awakeFromNib() {
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell
        collectionView.register(UINib(nibName: "DYAmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: menuViewCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }

}

// MARK: - 快速创建方法
extension DYAmuseMenuView {
    class func menuView() -> DYAmuseMenuView {
        return Bundle.main.loadNibNamed("DYAmuseMenuView", owner: nil, options: nil)?.first as! DYAmuseMenuView
    }
}
// MARK: - UICollectionViewDataSource
extension DYAmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if AnchorGroups == nil { return 0 }
        let page = (AnchorGroups!.count-1) / 8 + 1
        //设置pageControl的页数
        pageControl.numberOfPages = page
        return page
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuViewCellID, for: indexPath) as! DYAmuseMenuCell
        
        //设置cell的数据
        setCellData(cell: cell, indexPath: indexPath)

        return cell
    }
    
    //设置cell的数据
    func setCellData(cell : DYAmuseMenuCell, indexPath : IndexPath){
        //1.计算开始位置和结束位置
        //0~7
        //8~15
        //16~23
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //2.防止越界
        if endIndex > AnchorGroups!.count - 1 {
            endIndex = AnchorGroups!.count - 1
        }
        //3.赋值
        cell.AnchorGroups = Array(AnchorGroups![startIndex...endIndex])
    }
}

// MARK: - UICollectionViewDelegate
extension DYAmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //设置pageControl的当前页
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
