import SwiftUI
import SwiftData

@main
struct BooksApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(for: Book.self)
    }

    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
