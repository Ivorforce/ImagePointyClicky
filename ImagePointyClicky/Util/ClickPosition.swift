//
//  HoverPositionView.swift
//  ElevenTunes
//
//  Created by Lukas Tenbrink on 01.01.21.
//

import SwiftUI

public class NSClickPosition: NSView {
	public var onClick:  (CGPoint) -> Void

	public init(onClick: @escaping (CGPoint) -> Void) {
		self.onClick = onClick
		super.init(frame: NSRect())
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func mouseUp(with event: NSEvent) {
		let location = self.convert(event.locationInWindow, from: nil)
		onClick(CGPoint(x: location.x, y: frame.size.height - location.y))
	}
}

public struct ClickPosition: NSViewRepresentable {
	public var onClick:  (CGPoint) -> Void

	public func makeNSView(context: NSViewRepresentableContext<ClickPosition>) -> NSClickPosition {
		NSClickPosition(onClick: onClick)
	}

	public func updateNSView(_ nsView: NSClickPosition, context: NSViewRepresentableContext<ClickPosition>) {
		nsView.onClick = onClick
	}
}

extension View {
	public func onClickLocation(onClick: @escaping (CGPoint) -> Void = {_ in }) -> some View {
		background(ClickPosition(onClick: onClick))
	}
}
