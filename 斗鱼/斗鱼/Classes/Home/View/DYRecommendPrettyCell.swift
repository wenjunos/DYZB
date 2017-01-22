//
//  DYRecommendPrettyCell.swift
//  斗鱼
//
//  Created by pba on 2017/1/18.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit
import Kingfisher

class DYRecommendPrettyCell: DYCollectionBaseCell {
    //城市
    @IBOutlet weak var cityLabel: UILabel!
    //模型
    override var anchorModel : DYAnchorModel? {
        didSet {
            //0.将模型传递给父类
            super.anchorModel = anchorModel
            //1.标题
            titleLabel.text = anchorModel?.nickname
            //2.城市
            cityLabel.text = anchorModel?.anchor_city
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
