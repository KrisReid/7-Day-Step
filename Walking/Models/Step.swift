//
//  Step.swift
//  Walking
//
//  Created by Kris Reid on 24/11/2020.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
