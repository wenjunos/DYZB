//
//  DYRecommendPrettyCell.swift
//  斗鱼
//
//  Created by pba on 2017/1/18.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit
import Kingfisher

class DYRecommendPrettyCell: UICollectionViewCell {
    //小图标
    @IBOutlet weak var iconView: UIImageView!
    //标题
    @IBOutlet weak var titleLabel: UILabel!
    //展示图片
    @IBOutlet weak var showImgView: UIImageView!
    //在线人数label
    @IBOutlet weak var onlineLabel: UILabel!
    //模型
    var anchorModel : DYAnchorModel? {
        didSet {
            //标题
            titleLabel.text = anchorModel?.nickname
            //展示图片
            let url = URL(string: (anchorModel?.avatar_mid)!)
            showImgView.kf.setImage(with : url)
            //在线人数
            if let text = anchorModel?.online {
                onlineLabel.text = "\(text)"
            }
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
