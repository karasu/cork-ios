//
//  MainView.swift
//  corkios
//
//  Created by Gustau Castells on 25/6/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Cork").font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.red)
                .padding()
            Image("intersindical").padding()
            Text("No s'ha trobat cap centre!").padding()
            Button("Cerca el centre educatiu més proper", action: searchCentre).padding()
            Button("Marca el centre com a visitat", action: visitCentre).padding()
        }
    }
    
    func searchCentre() {
        
    }
    
    func visitCentre() {
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
