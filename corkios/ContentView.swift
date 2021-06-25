//
//  ContentView.swift
//  corkios
//
//  Created by Gustau Castells on 25/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var email: String = ""
    @State var contrasenya: String = ""

    @Binding var signInSuccess: Bool
    
    var body: some View {
        
        
        VStack(alignment: .center) {
            Text("Cork").font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.red)
                .padding()
            Image("intersindical")
            Text("Identifica't!").fontWeight(.bold).bold().padding()
            TextField("Correu electrònic", text: $email).padding()
            SecureField("Contrasenya", text: $contrasenya).padding()
            Button("Entra!", action: signIn).padding()
        }
    }
    
    func signIn() {
        self.signInSuccess = true
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ContentView(signInSuccess: Binding.constant(false))
                .preferredColorScheme(.dark)
        }
    }
}
