//
//  EditBook.swift
//  BookCollectionApp
//
//  Created by admin on 02/02/25.
//

import SwiftUI

struct EditBook: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var book: Book
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var dateadded = Date()
    @State private var isreal = false  // Fixed: Added default value

    var body: some View {
        Form {
            Section(header: Text("Edit your book")) {
                TextField("Enter title", text: $title)
                TextField("Enter author", text: $author)
                TextField("Enter genre", text: $genre)
            }
            
            Section(header: Text("Additional Information")) {
                DatePicker("Select Date", selection: $dateadded, displayedComponents: .date)
                    .accessibilityLabel("Post date picker")
                Toggle("Is Real", isOn: $isreal)
                    .accessibilityLabel("Post toggle")
            }
        }
        .navigationTitle("Edit Book")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button("Cancel") {
                dismiss()
            },
            trailing: Button("Save") {
                book.title = title
                book.author = author
                book.genre = genre
                book.dateadded = dateadded
                book.isreal = isreal
                saveContext()
                dismiss()
            }
            .disabled(title.isEmpty || author.isEmpty || genre.isEmpty)
        )
        .onAppear {
            title = book.title ?? ""
            author = book.author ?? ""
            genre = book.genre ?? ""
            dateadded = book.dateadded ?? Date()
            isreal = book.isreal
        }
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
}

struct EditBook_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let sampleBook = Book(context: context)
        sampleBook.title = "Sample Title"
        sampleBook.author = "Sample Author"
        sampleBook.genre = "Sample Genre"
        sampleBook.dateadded = Date()
        sampleBook.isreal = true
        
        return NavigationView {
            EditBook(book: sampleBook)
                .environment(\.managedObjectContext, context)
        }
    }
}
