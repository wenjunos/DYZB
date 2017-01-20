//
//  DYCollectionNormalCell.swift
//  斗鱼
//
//  Created by pba on 2017/1/17.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit
import Kingfisher

class DYCollectionNormalCell: UICollectionViewCell {
    //标题
    @IBOutlet weak var titleLabel: UILabel!
    //昵称
    @IBOutlet weak var nameLabel: UILabel!
    //图标
    @IBOutlet weak var iconView: UIImageView!
    //展示的图片
    @IBOutlet weak var showImgView: UIImageView!
    //在线人数
    @IBOutlet weak var onlineBtn: UIButton!
    //模型
    var anchorModel : DYAnchorModel? {
        didSet {
            //标题
            titleLabel.text = anchorModel?.room_name
            //昵称
            nameLabel.text = anchorModel?.nickname
            //在线人数
            if let text = anchorModel?.online {
                onlineBtn.setTitle("\(text)", for: .normal)
                onlineBtn.setTitleColor(UIColor.white, for: .normal)
                onlineBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
                onlineBtn.titleLabel?.textAlignment = .center
            }
            //展示的图片
            let url = URL(string: (anchorModel?.avatar_mid)!)
            showImgView.kf.setImage(with : url)
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
