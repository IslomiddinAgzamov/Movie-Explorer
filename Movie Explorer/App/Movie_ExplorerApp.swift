//
//  Movie_ExplorerApp.swift
//  Movie Explorer
//
//  Created by Islomiddin on 24/05/25.
//

import SwiftUI

@main
struct MovieExplorerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\ .managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
