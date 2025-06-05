//
//  SwiftFramesTests.swift
//  SwiftFrames
//
//  Created by Tyler Maxwell on 6/4/25.
//

import Foundation
import Testing
@testable import SwiftFrames

@Suite("SwiftFrames Tests")
struct SwiftFramesTests {
    @Test("Load from local CSV file")
    func testFromLocalURL() async throws {
        let tempURL = FileManager.default.temporaryDirectory.appending(path: "test.csv")
        let csv = "col1,col2\nA,1\nB,2"
        try csv.write(to: tempURL, atomically: true, encoding: .utf8)
        
        let df = try await SwiftFrames.readCSV(url: tempURL)
        
        #expect(df.shape.rows == 2)
        #expect(df["col2"]?[1] as? Int == 2)
    }
    
    @Test("Load from remote CSV file")
    func testFromRemoteURL() async throws {
        guard let url = URL(string: "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv") else {
            #expect(Bool(false), "Bad URL")
            return
        }
        
        let df = try await SwiftFrames.readCSV(url: url)
        
        #expect(df.columns.contains("Name"))
        #expect(df.shape.rows > 0)
    }
}
