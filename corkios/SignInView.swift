//
//  SignInView.swift
//  corkios
//
//  Created by Gustau Castells on 25/6/21.
//

import SwiftUI
import FirebaseAuth

class AppViewModel : ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false 
    
    var isSignedIn : Bool {
        return auth.currentUser != nil
    }
    
    var useremail : String {
        return auth.currentUser?.email ?? ""
    }
    
    var user : String {        
        let firstA = useremail.firstIndex(of: "@") ?? useremail.endIndex
        return String(useremail[..<firstA])
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) {
           [weak self] result, error in
            guard result != nil, error == nil else {
                print(error!.localizedDescription)
               return
            }
            
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
}

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var viewModel : AppViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Cork").font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.red)
                .padding()
            Image("intersindical").resizable().scaledToFit()
            Text("Identifica't!").fontWeight(.bold).bold().padding()
            TextField("Correu electrònic", text: $email).padding().background(Color(.secondarySystemBackground)).autocapitalization(.none).disableAutocorrection(true)
            SecureField("Contrasenya", text: $password).padding().background(Color(.secondarySystemBackground)).autocapitalization(.none).disableAutocorrection(true)
            Button("Entra!", action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                viewModel.signIn(email: email, password: password)
            }).frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(8).foregroundColor(.white).background(Color(.darkGray)).padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SignInView()
                .preferredColorScheme(.dark)
        }
    }
}
