//
//  ImagePointyClickyApp.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 13.07.21.
//

import SwiftUI

@main
struct ImagePointyClickyApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ImagePointyClickyDocument()) { file in
            ContentView(document: file.$document)
		}
    }
}
