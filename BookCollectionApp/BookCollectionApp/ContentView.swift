//
//  ContentView.swift
//  BookCollectionApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext)private var viewContext
    @FetchRequest(entity:Book.entity(),
    sortDescriptors: [])private var book : FetchedResults<Book>
    @State private var showAddview = false
    @State private var BooksToedit:Book?
                       
    var body: some View {
        NavigationView{
            List{
                ForEach(book){ book in
                    NavigationLink(destination:EditBook(book : book)){
                        HStack{
                            VStack{
                                Text(book.title ?? "no title")
                                Text(book.author ?? "no author")
                                Text(book.genre ?? "no  genre")
                                Text(book.author ?? "no author")

                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .swipeActions
                    {
                        Button(role:.destructive)
                        {
                              deleteBook(book)
                        }label: {
                            Label("Delete",systemImage:"trash.fill")
                        }
                    }
                    
                    
                }
            }.navigationTitle("All books")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing)
                    {
                        Button(action:{
                            showAddview = true
                        })
                        {
                            Image(systemName: "plus")
                        }
                    }
                }.sheet(isPresented:$showAddview){
                    AddBook()
                }
        }
    }
    private func deleteBook(_ book:Book)
    {
        viewContext.delete(book)
        do{
            try viewContext.save()
        }catch{
            print("error deleteing post \(error)")
        }
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
