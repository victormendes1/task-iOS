//
//  Extensions.swift
//  Task
//
//  Created by Victor Mendes on 16/08/21.
//

import Foundation

extension Array where Element: Hashable {
    func subtracting(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.subtracting(otherSet))
    }
}
