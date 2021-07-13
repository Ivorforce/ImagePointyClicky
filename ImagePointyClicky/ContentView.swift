//
//  ContentView.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 13.07.21.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ImagePointyClickyDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(ImagePointyClickyDocument()))
    }
}
