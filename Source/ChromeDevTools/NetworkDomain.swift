//
//  NetworkDomain.swift
//  Armeemesser
//
//  Created by Jianguo Wu on 2018/5/16.
//  Copyright © 2018年 wujianguo. All rights reserved.
//

import Foundation

/// Unique loader identifier.
typealias LoaderId = String

/// Unique request identifier.
typealias RequestId = String

/// Unique intercepted request identifier.
typealias InterceptionId = String

/// Network level fetch failure reason.
enum ErrorReason {
    case Failed
    case Aborted
    case TimedOut
    case AccessDenied
    case ConnectionClosed
    case ConnectionReset
    case ConnectionRefused
    case ConnectionAborted
    case ConnectionFailed
    case NameNotResolved
    case InternetDisconnected
    case AddressUnreachable
}

/// UTC time in seconds, counted from January 1, 1970.
typealias TimeSinceEpoch = TimeInterval

/// Monotonically increasing time in seconds since an arbitrary point in the past.
typealias MonotonicTime = TimeInterval

/// Request / response headers as keys / values of JSON object.
typealias Headers = Dictionary<String, String>

/// The underlying connection technology that the browser is supposedly using.
enum ConnectionType {
    case none
    case cellular2g
    case cellular3g
    case cellular4g
    case bluetooth
    case ethernet
    case wifi
    case wimax
    case other
}

enum CookieSameSite {
    case Strict
    case Lax
}

/// Timing information for the request.
struct ResourceTiming {
    /// Timing's requestTime is a baseline in seconds, while the other numbers are ticks in milliseconds relatively to this requestTime.
    let requestTime: TimeInterval
    
    /// Started resolving proxy.
    let proxyStart: TimeInterval
    
    /// Finished resolving proxy.
    let proxyEnd: TimeInterval
    
    /// Started DNS address resolve.
    let dnsStart: TimeInterval
    
    /// Finished DNS address resolve.
    let dnsEnd: TimeInterval
    
    /// Started connecting to the remote host.
    let connectStart: TimeInterval
    
    /// Connected to the remote host.
    let connectEnd: TimeInterval
    
    /// Started SSL handshake.
    let sslStart: TimeInterval
    
    /// Finished SSL handshake.
    let sslEnd: TimeInterval
    
    /// Started running ServiceWorker.
    let workerStart: TimeInterval
    
    /// Finished Starting ServiceWorker.
    let workerReady: TimeInterval
    
    /// Started sending request.
    let sendStart: TimeInterval
    
    /// Finished sending request.
    let sendEnd: TimeInterval
    
    /// Time the server started pushing request.
    let pushStart: TimeInterval
    
    /// Time the server finished pushing request.
    let pushEnd: TimeInterval
    
    /// Finished receiving response headers.
    let receiveHeadersEnd: TimeInterval
}

/// Loading priority of a resource request.
enum ResourcePriority {
    case VeryLow
    case Low
    case Medium
    case High
    case VeryHigh
}

/// HTTP request data.
struct Request {
    
    /// Request URL.
    let url: String
    
    /// HTTP request method.
    let method: String
    
    /// HTTP request headers.
    let headers: Headers
    
    /// HTTP POST request data.
    let postData: String?
    
    /// True when the request has POST data. Note that postData might still be omitted when this flag is true when the data is too long.
    let hasPostData: Bool?
    
    /// The mixed content type of the request.
    let mixedContentType: String?
    
    /// Priority of the resource request at the time request is sent.
    let initialPriority: ResourcePriority
    
    /// The referrer policy of the request, as defined in https://www.w3.org/TR/referrer-policy/ unsafe-url, no-referrer-when-downgrade, no-referrer, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin
    let referrerPolicy: String
    
    /// Whether is loaded via link preload.
    let isLinkPreload: Bool?
}

/// Details of a signed certificate timestamp (SCT).
struct SignedCertificateTimestamp {
    
    /// Validation status.
    let status: String
    
    /// Origin.
    let origin: String
    
    /// Log name / description.
    let logDescription: String
    
