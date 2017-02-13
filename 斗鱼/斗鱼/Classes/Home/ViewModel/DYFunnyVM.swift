//
//  DYFunnyVM.swift
//  斗鱼
//
//  Created by pba on 2017/2/13.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

class DYFunnyVM: DYAnchorBaseViewModel {
    

}
// MARK: - 请求趣玩界面数据
extension DYFunnyVM {

    func requestFunnyData(finishedCallBack : @escaping () -> ()) {
        requestData(url: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", params: ["limit" : 30, "offset" : 0], finishedCallBack: finishedCallBack)
    }
}
