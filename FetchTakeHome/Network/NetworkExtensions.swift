//
//  NetworkExtensions.swift
//  FetchTakeHome
//
//  Created by Christian Grise on 10/10/24.
//
import Foundation

public enum FTHError: Error {
    case invalidURL
    case invalidResponse
}

extension FTHError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "FTHError_InvalidURL")
        case .invalidResponse:
            return NSLocalizedString("Invalid Response", comment: "FTHError_InvalidResponse")
        }
    }
    
    public var localizedDescription: String? {
        return errorDescription
    }
}
