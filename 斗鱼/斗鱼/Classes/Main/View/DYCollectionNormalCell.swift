//
//  DYCollectionNormalCell.swift
//  斗鱼
//
//  Created by pba on 2017/1/17.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit
import Kingfisher

class DYCollectionNormalCell: DYCollectionBaseCell {
    //昵称
    @IBOutlet weak var nameLabel: UILabel!
    //模型
    override var anchorModel : DYAnchorModel? {
        didSet {
            //0.将模型传递给父类
            super.anchorModel = anchorModel
            //1.标题
            titleLabel.text = anchorModel?.room_name
            //2.昵称
            nameLabel.text = anchorModel?.nickname
            //2.1设置图片
            guard let image = UIImage(named: "topRightMask") else {
                return
            }
            onlineLabel.backgroundColor = UIColor(patternImage: image)
            
        }
    }
    

}
