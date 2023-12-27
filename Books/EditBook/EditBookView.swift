import SwiftUI

struct EditBookView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: EditBookViewModel
    init(book: Book) {
        viewModel = EditBookViewModel(book: book)
    }
    var body: some View {
        VStack(alignment: .leading) {
            statusView
            datesView
            textsView
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if viewModel.changed {
                Button("Update") {
                    viewModel.update()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    var textsView: some View {
        GroupBox {
            LabeledContent {
                RatingView(maxRating: 5, currentRating: $viewModel.rating)
                    .frame(height: 20)
            } label: {
                Text("Rating")
            }
            LabeledContent {
                TextField("", text: $viewModel.title)
            } label: {
                Text("Title").foregroundStyle(.secondary)
            }
            LabeledContent {
                TextField("", text: $viewModel.author)
            } label: {
                Text("Author").foregroundStyle(.secondary)
            }
            Divider()
            Text("Summary").foregroundStyle(.secondary)
            TextEditor(text: $viewModel.summary)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
        }
    }

    var datesView: some View {
        GroupBox {
            LabeledContent {
                DatePicker(
                    "",
                    selection: $viewModel.dateAdded,
                    displayedComponents: .date
                )
            } label: {
                Text("Date Added")
            }

            if viewModel.status == .inProgress || viewModel.status == .completed {
                LabeledContent {
                    DatePicker(
                        "",
                        selection: $viewModel.dateStarted,
                        in: viewModel.dateAdded...,
                        displayedComponents: .date
                    )
                } label: {
                    Text("Date Started")
                }
            }

            if viewModel.status == .completed {
                LabeledContent {
                    DatePicker(
                        "",
                        selection: $viewModel.dateCompleted,
                        in: viewModel.dateStarted...,
                        displayedComponents: .date
                    )
                } label: {
                    Text("Date Completed")
                }
            }
        }
        .foregroundStyle(.secondary)
        .onChange(of: viewModel.status, viewModel.updateDates)
    }
    var statusView: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $viewModel.status) {
                ForEach(Status.allCases) { status in
                    Text(status.title).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    NavigationStack {
        BookListView()
            .modelContainer(for: Book.self, inMemory: true)
    }
}
