//
//  ChromeDevTools.swift
//  Armeemesser
//
//  Created by Jianguo Wu on 2018/5/16.
//  Copyright © 2018年 wujianguo. All rights reserved.
//

import Foundation

extension WebSocket: DomainHandler {
    
    public func send(method: String, params: Dictionary<String, Any>?) {
        var dict: Dictionary<String, Any> = [:]
        if let params = params {
            dict = ["method": method, "params": params]
        } else {
            dict = ["method": method]
        }
        do {
            let event = try JSONSerialization.data(withJSONObject: dict, options: .sortedKeys)
            write(string: String(data: event, encoding: .utf8)!)
        } catch {
            
        }
    }
    
}


open class ChromeDevTools: WebSocketDelegate {
    
    open static var sharedInstance: ChromeDevTools!
    
    open static func create(host: String, port: Int, deviceId: String) -> (URL, URL) {
        if sharedInstance != nil {
            sharedInstance.disconnect()
        }
        let url = URL(string: "ws://\(host):\(port)/device/\(deviceId)")!
        sharedInstance = ChromeDevTools(url: url)
        sharedInstance.connect()
        return (url, URL(string: "ws://\(host):\(port)/devtools/page/\(deviceId)")!)
    }
    
    let socket: WebSocket

    open let log: LogDomain
    
    
    var domains: [Domain]

    public init(url: URL) {
        socket = WebSocket(url: url)
        log = LogDomain(handler: socket)
        domains = [log]
    }
    
    func connect() {
        socket.delegate = self
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    public func websocketDidConnect(socket: WebSocketClient) {
        
    }
    
    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        
    }
    
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        do {
            let ret = try JSONSerialization.jsonObject(with: text.data(using: .utf8)!, options: .allowFragments)
            if let ret = ret as? Dictionary<String, Any> {
                if let method = ret["method"] as? String {
                    let methods = method.split(separator: ".")
                    guard methods.count == 2 else {
                        return
                    }
                    for domain in domains {
                        if String(methods[0]) == domain.name {
                            let id = ret["id"] as? Int
                            handle(domain: domain, id: id ?? 0, method: String(methods[1]), params: ret["params"] as? Dictionary<String, Any>)
                            return
                        }
                    }
                }
            }
            
        } catch {
            
        }
        print(text)
    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
    
    func handle(domain: Domain, id: Int, method: String, params: Dictionary<String, Any>?) {
        switch method {
        case "enable":
            domain.handle(enable: true)
        case "disable":
            domain.handle(enable: false)
        default:
            domain.handle(id: id, method: method, params: params)
        }
    }
}
