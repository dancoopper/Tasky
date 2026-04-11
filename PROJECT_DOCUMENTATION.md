# Tasky (group69) — Project documentation

**Course / app:** Mobile — SwiftUI task manager  
**Team**

| Name | Student ID |
|------|------------|
| Sokmontrey Sythat | 101477705 |
| Jonathan Cao | 101480537 |
| Samuel Browne | 101481884 |

This document lists the Apple frameworks, APIs, and patterns used in the project, with links to official documentation. It also summarizes how data is structured, read, and written (assignment items 5–7).

---

## 1. Languages and platform

- **Language:** Swift  
  - [Swift.org](https://www.swift.org/)  
  - [Swift language guide (Apple Books)](https://docs.swift.org/swift-book/)
- **Platform:** iOS (SwiftUI lifecycle)  
  - [SwiftUI](https://developer.apple.com/documentation/swiftui)  
  - [Human Interface Guidelines — iOS](https://developer.apple.com/design/human-interface-guidelines/ios)

---

## 2. Frameworks and key APIs (with documentation links)

### SwiftUI (UI layer)

| Topic | Documentation |
|-------|----------------|
| SwiftUI overview | [SwiftUI](https://developer.apple.com/documentation/swiftui) |
| `App` entry point | [`App`](https://developer.apple.com/documentation/swiftui/app) |
| `WindowGroup` | [`WindowGroup`](https://developer.apple.com/documentation/swiftui/windowgroup) |
| `View`, `body` | [`View`](https://developer.apple.com/documentation/swiftui/view) |
| `NavigationStack`, `NavigationPath` | [`NavigationStack`](https://developer.apple.com/documentation/swiftui/navigationstack), [`NavigationPath`](https://developer.apple.com/documentation/swiftui/navigationpath) |
| `navigationDestination(for:)` | [`navigationDestination(for:destination:)`](https://developer.apple.com/documentation/swiftui/view/navigationdestination(for:destination:)) |
| `List`, `Section`, `Form` | [`List`](https://developer.apple.com/documentation/swiftui/list), [`Section`](https://developer.apple.com/documentation/swiftui/section), [`Form`](https://developer.apple.com/documentation/swiftui/form) |
| `sheet(isPresented:)` | [`sheet(isPresented:onDismiss:content:)`](https://developer.apple.com/documentation/swiftui/view/sheet(ispresented:ondismiss:content:)) |
| `toolbar`, `ToolbarItem` | [`toolbar(content:)`](https://developer.apple.com/documentation/swiftui/view/toolbar(content:)-5w0tj) |
| `@State`, `@StateObject` | [`State`](https://developer.apple.com/documentation/swiftui/state), [`StateObject`](https://developer.apple.com/documentation/swiftui/stateobject) |
| `@Environment`, `@EnvironmentObject` | [`Environment`](https://developer.apple.com/documentation/swiftui/environment), [`EnvironmentObject`](https://developer.apple.com/documentation/swiftui/environmentobject) |
| `ObservableObject` (with Combine) | [`ObservableObject`](https://developer.apple.com/documentation/combine/observableobject) |
| `@Published` | [`Published`](https://developer.apple.com/documentation/combine/published) |
| `@AppStorage` | [`AppStorage`](https://developer.apple.com/documentation/swiftui/appstorage) |
| `preferredColorScheme` | [`preferredColorScheme(_:)`](https://developer.apple.com/documentation/swiftui/view/preferredcolorscheme(_:)) |
| `ProgressView` | [`ProgressView`](https://developer.apple.com/documentation/swiftui/progressview) |
| `DatePicker`, `Picker` | [`DatePicker`](https://developer.apple.com/documentation/swiftui/datepicker), [`Picker`](https://developer.apple.com/documentation/swiftui/picker) |
| `Menu` | [`Menu`](https://developer.apple.com/documentation/swiftui/menu) |
| `Label` | [`Label`](https://developer.apple.com/documentation/swiftui/label) |
| `PreviewProvider` | [`PreviewProvider`](https://developer.apple.com/documentation/swiftui/previewprovider) |
| `scenePhase` / lifecycle | [`ScenePhase`](https://developer.apple.com/documentation/swiftui/scenephase), [`onChange(of:perform:)`](https://developer.apple.com/documentation/swiftui/view/onchange(of:perform:)-8wgw9) |

**Files:** `group69App.swift`, `RootView.swift`, `SplashView.swift`, `TaskListView.swift`, `TaskDetailView.swift`, `TaskEditView.swift`, `Route.swift`

---

### Foundation (models, dates, persistence bytes)

| Topic | Documentation |
|-------|----------------|
| `Codable` | [`Codable`](https://developer.apple.com/documentation/swift/codable) |
| `JSONEncoder` / `JSONDecoder` | [`JSONEncoder`](https://developer.apple.com/documentation/foundation/jsonencoder), [`JSONDecoder`](https://developer.apple.com/documentation/foundation/jsondecoder) |
| `Data` | [`Data`](https://developer.apple.com/documentation/foundation/data) |
| `UUID` | [`UUID`](https://developer.apple.com/documentation/foundation/uuid) |
| `Date` | [`Date`](https://developer.apple.com/documentation/foundation/date) |
| `Calendar` | [`Calendar`](https://developer.apple.com/documentation/foundation/calendar) |
| `String` splitting / trimming | [`String`](https://developer.apple.com/documentation/swift/string) |

**Files:** `Taskitem.swift`, `DataStore.swift`, `TaskEditView.swift`, `TaskListView.swift` (date formatting)

---

### File system (reading / writing documents)

| Topic | Documentation |
|-------|----------------|
| `FileManager` | [`FileManager`](https://developer.apple.com/documentation/foundation/filemanager) |
| File URLs (`url(for:in:appropriateFor:create:)`) | [`url(for:in:appropriateFor:create:)`](https://developer.apple.com/documentation/foundation/filemanager/1642990-url) |
| `URL.appendingPathComponent` | [`appendingPathComponent(_:)`](https://developer.apple.com/documentation/foundation/url/appendpathcomponent(_:)) |

**Files:** `DataStore.swift`

---

### UIKit (bridging for share sheet)

| Topic | Documentation |
|-------|----------------|
| `UIApplication` | [`UIApplication`](https://developer.apple.com/documentation/uikit/uiapplication) |
| `UIWindowScene` | [`UIWindowScene`](https://developer.apple.com/documentation/uikit/uiwindowscene) |
| `UIActivityViewController` | [`UIActivityViewController`](https://developer.apple.com/documentation/uikit/uiactivityviewcontroller) |
| `UIColor` (e.g. `systemBackground`) | [`UIColor`](https://developer.apple.com/documentation/uikit/uicolor) |

**Files:** `TaskListView.swift`, `TaskDetailView.swift`

---

### XCTest (unit and UI tests)

| Topic | Documentation |
|-------|----------------|
| XCTest | [XCTest](https://developer.apple.com/documentation/xctest) |
| `XCTestCase` | [`XCTestCase`](https://developer.apple.com/documentation/xctest/xctestcase) |
| `@testable import` | [Testing Swift code with XCTest](https://developer.apple.com/documentation/xctest) |
| `XCUIApplication` | [`XCUIApplication`](https://developer.apple.com/documentation/xctest/xcuiapplication) |
| `XCTAttachment` | [`XCTAttachment`](https://developer.apple.com/documentation/xctest/xctattachment) |

**Files:** `group69Tests/group69Tests.swift`, `group69UITests/group69UITests.swift`, `group69UITests/group69UITestsLaunchTests.swift`

---

### Grand Central Dispatch (main queue timing)

| Topic | Documentation |
|-------|----------------|
| `DispatchQueue.main.asyncAfter` | [`DispatchQueue`](https://developer.apple.com/documentation/dispatch/dispatchqueue) |

**Files:** `RootView.swift`

---

## 3. Architecture summary

- **State:** `DataStore` and `SettingsStore` are reference-type observable objects injected with `@EnvironmentObject` from `group69App`.
- **Navigation:** `NavigationStack` + `NavigationPath` with a typed `Route` enum (`Hashable`, `Codable`) for push destinations; create/edit uses sheets.
- **Persistence:** JSON file `tasks.data` in the app’s documents directory; load on activate, save on inactive and after mutations.

---

## 4. Internal code documentation

Source files include file headers (primary author and student ID, plus other editors where applicable) and comments on non-obvious logic (UIKit bridge for sharing, navigation workaround, index mapping on delete, etc.).

---

## 5. Data structure implementation

The domain model lives in `Taskitem.swift`:

- **`SubtaskStatus`** — `String`-backed `enum`, `Codable` and `CaseIterable`, for subtask workflow (pending / in progress / completed).
- **`Subtask`** — `Identifiable`, `Codable`, `Equatable`; fields: `id`, `title`, `status`.
- **`Comment`** — `Identifiable`, `Codable`, `Equatable`; fields: `id`, `text`, `date`.
- **`TaskItem`** — `Identifiable`, `Codable`, `Equatable`; fields: `id`, `title`, `priority`, `description`, `assignees`, `subtasks`, `comments`, `isCompleted`, `dueDate`.

`Codable` enables automatic synthesis of `Encodable`/`Decodable` for JSON persistence. `Identifiable` supports `ForEach` in SwiftUI lists.

**Routing enum:** `Route` in `Route.swift` — `enum Route: Hashable, Codable` with associated values for detail (`String` task id) and edit (optional `String?`).

**Runtime collections:** `DataStore` holds `@Published var tasks: [TaskItem]` — the single in-memory source of truth for the UI.

---

## 6. Reading data

1. **App launch / foreground:** In `group69App`, when `scenePhase` becomes `.active`, `dataStore.load()` runs.
2. **`DataStore.load()`:** Resolves `tasks.data` under the documents directory via `FileManager`, reads `Data(contentsOf:)`, decodes with `JSONDecoder()` into `[TaskItem]`, assigns to `tasks`.
3. **Missing or invalid file:** Errors are caught and ignored (first run or corrupt file leaves `tasks` as whatever it was, typically empty).
4. **UI reads:** Views read `dataStore.tasks` through `@EnvironmentObject` and derive optional tasks by `taskId` (`uuidString`) where needed.

---

## 7. Writing data

1. **`DataStore.save()`:** Encodes `tasks` with `JSONEncoder()` and writes bytes to `tasks.data` via `Data.write(to:)`.
2. **When save runs:** After user actions that change tasks (create/edit, toggle complete, delete, comments, subtask status, etc.) and when the app moves to `.inactive` (backgrounding), so data is flushed when the user leaves the app.
3. **Settings:** `SettingsStore` uses `@AppStorage("isDarkMode")` so dark mode is stored in **UserDefaults** (not the JSON file).

---

## 8. References — Apple “Get started” and tutorials

- [Introducing SwiftUI](https://developer.apple.com/tutorials/swiftui)  
- [Handling user input](https://developer.apple.com/tutorials/swiftui/handling-user-input)  
- [Persisting data](https://developer.apple.com/tutorials/app-dev-training/persisting-data) (conceptual overlap with file-based JSON in this project)

---

*This file was produced to satisfy course documentation requirements: technologies used (with links), data structures, persistence read path, persistence write path, and internal commenting policy in source files.*
.
