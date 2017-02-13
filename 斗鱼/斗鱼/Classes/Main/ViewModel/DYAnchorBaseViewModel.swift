//
//  DYAnchorBaseViewModel.swift
//  斗鱼
//
//  Created by pba on 2017/2/10.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

class DYAnchorBaseViewModel {
    
    // MARK: - 定义的属性
    var AnchorGroups : [DYAnchorGroupModel] = [DYAnchorGroupModel]()

}

extension DYAnchorBaseViewModel {
    // MARK: - 请求数据
    func requestData(isGroupData : Bool? = true,url : String,params : [String : Any]? = nil,finishedCallBack : @escaping () -> ()) {
        
        DYHttpTool.request(type: .GET, url: url, parames: params) { (result) in
            //1.取出数据
            guard let resultDict = result as? [String : Any] else {return}
            guard let resultArray = resultDict["data"] as? [[String : Any]] else {return}
            //2.字典转模型
            //2.1判断是否是分组数据
            if isGroupData == true {
                for dict in resultArray {
                    let anchorGroup = DYAnchorGroupModel(dict: dict)
                    //删除这里的颜值数据
                    if anchorGroup.tag_name == "颜值" {
                        continue
                    }
                    self.AnchorGroups.append(anchorGroup)
                }

            }else{
                let group = DYAnchorGroupModel()
                
                for dict in resultArray {
                    group.anchors.append(DYAnchorModel(dict: dict))
                }
                self.AnchorGroups.append(group)
            }
            
            //3.完成闭包
            finishedCallBack()
        }
    }
    
}
