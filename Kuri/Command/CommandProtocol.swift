//
//  CommandProtocol.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/22.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

protocol CommandProtocol {
    var options: [String] { get }
    func execute() throws
}
