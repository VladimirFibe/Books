import SwiftUI

struct EditBookView: View {
//    let book: Book
    @State private var status = Status.completed
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView = true
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            datesView
            Divider()
            LabeledContent {
                RatingView(maxRating: 5, currentRating: $rating)
            } label: {
                Text("Rating")
            }
        }
    }
    var datesView: some View {
        GroupBox {
            LabeledContent {
                DatePicker("", selection: $dateAdded, displayedComponents: .date)
            } label: {
                Text("Date Added")
            }

            if status == .inProgress || status == .completed {
                LabeledContent {
                    DatePicker(
                        "",
                        selection: $dateStarted,
                        in: dateAdded...,
                        displayedComponents: .date
                    )
                } label: {
                    Text("Date Started")
                }
            }

            if status == .completed {
                LabeledContent {
                    DatePicker(
                        "",
                        selection: $dateCompleted,
                        in: dateStarted...,
                        displayedComponents: .date
                    )
                } label: {
                    Text("Date Completed")
                }
            }
        }
        .foregroundStyle(.secondary)
    }
    var statusView: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.title).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    EditBookView()
}
