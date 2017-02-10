//
//  DYAmuseVM.swift
//  斗鱼
//
//  Created by pba on 2017/2/10.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

class DYAmuseVM : DYAnchorBaseViewModel {

}

extension DYAmuseVM {

    // MARK: - 请求娱乐数据
    func requestAmuseData(finishedCallBack : @escaping () -> ()) {
        
        requestData(url: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCallBack)
    }
   
}
