//
//  DYPageContentView.swift
//  斗鱼
//
//  Created by pba on 2017/1/13.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

private let itemID : String = "DYPageContentViewItemID"

class DYPageContentView: UIView {
    
    // MARK: - 定义属性
    var chlidsVC : [UIViewController]
    weak var parentVC : UIViewController?
    
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

// MARK: - 数据源
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

// MARK: - Private methold
extension DYPageContentView {
    //设置当前的ContentView
    func setCurrentContentView(index : Int) {
        //设置collectionView的偏移量
        let offset = CGFloat(index) * frame.width

        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
    }
}



