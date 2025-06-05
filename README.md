# 📊 SwiftFrames

A lightweight, Pandas-inspired `DataFrame` implementation for Swift.  
Easily read, explore, and manipulate structured tabular data—whether it's from CSV files, URLs, or Swift-native arrays.

---

## ✨ Features

### ✅ Phase 1
- Load CSV from **local or remote** file
- Create `DataFrame` from:
  - Array of Dictionaries (`[[String: Any?]]`)
  - Array of Arrays with column names
- Access:
  - Rows via `df[0]`
  - Columns via `df["columnName"]`
- CSV Export
  - `toCSV()` returns CSV `String`
  - `toCSV(url:)` writes CSV to disk
- Metadata:
  - `.shape` returns (rows, columns)
  - `.head(n)` and `.tail(n)` preview data
- Pretty console printing like pandas

### ✅ Phase 2
- `.filter(_:)` – filter rows by condition
- `.mapColumn(_:transform:)` – modify values in a column
- `.select([columns])` – create new `DataFrame` with specific columns
- `.dropna()` – remove rows with any `nil`
- `.fillna(value:)` – fill missing values with a default
  
---

## 📦 Installation

Using Swift Package Manager:

```swift
dependencies: [
  .package(url: "https://github.com/maxwellt23/SwiftFrames.git", from: "1.0.0")
]
```

Import it in your Swift code:

```swift
import SwiftFrames
```

---

## 🚀 Usage

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

Inspect and access

```swift
print(df)              // Formatted DataFrame
print(df.shape)        // (2, 2)
print(df.head(2))      // First 2 rows
print(df["name"])      // Column values
```

Modify

```swift
let filtered = df.filter { $0["score"] as? Int ?? 0 > 90 }
var updated = df
updated.mapColumn("score") { ($0 as? Int).map { $0 + 5 } }
```

Clean missing data

```swift
let clean = df.dropna()
let filled = df.fillna("Unknown")
```

Export

```swift
try df.toCSV(url: someLocalFileURL)
```

---

## 🛣️ Roadmap

Phase 3 (Upcoming)
- GroupBy & aggregation
- Sorting
- Type-safe column access improvements
- JSON import/export
- DataFrame merging & joins
  
---

## 📘 License

<a href="LICENSE.md">MIT License</a>

---

## 👋 Contributing

Want to help expand the API, improve type inference, or add DataFrame visualizations? Contributions are welcome!

---

## 📬 Contact

Tyler Maxwell – <a href="https://github.com/maxwellt23">GitHub</a>