    /// Log ID.
    let logId: String
    
    /// Issuance date.
    let timestamp: TimeSinceEpoch
    
    /// Hash algorithm.
    let hashAlgorithm: String
    
    /// Signature algorithm.
    let signatureAlgorithm: String
    
    /// Signature data.
    let signatureData: String
}

/// Security details about a request.
struct SecurityDetails {
    
    /// Protocol name (e.g. "TLS 1.2" or "QUIC").
    let `protocol`: String
    
    /// Key Exchange used by the connection, or the empty string if not applicable.
    let keyExchange: String
    
    /// (EC)DH group used by the connection, if applicable.
    let keyExchangeGroup: String?
    
    /// Cipher name.
    let cipher: String
    
    /// TLS MAC. Note that AEAD ciphers do not have separate MACs.
    let mac: String
    
    /// Certificate ID value.
    let certificateId: String
    
    /// Certificate subject name.
    let subjectName: String
    
    /// Subject Alternative Name (SAN) DNS names and IP addresses.
    let sanList: [String]
    
    /// Name of the issuing CA.
    let issuer: String
    
    /// Certificate valid from date.
    let validFrom: TimeSinceEpoch
    
    /// Certificate valid to (expiration) date
    let validTo: TimeSinceEpoch
}

/// The reason why request was blocked.
enum BlockedReason {
    case other
    case csp
    case mixed_content
    case origin
    case inspector
    case subresource_filter
    case content_type
}

/// HTTP response data.
struct Response {
    
    /// Response URL. This URL can be different from CachedResource.url in case of redirect.
    let url: String
    
    /// HTTP response status code.
    let status: Int
    
    /// HTTP response status text.
    let statusText: String
    
    /// HTTP response headers.
    let headers: Headers
    
    /// HTTP response headers text.
    let headersText: String?
    
    /// Resource mimeType as determined by the browser.
    let mimeType: String
    
    /// Refined HTTP request headers that were actually transmitted over the network.
    let requestHeaders: Headers?
    
    /// HTTP request headers text.
    let requestHeadersText: String?
    
    /// Specifies whether physical connection was actually reused for this request.
    let connectionReused: Bool
    
    /// Physical connection id that was actually used for this request.
    let connectionId: Int
    
    /// Remote IP address.
    let remoteIPAddress: String?
    
    /// Remote port.
    let remotePort: Int?
    
    /// Specifies that the request was served from the disk cache.
    let fromDiskCache: Bool?
    
    /// Specifies that the request was served from the ServiceWorker.
    let fromServiceWorker: Bool?
    
    /// Total number of bytes received for this request so far.
    let encodedDataLength: UInt64
    
    /// Timing information for the given request.
    let timing: ResourceTiming?
    
    /// Protocol used to fetch this request.
    let `protocol`: String?
    
    /// Security state of the request resource.
    let securityState: String
    
    /// Security details for the request.
    let securityDetails: String?
}

/// WebSocket request data.
struct WebSocketRequest {
    
    /// HTTP request headers.
    let headers: Headers
}

/// WebSocket response data.
struct WebSocketResponse {
    
    /// HTTP response status code.
    let status: Int
    
    /// HTTP response status text.
    let statusText: String
    
    /// HTTP response headers.
    let headers: Headers
    
    /// HTTP response headers text.
    let headersText: String?
    
    /// HTTP request headers.
    let requestHeaders: Headers?
    
    /// HTTP request headers text.
    let requestHeadersText: String?
}

/// WebSocket frame data.
struct WebSocketFrame {
    
    /// WebSocket frame opcode.
    let opcode: Int
    
    /// WebSocke frame mask.
    let mask: Bool
    
    /// WebSocke frame payload data.
    let payloadData: String
}


enum NetworkMethod {
    
    /// Clears browser cache.
    case clearBrowserCache
    
    /// Clears browser cookies.
    case clearBrowserCookies
    
    /// Deletes browser cookies with matching name and url or domain/path pair.
    case deleteCookies
}


open class NetworkDomain: Domain {
    
    var name: String = "Network"
    
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
