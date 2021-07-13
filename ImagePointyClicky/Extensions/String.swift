//
//  String.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 13.07.21.
//

import Foundation

extension String {
	var fullRange: NSRange {
		NSRange(startIndex..., in: self)
	}
}
