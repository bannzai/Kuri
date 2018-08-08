//
//  YamlReadableType.swift
//  Kuri
//
//  Created by Yudai.Hirose on 2018/08/08.
//

import Foundation
import Yaml

public protocol YamlReadableType {
    static func read(for key: String, from yaml: Yaml) -> Self?
}
extension String: YamlReadableType {
    public static func read(for key: String, from yaml: Yaml) -> String? {
        return yaml[.string(key)].string
    }
}
extension Bool: YamlReadableType {
    public static func read(for key: String, from yaml: Yaml) -> Bool? {
        return yaml[.string(key)].bool
    }
}

