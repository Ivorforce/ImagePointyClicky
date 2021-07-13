//
//  ImagePointyClickyDocument.swift
//  ImagePointyClicky
//
//  Created by Lukas Tenbrink on 13.07.21.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "de.ivorius.pointlist")
    }
}

struct ImagePointyClickyDocument: FileDocument {
	static let regex = try! NSRegularExpression(pattern: #"\d+ \((.+), (.+)\)"#)

    let collection: PointCollection

	init(collection: PointCollection = PointCollection()) {
        self.collection = collection
    }

    static var readableContentTypes: [UTType] { [.exampleText] }

    init(configuration: ReadConfiguration) throws {
        guard
			let data = configuration.file.regularFileContents,
			let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
		
		let lines = string.split(whereSeparator: \.isNewline)
			.map({ $0.trimmingCharacters(in: .whitespaces) })
			.filter({ !$0.isEmpty })
		let points: [CGPoint] = try lines.map { (string: String) in
			let match = try Self.regex
				.firstMatch(in: string, options: .anchored, range: string.fullRange)
				.unwrap(orThrow: CocoaError(.fileReadCorruptFile))
			
			let parts = try (1...2).map {
				CGFloat(
					try Float(string[Range(match.range(at: $0), in: string)!])
						.unwrap(orThrow: CocoaError(.fileReadCorruptFile))
				)
			}
			
			return CGPoint(x: parts[0], y: parts[1])
		}
		
		self.init(collection: PointCollection(points: points))
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		let text = collection.points.enumerated().map { (idx, pair) in
			return "\(idx) (\(pair.1.x), \(pair.1.y))"
		}.joined(separator: "\n")
		
		let data = text.data(using: .utf8)!
		return .init(regularFileWithContents: data)
    }
}
