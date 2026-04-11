//
//  Route.swift
//  group69
//
//  Primary author: Sokmontrey Sythat (101477705)
//
//  Other editors:
//  - Jonathan Cao (101480537): `Hashable`/`Codable` for `NavigationStack` value paths.
//  - Samuel Browne (101481884): Associated values for detail vs edit flows.
//

import SwiftUI

/// Navigation destinations pushed on the stack; `String` holds `TaskItem.id.uuidString` for `.detail`, optional for `.edit`.
enum Route: Hashable, Codable {
    case detail(String)
    case edit(String?)
}
.
