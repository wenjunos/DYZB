//
//  DYPageTitleView.swift
//  斗鱼
//
//  Created by pba on 2017/1/13.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kScrollLineH : CGFloat = 2.0
private let kNormalColor : (r : CGFloat, g : CGFloat, b : CGFloat) = (85,85,85)
private let kSelectColor : (r : CGFloat, g : CGFloat, b : CGFloat) = (255,128,0)

// MARK: - 协议
//class：表示这个协议只能被类遵守
protocol DYPageTitleViewDelegete : class {
    //协议方法
    func pageTitleView(pageTitleView : DYPageTitleView, selectIndex : Int)
}


class DYPageTitleView: UIView {
    // MARK: - 定义属性
    //标题数组
    var titles = [String]()
    //装label的数组
    var titleLabelArray = [UILabel]()
    //当前label索引
    var currentIndex : Int = 0
    //代理
    weak var delegate : DYPageTitleViewDelegete?
    
    
    // MARK: - 懒加载的属性
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //滚动条
    lazy var scrollLine : UIView = UIView()
    
    // MARK: - 构造方法
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)

        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
// MARK: - 设置UI
extension DYPageTitleView {
    
    func setupUI() {
        //1. 添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2. 添加label
        setupTitleLabel()
        
        //3. 添加底线和滚动条
        setupBottomLineAndScrollLine()
    }
    
    //添加label
    func setupTitleLabel() {
        let labelW = frame.width / CGFloat(titles.count)
        let labelH = frame.height - CGFloat(kScrollLineH)
        let labelY = 0
        
        for title in titles.enumerated() {
            //1. 创建label
            let label = UILabel()
            //2. 设置label属性
            label.text = title.element
            label.tag = title.offset
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNormalColor.r, g: kNormalColor.g, b: kNormalColor.b)
            label.textAlignment = .center

            let labelX = labelW * CGFloat(title.offset)
            label.frame = CGRect(x: Int(labelX), y: labelY, width: Int(labelW), height: Int(labelH))
            
            //3.添加label
            scrollView.addSubview(label)
            titleLabelArray.append(label)
            
            //4.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    //添加底线和滚动条
    func setupBottomLineAndScrollLine() {
        //1. 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2. 添加滚动条
        //取得第一个label
        guard let firstLabel = titleLabelArray.first else {
            return
        }
        
        scrollView.addSubview(scrollLine)
        scrollLine.backgroundColor = UIColor.orange
        firstLabel.textColor = UIColor(r: kSelectColor.r, g: kSelectColor.g, b: kSelectColor.b)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}

// MARK: - 事件处理
extension DYPageTitleView {
    //titleLabel的点击事件
    @objc func titleLabelClick(tapGes : UITapGestureRecognizer){
        //0.获取当前点击的label
        guard let tapLabel = tapGes.view as? UILabel else { return }
        
        //1.过滤点击相同的title
        if tapLabel.tag == currentIndex { return }
        
        //2.获取之前的label
        let oldLabel = titleLabelArray[currentIndex]
        
        //3.更新label状态
        tapLabel.textColor = UIColor(r: kSelectColor.r, g: kSelectColor.g, b: kSelectColor.b)
        oldLabel.textColor = UIColor(r: kNormalColor.r, g: kNormalColor.g, b: kNormalColor.b)
        
        //4.保存索引
        currentIndex = tapLabel.tag
        
        //5.更新滚动条的位置
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        //6.通知代理
        delegate?.pageTitleView(pageTitleView: self, selectIndex: currentIndex)
        
    }
}

// MARK: - Private methold
extension DYPageTitleView {
    //设置TitleView当前滑动的位置
    func setCurrentTitleView(progress : CGFloat, sourceIndex : Int, targetIndex : Int){
        //1.取出当前的label和之前的label
        let sourceLabel = titleLabelArray[sourceIndex]
        let targetLabel = titleLabelArray[targetIndex]
        
        //2.更新滚动条的位置
        let moveX = (targetLabel.frame.origin.x - sourceLabel.frame.origin.x) * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.让label颜色渐变
        let colorDif : (r : CGFloat, g : CGFloat, b : CGFloat) = (kSelectColor.r - kNormalColor.r, kSelectColor.g - kNormalColor.g, kSelectColor.b - kNormalColor.b)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.r - colorDif.r * progress, g: kSelectColor.g - colorDif.g * progress, b: kSelectColor.b - colorDif.b * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.r + colorDif.r * progress, g: kNormalColor.g + colorDif.g * progress, b: kNormalColor.b + colorDif.b * progress)
        
        //4.记录最新的索引
        currentIndex = targetIndex
    }
}




