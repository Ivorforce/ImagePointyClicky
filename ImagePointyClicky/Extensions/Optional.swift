//
//  Optional.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 13.07.21.
//

import Foundation

extension Optional {
	func unwrap(orThrow error: @autoclosure () -> Error) throws -> Wrapped {
		switch self {
		case .some(let w): return w
		case .none: throw error()
		}
	}
}
