//
//  PointTextView.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 15.07.21.
//

import SwiftUI

struct PointTextView: View {
	@ObservedObject var point: ImagePoint

    var body: some View {
		TextField("", text: $point.title)
			.lineLimit(1)
			.frame(width: 50)
			.textFieldStyle(PlainTextFieldStyle())
    }
}

//struct PointTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        PointTextView()
//    }
//}
