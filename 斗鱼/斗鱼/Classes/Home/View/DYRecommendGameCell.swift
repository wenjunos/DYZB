//
//  DYRecommendGameCell.swift
//  斗鱼
//
//  Created by pba on 2017/2/8.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit
import Kingfisher

class DYRecommendGameCell: UICollectionViewCell {
    // MARK: - 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconView: UIImageView!
    
    var anchorGroup : DYAnchorGroupModel? {
        didSet{
            //标题
            titleLabel.text = anchorGroup?.tag_name
            //图片
            iconView.kf.setImage(with: URL(string: (anchorGroup?.icon_url)!), placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
}
