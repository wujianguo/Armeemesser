#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import tornado.web
import tornado.websocket

class MainHandler(tornado.web.RequestHandler):
    
    def get(self):
        self.write("Hello, world")

class DeviceAdaptor:
    
    def write_message(self, message):
        pass

    def close(self):
        pass

class DeviceManager:
    
    def __init__(self):
        self.devices = {}
        self.chromes = {}

    def add(self, device_id, device):
        self.devices[device_id] = device

    def remove(self, device_id):
        del self.devices[device_id]

    def get(self, device_id):
        return self.devices[device_id]

    def add_chrome(self, device_id, chrome):
        self.chromes[device_id] = chrome

    def remove_chrome(self, device_id):
        del self.chromes[device_id]

    def get_chrome(self, device_id):
        return self.chromes.get(device_id, DeviceAdaptor())

deviceManager = DeviceManager()

class DeviceWebSocket(tornado.websocket.WebSocketHandler):
    
    def check_origin(self, origin):
        return True

    @property
    def chrome(self):
        return deviceManager.get_chrome(self.device_id)

    def open(self, device_id):
        self.device_id = device_id
        deviceManager.add(device_id, self)

    def on_message(self, message):
        # print(message)
        self.chrome.write_message(message)

    def on_close(self):
        deviceManager.remove(self.device_id)
        deviceManager.get_chrome(self.device_id).close()

class ChromeWebSocket(tornado.websocket.WebSocketHandler):
    
    def check_origin(self, origin):
        return True

    @property
    def device(self):
        return deviceManager.get(self.device_id)

    def open(self, page):
        deviceManager.get_chrome(page).close()
        self.device_id = page
        deviceManager.add_chrome(page, self)

    def on_message(self, message):
        # print(message)
        self.device.write_message(message)

    def on_close(self):
        deviceManager.remove_chrome(self.device_id)

class EchoWebSocket(tornado.websocket.WebSocketHandler):
    
    def check_origin(self, origin):
        return True

    def open(self):
        print("WebSocket opened")

    def on_message(self, message):
        self.write_message(u"You said: " + message)

    def on_close(self):
        print("WebSocket closed")


def make_app():
    settings = {
        "debug": True
    }
    return tornado.web.Application([
        (r"/", MainHandler),
        (r"/echo", EchoWebSocket),
        (r"/device/(.*)", DeviceWebSocket),
        (r"/devtools/page/(.*)", ChromeWebSocket),
    ], **settings)

def main():
    app = make_app()
    app.listen(8888, address="0.0.0.0")
    tornado.ioloop.IOLoop.current().start()

if __name__ == '__main__':
    main()