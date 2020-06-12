//
//  Greeting.swift
//  
//
//  Created by Michał A on 2020/6/11.
//

import protocol Foundation.LocalizedError

public enum GreetingError: Error {
    case invalidHour(Int)
}

extension GreetingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidHour(let hour):
            return "Invalid hour: \(hour)"
        }
    }
}

public enum Greeting: String, Encodable {
    case morning = "Good morning"
    case afternoon = "Good afternoon"
    case evening = "Good evening"
    case night = "Good night"
    case `default` = "Good day"
}

public func greeting(atHour hour: Int) throws -> Greeting {
    switch hour {
    case 0..<6:
        return .night
    case 6..<12:
        return .morning
    case 12..<18:
        return .afternoon
    case 18..<24:
        return .evening
    default:
        throw GreetingError.invalidHour(hour)
    }
}
