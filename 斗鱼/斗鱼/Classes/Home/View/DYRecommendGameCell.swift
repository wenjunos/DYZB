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
    //分割线
    @IBOutlet weak var seperatorLine: UIView!
    
    var baseGameModel : DYBaseGameModel? {
        didSet{
            //是否需要分割线
            if baseGameModel?.isNeedLine == true {
                seperatorLine.isHidden = false
            }else{
                seperatorLine.isHidden = true
            }
            //标题
            titleLabel.text = baseGameModel?.tag_name
            //图片
            iconView.kf.setImage(with: URL(string: (baseGameModel?.icon_url)!), placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
}
