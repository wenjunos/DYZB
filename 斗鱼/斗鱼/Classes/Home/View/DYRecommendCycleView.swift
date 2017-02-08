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
    //定时器
    var cycleTimer : Timer?
    
    //数据源
    var cycleDatas : [DYRecommendCycleModel]? {
        didSet {
            //1.刷新数据
            collectionView.reloadData()
            //2.设置页数
            pageControl.numberOfPages = cycleDatas?.count ?? 0
            //3.默认滚动到中间位置
            let indexPath = NSIndexPath(item: (cycleDatas?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            //4.添加定时器
            removeTimer()
            addTimer()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
        return (cycleDatas?.count ?? 0) * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: cycleItemID, for: indexPath) as! DYRecommendCycleCell
        
        //2.给cell赋值
        item.cycleModel = cycleDatas?[indexPath.item % cycleDatas!.count]
        
        //3.返回cell
        return item
    }
    
}

// MARK: - UICollectionViewDelegate
extension DYRecommendCycleView : UICollectionViewDelegate {
    //更新pageControl的位置
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获得偏移量
        let offset = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2.设置pageControl
        pageControl.currentPage = Int(offset / scrollView.bounds.width) %  (cycleDatas?.count ?? 1)
    }
    //开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //移除定时器
        removeTimer()
    }
    //结束拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //开启定时器
        addTimer()
    }
}
// MARK: - 定时器方法
extension DYRecommendCycleView {
    //添加定时器
    func addTimer() {
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    //移除定时器
    func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    //自动移动到下一页
    @objc func scrollToNext() {
        //1.获取滚动的偏移量
        let offset = collectionView.contentOffset.x + collectionView.bounds.width

        //2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        
    }
}







