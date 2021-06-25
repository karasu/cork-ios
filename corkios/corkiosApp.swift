//
//  corkiosApp.swift
//  corkios
//
//  Created by Gustau Castells on 25/6/21.
//

import SwiftUI

@main
struct corkiosApp: App {
    @State var signInSuccess = false
    
    init() {
        // perform any task on app launch
    }

    var body: some Scene {
        WindowGroup("Cork") {
            if signInSuccess {
                MainView().preferredColorScheme(.dark)
            }
            else {
                ContentView(signInSuccess: $signInSuccess).preferredColorScheme(.dark)
            }
        }

    }

}
