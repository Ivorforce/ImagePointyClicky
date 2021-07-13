//
//  PointCollection.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 13.07.21.
//

import Foundation

class PointCollection: ObservableObject {
	@Published var points: [(UUID, CGPoint)] = []
	
	init(points: [(UUID, CGPoint)] = []) {
		self.points = points
	}
	
	convenience init(points: [CGPoint]) {
		self.init(points: points.map { (UUID(), $0) })
	}
}
