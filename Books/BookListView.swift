import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.status) private var books: [Book]
    @State private var createNewBook = false
    var body: some View {
        NavigationStack {
            Group {
                if books.isEmpty {
                    ContentUnavailableView("Enter your first book.", systemImage: "book.fill")
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink(destination: { EditBookView(book: book)}) {
                                ExtractedView(book: book)
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let book = books[index]
                                context.delete(book)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Books")
            .toolbar  {
                Button {
                    createNewBook.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .sheet(isPresented: $createNewBook) {
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BookListView()
        .modelContainer(preview.container)
}

struct ExtractedView: View {
    let book: Book
    var body: some View {
        HStack(spacing: 10) {
            book.icon
            VStack {
                Text(book.title)
                    .font(.title2)
                Text(book.author)
                    .foregroundStyle(.secondary)
                if let rating = book.rating {
                    HStack {
                        ForEach(0..<rating, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .imageScale(.small)
                                .foregroundStyle(.yellow)
                        }
                    }
                }
            }
        }
    }
}
