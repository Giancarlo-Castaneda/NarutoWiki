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
    static let store = Store(initialState: CharacterListReducer.State()) {
        CharacterListReducer()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            CharacterListView(store: NarutoWikiApp.store)
        }
    }
}
