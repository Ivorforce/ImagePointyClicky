//
//  PointCollection.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 13.07.21.
//

import Foundation

class ImagePoint: Identifiable, ObservableObject {
	@Published var id = UUID()

	@Published var position: CGPoint
	@Published var title: String = "Test"
	
	init(position: CGPoint, title: String = "") {
		self.position = position
		self.title = title
	}
}

class PointCollection: ObservableObject {
	@Published var points: [ImagePoint] = []
	
	init(points: [ImagePoint] = []) {
		self.points = points
	}
}
