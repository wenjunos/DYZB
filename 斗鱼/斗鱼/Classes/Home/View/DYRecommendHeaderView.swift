//
//  DYRecommendHeaderView.swift
//  斗鱼
//
//  Created by pba on 2017/1/17.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

class DYRecommendHeaderView: UICollectionReusableView {
    //图片
    @IBOutlet weak var iconView: UIImageView!
    //标题
    @IBOutlet weak var titleLabel: UILabel!
    //模型
    var anchorGroup : DYAnchorGroupModel?{
        didSet{
            titleLabel.text = anchorGroup?.tag_name
            iconView.image = UIImage(named: anchorGroup?.icon_name ?? "home_header_normal")
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
}
