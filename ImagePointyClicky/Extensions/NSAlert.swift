//
//  Alerts.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 13.07.21.
//

import Cocoa

extension NSAlert {
	static func informational(title: String, text: String, confirm: String? = nil) {
		let alert = NSAlert()
		alert.messageText = title
		alert.informativeText = text
		alert.alertStyle = .informational
		alert.runModal()
	}

	static func warning(title: String, text: String, confirm: String? = nil) {
		let alert = NSAlert()
		alert.messageText = title
		alert.informativeText = text
		alert.alertStyle = .warning
		alert.runModal()
	}
}
