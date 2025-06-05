// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct SwiftFrames {
    /// Asynchronously reads a CSV file from a local or remote URL and parses it into a `DataFrame`.
    ///
    /// This function automatically detects whether the URL is local (e.g., file://) or remote (e.g., http:// or https://)
    /// and handles downloading or reading the file accordingly.
    ///
    /// The CSV is expected to have a header row as the first line, and rows of comma-separated values following it.
    /// Each value will be automatically inferred as one of the following Swift types, in this order:
    /// - `Bool` (if the string is "true" or "false", case-insensitive)
    /// - `Int`
    /// - `Double`
    /// - `String` (fallback if no other match)
    ///
    /// - Parameter url: The `URL` of the CSV file to load. Can be either a local file URL or a remote HTTP(S) URL.
    /// - Returns: A `DataFrame` instance populated with the parsed CSV data.
    /// - Throws: Any `URLError` or file reading error, or a decoding error if the data could not be converted to a string.
    public static func readCSV(url: URL) async throws -> DataFrame {
        let isRemote = url.scheme?.starts(with: "http") ?? false
        
        let csvString: String
        if isRemote {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let string = String(data: data, encoding: .utf8) else {
                throw URLError(.cannotDecodeContentData)
            }
            csvString = string
        } else {
            csvString = try String(contentsOf: url)
        }
        
        return DataFrame(csvString: csvString)
    }
}

/// Attempts to infer the most appropriate Swift type for a given CSV string value.
///
/// The following inference order is used:
/// 1. Empty or whitespace-only string → `nil`
/// 2. Case-insensitive match for "true"/"false" → `Bool`
/// 3. Integer representation → `Int`
/// 4. Floating-point representation → `Double`
/// 5. All others → `String`
///
/// - Parameter string: The raw string value from the CSV.
/// - Returns: A strongly typed Swift value, or `nil` for blank cells.
internal func inferValueType(_ string: String) -> Any? {
    let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmed.isEmpty { return nil }

    if let bool = Bool(trimmed.lowercased()) { return bool }
    if let int = Int(trimmed) { return int }
    if let double = Double(trimmed) { return double }
    return trimmed
}
