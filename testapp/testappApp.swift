//
//  testappApp.swift
//  testapp
//
//  Created by Andrei Matei on 15.09.2021.
//

import SwiftUI

@main
struct testappApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
