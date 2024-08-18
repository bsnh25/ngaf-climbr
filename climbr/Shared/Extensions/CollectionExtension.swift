//
//  CollectionExtension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 10/08/24.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
