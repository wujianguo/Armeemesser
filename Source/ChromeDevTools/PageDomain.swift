//
//  PageDomain.swift
//  Armeemesser
//
//  Created by Jianguo Wu on 2018/5/18.
//  Copyright © 2018年 wujianguo. All rights reserved.
//

import Foundation

open class PageDomain: Domain {
    
    var name: String = "Page"
    
    var handler: DomainHandler
    
    var enable: Bool = false
    
    required public init(handler: DomainHandler) {
        self.handler = handler
    }
    
    func handle(enable: Bool) {
        self.enable = enable
    }
    
    func handle(id: Int, method: String, params: Dictionary<String, Any>?) {
        
    }
}

