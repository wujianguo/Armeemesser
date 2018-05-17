//
//  LogDomain.swift
//  Armeemesser
//
//  Created by Jianguo Wu on 2018/5/16.
//  Copyright © 2018年 wujianguo. All rights reserved.
//

import Foundation

public enum LogLevel {
    case verbose
    case info
    case warning
    case error
}

open class LogDomain: Domain {
    
    var name: String = "Log"
    
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
    
    open func verbose(text: String, file: String? = nil, lineNumber: Int? = nil) {
        log(text: text, level: .verbose, file: file, lineNumber: lineNumber)
    }
    
    open func info(text: String, file: String? = nil, lineNumber: Int? = nil) {
        log(text: text, level: .info, file: file, lineNumber: lineNumber)
    }
    
    open func warning(text: String, file: String? = nil, lineNumber: Int? = nil) {
        log(text: text, level: .warning, file: file, lineNumber: lineNumber)
    }
    
    open func error(text: String, file: String? = nil, lineNumber: Int? = nil) {
        log(text: text, level: .error, file: file, lineNumber: lineNumber)
    }
    
    open func log(text: String, level: LogLevel, file: String? = nil, lineNumber: Int? = nil) {
        guard enable else {
            return
        }
        let params = [
            "source": "network",
            "level": "\(level)",
            "text": text,
            "timestamp": Date(timeIntervalSinceNow: 0).timeIntervalSince1970 * 1000
            ] as [String : Any]
        handler.send(method: "Log.entryAdded", params: ["entry": params])
    }
    
}
