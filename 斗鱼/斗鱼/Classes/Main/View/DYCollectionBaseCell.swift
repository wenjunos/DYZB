//
//  DYCollectionBaseCell.swift
//  斗鱼
//
//  Created by pba on 2017/1/22.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

class DYCollectionBaseCell: UICollectionViewCell {
    //标题
    @IBOutlet weak var titleLabel: UILabel!
    //展示图片
    @IBOutlet weak var showImgView: UIImageView!
    //在线人数label
    @IBOutlet weak var onlineLabel: UILabel!

    //模型
    var anchorModel : DYAnchorModel? {
        didSet {
            //0.效验模型
            guard let anchorModel = anchorModel else { return }
            //1.在线人数
            var online : String = ""
            if anchorModel.online >= 10000 {
                let onlineInt = (Float(anchorModel.online) / 10000.0)
                let onlineStr = String(format: "%.1f", onlineInt)
                online = "\(onlineStr)万"
            }else{
                online = "\(anchorModel.online)"
            }
            onlineLabel.text = online
            
            //2.展示的图片
            let url = URL(string: (anchorModel.vertical_src))
            showImgView.kf.setImage(with : url)
            
        }
    }
}
