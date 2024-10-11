//
//  Extensions.swift
//  FetchTakeHome
//
//  Created by Christian Grise on 10/14/24.
//

import Foundation

extension String: @retroactive Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
