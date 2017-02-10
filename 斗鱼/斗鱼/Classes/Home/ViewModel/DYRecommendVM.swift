//
//  DYRecommendVM.swift
//  斗鱼
//
//  Created by pba on 2017/1/19.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

class DYRecommendVM : DYAnchorBaseViewModel {
    // MARK: - 懒加载的属性
    //banner数据
    lazy var cycleDatas : [DYRecommendCycleModel] = [DYRecommendCycleModel]()
    //热门数据
    lazy var hotGroup : DYAnchorGroupModel = DYAnchorGroupModel()
    //颜值数据
    lazy var prettyGroup : DYAnchorGroupModel = DYAnchorGroupModel()
}

extension DYRecommendVM {
    //1.请求推荐数据
    func requestRecommendData(finishedCallBack : @escaping () -> ()) {
        //请求参数
        let param = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        //创建并进入组队列
        let disGroup = DispatchGroup()
        disGroup.enter()
        
        //1.请求第一部分数据
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1484822717
        DYHttpTool.request(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parames: ["time" : NSDate.getCurrentTime()]) { (response) in
            //1.1将结果转成字典类型
            guard let result = response as? [String : NSObject] else { return }
            //1.2取出需要的数据
            guard let data = result["data"] as? [[String : NSObject]] else { return }
            //1.3模型赋值
            self.hotGroup.icon_name = "columnHotIcon"
            self.hotGroup.tag_name = "最热"
            //1.4字典转模型
            for dict in data {
                let model = DYAnchorModel(dict: dict)
                self.hotGroup.anchors.append(model)
            }
            //1.5离开组
            disGroup.leave()
        }
        
        //2.请求第二部分数据
        disGroup.enter()
        DYHttpTool.request(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parames: param) { (response) in
            //2.1将结果转成字典类型
            guard let result = response as? [String : NSObject] else { return }
            //2.2取出需要的数据
            guard let data = result["data"] as? [[String : NSObject]] else { return }
            //2.3模型赋值
            self.prettyGroup.icon_name = "columnYanzhiIcon"
            self.prettyGroup.tag_name = "颜值"
            //2.4字典转模型
            for dict in data {
                let model = DYAnchorModel(dict: dict)
                self.prettyGroup.anchors.append(model)
            }

            //2.5离开组
            disGroup.leave()

        }
        
        //3.请求后面的数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1484822717
        //print(NSDate.getCurrentTime())

        disGroup.enter()
        requestData(url: "http://capi.douyucdn.cn/api/v1/getHotCate", params: param) { 
            //离开组
            disGroup.leave()
        }

        //4.合并数据
        disGroup.notify(queue: DispatchQueue.main) {
            
            self.AnchorGroups.insert(self.prettyGroup, at: 0)
            self.AnchorGroups.insert(self.hotGroup, at: 0)
            
            //执行闭包
            finishedCallBack()
        }
        
    }
    
    //2.请求顶部banner数据
    //http://www.douyutv.com/api/v1/slide/6?version=2.431
    func requestCycleData(finishedCallBack : @escaping () -> ()) {
        DYHttpTool.request(type: .GET, url: "http://www.douyutv.com/api/v1/slide/6", parames: ["version" : "2.431"]) { (response) in
            //1.将结果转成字典类型
            guard let responseDict = response as? [String : NSObject] else { return }
            //2.取出data数据
            guard let dicArray = responseDict["data"] as? [[String : NSObject]] else { return }
            //3.字典转模型
            for dict in dicArray {
                self.cycleDatas.append(DYRecommendCycleModel(dict: dict))
            }
            //4.执行闭包
            finishedCallBack()
        }
    }
}
