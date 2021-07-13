//
//  ContentView.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 13.07.21.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ImagePointyClickyDocument
	@State var image: NSImage?
	@State var pointSize: CGFloat = 4
	@State var color: Color = Color(red: 0.2, green: 0.5, blue: 0.8)
	
	func selectImage() {
		let folderChooserPoint = CGPoint(x: 0, y: 0)
		let folderChooserSize = CGSize(width: 500, height: 600)
		let folderChooserRectangle = CGRect(origin: folderChooserPoint, size: folderChooserSize)
		let panel = NSOpenPanel(contentRect: folderChooserRectangle, styleMask: .utilityWindow, backing: .buffered, defer: true)

		panel.canChooseDirectories = false
		panel.allowsMultipleSelection = false
		panel.canChooseFiles = true
		panel.canDownloadUbiquitousContents = true

		panel.begin { response in
			guard response == .OK else {
				return
			}
			
			guard
				let url = panel.url,
				let image = NSImage(contentsOf: url)
			else {
				NSAlert.warning(title: "Invalid File", text: "Failed to load image from file.")
				return
			}
			
			self.image = image
		}
	}
	
    var body: some View {
		VStack {
			HStack {
				Image(systemName: "info.circle")
					.onHover {
						if $0 {
							NSCursor.pointingHand.push()
						} else {
							NSCursor.pop()
						}
					}
					.help("Click to add points. Hold Command and click to remove the nearest point.")
				
				Button("Select Image") {
					selectImage()
				}
				
				HStack {
					Text("Size")
					Slider(value: $pointSize, in: 1...8)
				}.padding(.horizontal)
				
				ColorPicker("Color", selection: $color)
			}.padding()
			
			ZStack {
				Rectangle().fill(Color.white)
				
				if let image = image {
					Image(nsImage: image)
						.resizable()
				}
				
				PointyClickyView(pointSize: pow(2, pointSize), color: color, collection: document.collection)
			}.frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(ImagePointyClickyDocument()))
    }
}
