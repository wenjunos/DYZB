//
//  DYRecommendCycleCell.swift
//  斗鱼
//
//  Created by pba on 2017/1/22.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit
import Kingfisher

class DYRecommendCycleCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    //模型
    var cycleModel : DYRecommendCycleModel? {
        didSet {
            //1.效验数据
            guard let cycleModel = cycleModel else { return }
            //2.设置图片
            let url = URL(string: (cycleModel.pic_url))
            imageView.kf.setImage(with : url)
        }
    }
    
    
}
