//
//  AddBook.swift
//  BookCollectionApp
//
//  Created by admin on 02/02/25.
//

import SwiftUI

struct AddBook: View {
    @Environment(\.managedObjectContext)private var viewContext
    @Environment(\.dismiss)private var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var dateadded = Date()
    @State private var isreal = false

  
    var body: some View {
        NavigationView{
            Form{
                Section(header:Text("post title")){
                    TextField("enter title",text:$title)
                    TextField("enter author",text:$author)
                    TextField("enter genre",text:$genre)
                }
                Section(header:Text("additional info "))
                {
                    DatePicker("selectDate",selection: $dateadded,displayedComponents: .date).accessibilityLabel("post date picker")
                    Toggle("is real",isOn: $isreal).accessibilityLabel("post real toggle")
                    
                }
            }.navigationBarTitle("Add new post",displayMode: .inline)
                .navigationBarItems(leading: Button("Cancel")
                                    {
                    dismiss()
                },trailing: Button("save")
                                    {
                    addbook()
                    dismiss()
                }.disabled(title.isEmpty||author.isEmpty||genre.isEmpty))
        }
    }
    func addbook()
    {
        let newbook = Book(context: viewContext)
        newbook.title = title
        newbook.genre = genre
        newbook.author = author
        newbook.dateadded = dateadded
        newbook.isreal = isreal
        do{
            try viewContext.save()
        }  catch
            {
                print("erre saving post:\(error)")
            }
        }
        
    }



struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}
