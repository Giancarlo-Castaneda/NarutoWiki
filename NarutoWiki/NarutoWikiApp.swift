//
//  NarutoWikiApp.swift
//  NarutoWiki
//
//  Created by Giancarlo Castañeda Garcia on 12/06/24.
//
import ComposableArchitecture
import SwiftUI

@main
struct NarutoWikiApp: App {
    static let store = Store(initialState: ContentMenuReducer.State()) {
        ContentMenuReducer()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            ContentMenuView(store: NarutoWikiApp.store)
        }
    }
}
