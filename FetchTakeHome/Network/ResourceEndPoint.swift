//
//  ResourceEndPoint.swift
//  AndysWay
//
//  Created by Christian Grise on 10/2/24.
//

import Foundation

//Create a protocol representing a REST end point and all possible functions

enum HTTPMethod: String {
    case GET, POST, PUT
}

protocol ResourceEndPoint {
    associatedtype Response: Decodable
    
    var path: String { get }
    var availableHTTPMethods: [HTTPMethod] { get }
    
    func GET(completion: @escaping (Result<Response, Error>) -> Void)
    func POST(completion: @escaping (Result<Response, Error>) -> Void)
    func PUT(completion: @escaping (Result<Response, Error>) -> Void)
}

extension ResourceEndPoint {
    func GET(completion: @escaping (Result<Response, Error>) -> Void) {
        print("Default GET implementation")
    }
    
    func POST(completion: @escaping (Result<Response, Error>) -> Void) {
        print("Default POST implementation")
    }
    
    func PUT(completion: @escaping (Result<Response, Error>) -> Void) {
        print("Default PUT implementation")
    }
}
