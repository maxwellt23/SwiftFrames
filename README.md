# 📊 SwiftFrames

A lightweight, Pandas-inspired `DataFrame` implementation for Swift.  
Easily read, explore, and manipulate structured tabular data—whether it's from CSV files, URLs, or Swift-native arrays.

---

## 🚀 Features

- Load CSV data from **local files** or **remote URLs**
- Initialize from:
  - Arrays of dictionaries (`[[String: Any?]]`)
  - Arrays of arrays + column names
  - Raw CSV string
- Automatic type inference (`Bool`, `Int`, `Double`, `String`)
- Clean row and column access:
  - `df[0]` → row as dictionary
  - `df["age"]` → array of values in column
  - `df.column(named: "score", as: Int.self)`
- Print nicely formatted tables (like Python’s `pandas.DataFrame`)
- `.shape`, `.head()`, `.tail()` inspection methods
- Export data to CSV string or file
- Handles missing values gracefully (`nil`)
- Fully tested using Swift's new native testing framework
- Includes a sample playground

---

## 📦 Installation

Add to your `Package.swift`:

```swift
.package(url: "https://github.com/your-username/SwiftFrames.git", from: "1.0.0")
```

And include the dependency:

```swift
.target(name: "MyApp", dependencies: ["SwiftFrames"])
```

---

## 🧪 Getting Started

Import the library:

```swift
import SwiftFrames
```

Load from CSV (local or remote)

```swift
let url = URL(string: "https://example.com/data.csv")!
let df = try await SwiftFrames.readCSV(url: url)
print(df)
```

Create from array of dictionaries

```swift
let df = DataFrame(rows: [
    ["name": "Alice", "score": 95],
    ["name": "Bob", "score": 82],
])
print(df.head())
```

Create from arrays and columns

```swift
let df = DataFrame(
    columns: ["name", "age"],
    rows: [
        ["Alice", 30],
        ["Bob",   25]
    ]
)
```

Inspect the data

```swift
print(df.shape)        // (2, 2)
print(df.head(1))      // First row
print(df["name"])      // Optional array of names
```

Export to CSV

```swift
let csvString = df.toCSV()
try df.toCSV(url: someLocalFileURL)
```

---

## 📄 Output Example

```
name  | age
-------------
Alice | 30
Bob   | 25
```

---

## 🛠 Under the Hood

- Built with row-major storage for fast access by index
- Uses Swift's Any? for flexible, type-safe representation
- Type inference uses Bool, Int, Double parsing order
- CustomStringConvertible provides clean table display

---

## ✅ Phase 1 Completed Goals

- CSV import/export (local + remote)
- Flexible initialization formats
- Missing value support
- Typed column access
- Fully documented API
- Sample tests and playground demo

---

## 📘 License

<a href="LICENSE.md">MIT License</a>

---

## 👋 Contributing

Want to help add filtering, sorting, grouping, or more Pandas-style APIs?
Issues and PRs are welcome!

---

## 🤝 Credits

Created by <a href="https://github.com/maxwellt23">Tyler Maxwell</a>
