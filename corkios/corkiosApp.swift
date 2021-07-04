//
//  corkiosApp.swift
//  corkios
//
//  Created by Gustau Castells on 25/6/21.
//

import SwiftUI
import CoreLocation
import Firebase
import UIKit

struct User {
    var email: String
    var password: String
    var name: String
}

struct Centre: Decodable {
    var Codi: Int
    var Nom: String
    var Nom_comarca: String
    var Nom_municipi: String
    var Coordenades_GEO_X: Double
    var Coordenades_GEO_Y: Double
    var Email_centre: String
}

@main
struct corkiosApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    init() {
        // perform any task on app launch
        // Use Firebase library to configure APIs
      }

    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView(centre: Centre(Codi: 0, Nom: "", Nom_comarca: "", Nom_municipi: "", Coordenades_GEO_X: 1.0, Coordenades_GEO_Y: 1.0, Email_centre: "")).preferredColorScheme(.dark).environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
