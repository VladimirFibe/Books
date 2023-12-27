import SwiftUI
import SwiftData

@main
struct BooksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }

    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
