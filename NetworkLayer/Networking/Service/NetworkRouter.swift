//
//  NetworkRouter.swift
//  NetworkLayer
//
//  Created by Yung Dai on 2019-06-19.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

public typealias NetworkRouterResultCompletion = (_ result: Result<Data?, Error>, _ response: URLResponse?) -> ()

protocol NetworkRouter: class {
	
	associatedtype EndPoint: EndPointType
	
	func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
	func request(_ route: EndPoint, completion: @escaping NetworkRouterResultCompletion)
	func cancel()
}
