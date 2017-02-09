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
    
    @IBOutlet weak var moreBtn: UIButton!
    //模型
    var anchorGroup : DYAnchorGroupModel?{
        didSet{
            //组标题
            titleLabel.text = anchorGroup?.tag_name
            //组图片
            iconView.image = UIImage(named: anchorGroup?.icon_name ?? "home_header_normal")
        }
    }
}
