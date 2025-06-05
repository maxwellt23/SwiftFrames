//
//  DataFrameTests.swift
//  SwiftFrames
//
//  Created by Tyler Maxwell on 6/4/25.
//

import Foundation
import Testing
@testable import SwiftFrames

@Suite("DataFrame Tests")
struct DataFrameTests {
    @Test("Init from array of dictionaries")
    func testInitFromArrayOfDicts() {
        let rows: [[String: Any?]] = [
            ["name": "Alice", "age": 30],
            ["name": "Bob", "age": 25]
        ]
        let df = DataFrame(rows: rows)
        
        #expect(df.columns.contains("name"))
        #expect(df.columns.contains("age"))
        #expect(df.shape.rows == 2)
        #expect(df.shape.columns == 2)
        #expect(df["age"]?[1] as? Int == 25)
    }
    
    @Test("Init from array of arrays + columns")
    func testInitFromArrayOfArrays() {
        let df = DataFrame(columns: ["name", "age"], rows: [
            ["Alice", 30],
            ["Bob", 25]
        ])
        
        #expect(df.shape.rows == 2)
        #expect(df.shape.columns == 2)
        #expect(df["name"]?[0] as? String == "Alice")
    }
    
    @Test("Subscript access by row and column")
    func testSubscriptAccess() {
        let df = DataFrame(columns: ["x", "y"], rows: [
            [1, 2],
            [3, 4]
        ])
        
        let row0 = df[0]
        #expect(row0["x"] as? Int == 1)
        #expect(df["y"]?[1] as? Int == 4)
    }
    
    @Test("head() returns first n rows as dictionaries")
    func testHead() {
        let df = DataFrame(columns: ["a"], rows: (0..<10).map { [$0] })
        let head = df.head(3)
        
        #expect(head.count == 3)
        #expect(head[0]["a"] as? Int == 0)
        #expect(head[2]["a"] as? Int == 2)
    }
    
    @Test("tail() returns last n rows as dictionaries")
    func testTail() {
        let df = DataFrame(columns: ["a"], rows: (0..<10).map { [$0] })
        let tail = df.tail(3)
        
        #expect(tail.count == 3)
        #expect(tail[0]["a"] as? Int == 7)
        #expect(tail[2]["a"] as? Int == 9)
    }
    
    @Test("shape returns correct row and column counts")
    func testShape() {
        let df = DataFrame(columns: ["x", "y"], rows: [
            [1, 2],
            [3, 4],
            [5, 6]
        ])
        
        #expect(df.shape.rows == 3)
        #expect(df.shape.columns == 2)
    }
    
    @Test("Init from CSV string")
    func testInitFromCSVString() {
        let csv = "name,age\nAlice,30\nBob,25"
        let df = DataFrame(csvString: csv)
        
        #expect(df.shape.rows == 2)
        #expect(df["age"]?[1] as? Int == 25)
        #expect(df["name"]?[0] as? String == "Alice")
    }
    
    @Test("Export to CSV string")
    func testToCSV() {
        let df = DataFrame(columns: ["x", "y"], rows: [
            [1, 2],
            [3, 4]
        ])
        
        let csv = df.toCSV()
        #expect(csv.contains("x,y"))
        #expect(csv.contains("1,2"))
        #expect(csv.contains("3,4"))
    }
    
    @Test("Write CSV file to disk")
    func testWriteCSVToDisk() throws {
        let df = DataFrame(columns: ["a", "b"], rows: [
            [1, 2],
            [3, 4]
        ])
        
        let fileURL = FileManager.default.temporaryDirectory.appending(path: "output.csv")
        try df.toCSV(url: fileURL)
        
        let result = try String(contentsOf: fileURL)
        #expect(result.contains("a,b"))
        #expect(result.contains("1,2"))
    }
    
    @Test("Pretty print format")
    func testPrintFormat() {
        let df = DataFrame(columns: ["name", "age"], rows: [
            ["Alice", 30],
            ["Bob", 25]
        ])
        
        let output = String(describing: df)
        #expect(output.contains("name"))
        #expect(output.contains("Alice"))
        #expect(output.contains("Bob"))
    }
    
    @Test("Typed Column Access")
    func testTypedColumnAccess() {
        let csv = """
        name,age,score,active
        Alice,30,91.5,true
        Bob,25,88.0,false
        Charlie,,72.5,false
        """
        
        let df = DataFrame(csvString: csv)
        
        let names = df.column(named: "name", as: String.self)
    }
}
