//
//  PointyClickyView.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 13.07.21.
//

import SwiftUI

extension CGPoint {
	static func distSQ(_ left: CGPoint, _ right: CGPoint) -> CGFloat {
		pow(left.x - right.x, 2) + pow(left.y - right.y, 2)
	}
}

struct PointyClickyView: View {
	@ObservedObject var collection: PointCollection

	var pointSize: CGFloat = 5
	var color: Color = Color.red
	var showTitles: Bool = true
	
    var body: some View {
		GeometryReader { geo in
			ClickPosition { point in
				let point = CGPoint(x: point.x / geo.size.width, y: point.y / geo.size.height)
				
				if NSEvent.modifierFlags.contains(.command) {
					guard let point = collection.points.min(by: {
						CGPoint.distSQ($0.position, point) < CGPoint.distSQ($1.position, point)
					}) else {
						return
					}
					
					collection.points.removeAll { $0.id == point.id }
					
					return
				}
				
				collection.points.append(.init(position: point))
			}
			
			ForEach(collection.points, id: \.id) { point in
				Circle().fill(color)
					.frame(width: pointSize, height: pointSize)
					.position(x: geo.size.width * point.position.x, y: geo.size.height * point.position.y)
			}

			if showTitles {
				ForEach(collection.points, id: \.id) { point in
					PointTextView(point: point)
						.position(x: geo.size.width * point.position.x, y: geo.size.height * point.position.y)
				}
					.multilineTextAlignment(.center)
			}
		}
    }
}

struct PointyClickyView_Previews: PreviewProvider {
    static var previews: some View {
        PointyClickyView(collection: PointCollection())
    }
}
