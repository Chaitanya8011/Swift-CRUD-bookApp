//
//  BookCollectionAppApp.swift
//  BookCollectionApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

@main
struct BookCollectionAppApp: App {
    let persisteneceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext,persisteneceController.container.viewContext)
        }
    }
}
