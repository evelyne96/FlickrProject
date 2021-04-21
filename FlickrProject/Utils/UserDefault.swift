//
//  UserDefault.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 19/04/2021.
//

import Foundation

//https://www.avanderlee.com/swift/property-wrappers/

protocol PropertyListValue {}

struct Key: RawRepresentable {
    let rawValue: String
}

extension Key: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}

extension Key {
    static let searchText: Key = "searchText"
}

@propertyWrapper
struct UserDefault<T: PropertyListValue> {
    let key: Key

    var wrappedValue: T? {
        get { UserDefaults.standard.value(forKey: key.rawValue) as? T }
        set { UserDefaults.standard.set(newValue, forKey: key.rawValue) }
    }
}


extension String: PropertyListValue {}

class UserPrefs {
    static let shared = UserPrefs()
    
    @UserDefault(key: .searchText)
    var searchText: String?
    
    private init() {}
}


