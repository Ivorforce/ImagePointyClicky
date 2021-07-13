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
	var pointSize: CGFloat = 5
	var color: Color = Color.red
	@ObservedObject var collection: PointCollection
	
    var body: some View {
		GeometryReader { geo in
			ClickPosition { point in
				let point = CGPoint(x: point.x / geo.size.width, y: point.y / geo.size.height)
				
				if NSEvent.modifierFlags.contains(.command) {
					guard let (id, _) = collection.points.min(by: {
						CGPoint.distSQ($0.1, point) < CGPoint.distSQ($1.1, point)
					}) else {
						return
					}
					
					collection.points.removeAll { $0.0 == id }
					
					return
				}
				
				collection.points.append((UUID(), point))
			}
			
			ForEach(collection.points, id: \.0) { (id, point) in
				Circle().fill(color)
					.frame(width: pointSize, height: pointSize)
					.position(x: geo.size.width * point.x, y: geo.size.height * point.y)
			}
		}
    }
}

struct PointyClickyView_Previews: PreviewProvider {
    static var previews: some View {
        PointyClickyView(collection: PointCollection())
    }
}
