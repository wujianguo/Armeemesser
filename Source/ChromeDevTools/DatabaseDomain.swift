//
//  DatabaseDomain.swift
//  Armeemesser
//
//  Created by Jianguo Wu on 2018/5/16.
//  Copyright © 2018年 wujianguo. All rights reserved.
//

import Foundation

open class DataBaseDomain: Domain {
    
    var name: String = "DataBase"
    
    var handler: DomainHandler
    
    var enable: Bool = true
    
    required public init(handler: DomainHandler) {
        self.handler = handler
    }
    
    func handle(enable: Bool) {
        self.enable = enable
    }
    
    func handle(id: Int, method: String, params: Dictionary<String, Any>?) {
        
    }
    
    func handleExecute(sql: String, id: Int) {
        
    }
    
    func handleGetDatabaseTableNames(id: Int) {
        
    }

    open func addDatabase(id: String, domain: String, name: String, version: String) {
        let params = [
            "id": id,
            "domain": domain,
            "name": name,
            "version": version,
        ]
        handler.send(method: "DataBase.addDatabase", params: ["database": params])
    }
}
