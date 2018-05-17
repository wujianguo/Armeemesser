//
//  Domain.swift
//  Armeemesser
//
//  Created by Jianguo Wu on 2018/5/16.
//  Copyright © 2018年 wujianguo. All rights reserved.
//

import Foundation


public protocol DomainHandler {
    
    func send(method: String, params: Dictionary<String, Any>?)
    
}

protocol Domain {
    
    var handler: DomainHandler { get }
    
    var name: String { get }
    
    var enable: Bool { get set }
    
    init(handler: DomainHandler)
    
    func handle(enable: Bool)
    
    func handle(id: Int, method: String, params: Dictionary<String, Any>?)
    
}
