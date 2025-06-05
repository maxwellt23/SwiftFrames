//
//  main.swift
//  SwiftFrames
//
//  Created by Tyler Maxwell on 6/4/25.
//

import Foundation
import SwiftFrames

struct SwiftFramesDemo {
    init() {
        run()
    }
    
    func run() {
        // MARK: - 1. Init from Array of Dictionaries
        
        let peopleDicts: [[String: Any?]] = [
            ["name": "Alice", "age": 30],
            ["name": "Bob", "age": 25],
            ["name": "Charlie", "age": 40]
        ]
        
        let dfFromDicts = DataFrame(rows: peopleDicts)
        print("DataFrame from array of dictionaries:\n\(dfFromDicts)\n")
        
        // MARK: - 2. Init from Array of Arrays + Column Names
        
        let dfFromArrays = DataFrame(columns: ["name", "age"], rows: [
            ["Alice", 30],
            ["Bob", 25],
            ["Charlie", 40]
        ])
        
        print("DataFrame from array of arrays:\n\(dfFromArrays)\n")
        
        // MARK: - 3. Subscript Access
        
        let secondPerson = dfFromDicts[1]
        let agesColumn = dfFromDicts["age"]
        
        print("Subscript row 1: \(secondPerson)")
        print("Subscript 'age' column: \(agesColumn ?? [])\n")
        
        // MARK: - 4. .head()
        
        let headRows = dfFromDicts.head(2)
        print("Head (2 rows):")
        for row in headRows {
            print(row)
        }
        print()
        
        // MARK: - 5. .tail()
        
        let tailRows = dfFromDicts.tail(2)
        print("Tail (2 rows):")
        for row in tailRows {
            print(row)
        }
        print()
        
        // MARK: - 6. .shape
        
        let shape = dfFromDicts.shape
        print("Shape: \(shape.rows) rows x \(shape.columns) columns\n")
        
        // MARK: - 7. Init from CSV String
        
        let rawCSV = """
        city,population
        London,9000000
        Paris,2148000
        Rome,2873000
        """
        let dfFromCSVString = DataFrame(csvString: rawCSV)
        print("DataFrame from CSV string:\n\(dfFromCSVString)\n")
        
        // MARK: - 8. Convert to CSV
        
        let csvOutput = dfFromCSVString.toCSV()
        print("Exported CSV:\n\(csvOutput)\n")
        
        // MARK: - 9. Load from Local File
        
        Task {
            do {
                let tempURL = FileManager.default.temporaryDirectory.appending(path: "demo.csv")
                try csvOutput.write(to: tempURL, atomically: true, encoding: .utf8)
                let localDF = try await SwiftFrames.readCSV(url: tempURL)
                
                print("DataFrame from local CSV file:\n\(localDF)\n")
            } catch {
                print("Error reading local CSV file: \(error)\n")
            }
        }
        
        // MARK: - 10. Load from Remote CSV File
        
        Task {
            do {
                let remoteURL = URL(string: "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv")!
                let remoteDF = try await SwiftFrames.readCSV(url: remoteURL)
                
                print("DataFrame from remote CSV file:\n\(remoteDF.head(3))\n")
            } catch {
                print("Error fetching remote CSV: \(error)\n")
            }
        }
        
        // MARK: - 11. Save to Disk as CSV File
        
        do {
            let outputPath = FileManager.default.temporaryDirectory.appending(path: "output.csv")
            try dfFromCSVString.toCSV(url: outputPath)
            
            let saved = try String(contentsOf: outputPath)
            print("Saved CSV file contents:\n\(saved)\n")
        } catch {
            print("Error writing CSV to file: \(error)\n")
        }
    }
}

let _ = SwiftFramesDemo()
