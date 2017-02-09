//
//  DYGameVM.swift
//  斗鱼
//
//  Created by pba on 2017/2/9.
//  Copyright © 2017年 wenjun. All rights reserved.
//  游戏界面VM

import UIKit

class DYGameVM: NSObject {
    // MARK: - 定义的属性
    var gameDatas = [DYGameModel]()
    
    // MARK: - 请求游戏数据
    //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
    func requestGameData(finishedCallBack : @escaping () -> ()){
        
        DYHttpTool.request(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parames: ["shortName" : "game"]) { (response) in
            //1.取出数据
            guard let resultDict = response as? [String : Any] else { return }
            guard let result = resultDict["data"] as? [[String : Any]] else { return }
            
            //2.字典转模型
            for  dict in result {
                self.gameDatas.append(DYGameModel(dict: dict))
            }
            
            //3.执行闭包
            finishedCallBack()
        }
    }
}
