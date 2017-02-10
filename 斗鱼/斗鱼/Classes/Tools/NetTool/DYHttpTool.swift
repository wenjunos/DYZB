  //
//  DYHttpTool.swift
//  斗鱼
//
//  Created by pba on 2017/1/19.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit
import Alamofire

//请求方式
enum MethodType {
    case POST
    case GET
}

class DYHttpTool: NSObject {

    class func request(type : MethodType, url : String, parames : [String : Any]? = nil, callBack : @escaping (_ response : Any) -> ()) {
        //请求类型
        let methodType = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method: methodType, parameters: parames).responseJSON { (response) in
            guard let result = response.result.value else {
                //请求失败
                print(response.result.error as Any)
                return
            }
            //请求成功
            callBack(result)
        }
    }
}
