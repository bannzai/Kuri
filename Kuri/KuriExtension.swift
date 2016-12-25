//
//  KuriExtension.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/22.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

protocol Enumerable {
    associatedtype Element = Self
}

extension Enumerable where Element: RawRepresentable, Element.RawValue == Int {
    static var enumerate: AnySequence<Element> {
        return AnySequence { () -> AnyIterator<Element> in
            var i = 0
            return AnyIterator { () -> Element? in
                let element = Element(rawValue: i)
                i += 1
                return element
            }
        }
    }
    static var elements: [Element] {
        return Array(enumerate)
    }
}

extension String {
    var hasAny: Bool {
        return !isEmpty
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
    
    var second: Element? {
        return self[safe: 1]
    }
}
