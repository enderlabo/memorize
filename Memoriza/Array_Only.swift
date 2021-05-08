//
//  Array_Only.swift
//  Memoriza
//
//  Created by Laborit on 28/03/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}
