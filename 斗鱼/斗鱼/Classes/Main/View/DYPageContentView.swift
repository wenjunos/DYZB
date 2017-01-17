//
//  DYPageContentView.swift
//  斗鱼
//
//  Created by pba on 2017/1/13.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit
// MARK: - 定义的常量
private let itemID : String = "DYPageContentViewItemID"

// MARK: - 协议
protocol DYPageContentViewDelegate : class {
    func pageContentView(contentView : DYPageContentView,progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

class DYPageContentView: UIView {
    
    // MARK: - 定义属性
    var chlidsVC : [UIViewController]
    weak var parentVC : UIViewController?
    //滑动的偏移量
    var startOffsetX : CGFloat = 0
    weak var delegate : DYPageContentViewDelegate?
    //禁止执行滚动的代理（点击titleView）
    var isforbidDelegate : Bool = false
    
    // MARK: - 懒加载的属性
    lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册item
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: itemID)
        
        return collectionView
    }()
    

    // MARK: - 构造方法
    init(frame: CGRect, chlidsVC : [UIViewController], parentVC : UIViewController?) {
        
        self.chlidsVC = chlidsVC
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI
extension DYPageContentView {
    //设置UI
    func setupUI() {
        //1.将子控制器添加到父控制器中
        for childVC in self.chlidsVC {
            parentVC?.addChildViewController(childVC)
        }
        
        //2.添加collectionView，用collectionView存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

// MARK: - 数据源 UICollectionViewDataSource
extension DYPageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return chlidsVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = collectionView.dequeueReusableCell(withReuseIdentifier: itemID, for: indexPath)
        
        //防止循环引用导致重复，先将之前的子控制器删除
        for view in item.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //取出子控制器,给item设置内容
        let childVC = chlidsVC[indexPath.item]
        childVC.view.frame = item.contentView.bounds
        item.contentView.addSubview(childVC.view)
        
        return item
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension DYPageContentView : UICollectionViewDelegate {
    //获得开始拖拽的偏移量
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isforbidDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isforbidDelegate == true {
            return
        }
        //获取滑动的比例
        var progress : CGFloat = 0
        //获取当前索引
        var sourceIndex : Int = 0
        //获取目标索引
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        let ratio = currentOffsetX / scrollViewW
        //对比偏移量，确定是左滑，还是右滑
        if currentOffsetX > startOffsetX  { //左滑
            //1.获取滑动的比例:偏移量／宽度
            progress = ratio - floor(ratio)
            
            //2.获取当前索引
            sourceIndex = Int(ratio)
            
            //3.获取目标索引
            targetIndex = sourceIndex + 1
            if targetIndex >= chlidsVC.count {
                targetIndex = chlidsVC.count - 1
            }
            
            //4.如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1.0
                targetIndex = sourceIndex
            }
            
        }else{ //右滑
            //1.获取滑动的比例:偏移量／宽度
            progress = 1 - (ratio - floor(ratio))
            
            //2.获取目标索引
            targetIndex = Int(ratio)
            
            //3.获取当前索引
            sourceIndex = targetIndex + 1
            if sourceIndex >= chlidsVC.count {
                sourceIndex = chlidsVC.count - 1
            }
        }
        
        //通知代理
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK: - Private methold
extension DYPageContentView {
    //设置当前的ContentView
    func setCurrentContentView(index : Int) {
        //禁止执行滑动的代理方法
        isforbidDelegate = true
        
        //设置collectionView的偏移量
        let offset = CGFloat(index) * frame.width

        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
    }
}



