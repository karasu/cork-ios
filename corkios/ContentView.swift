//
//  MainView.swift
//  corkios
//
//  Created by Gustau Castells on 25/6/21.
//

import SwiftUI
import CoreLocation
import FirebaseDatabase

struct ContentView: View {
    //let notificationCenter = UNUserNotificationCenter.current()
    @StateObject var locationManager = LocationManager()
    @State var centre : Centre
    @State private var showCentreName = false
    @EnvironmentObject var viewModel : AppViewModel

    var userLatitude: Double {
        return (locationManager.lastLocation?.coordinate.latitude ?? 0)
    }
        
    var userLongitude: Double {
        return (locationManager.lastLocation?.coordinate.longitude ?? 0)
    }
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                VStack(alignment: .center) {
                    Text("Cork").font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        .padding()
                    Image("intersindical").resizable().scaledToFit()
                    Text(centre.Nom).padding()
                    .alert(isPresented: $showCentreName) {
                        Alert(title: Text("Centre"), message: Text(centre.Nom), dismissButton: .default(Text("Acceptar")))                       }
                    Button("Cerca el centre educatiu més proper", action: searchCentre).padding().background(Color(.secondarySystemBackground))
                    Button("Marca el centre com a visitat", action: visitCentre).padding().background(Color(.secondarySystemBackground))
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign out").foregroundColor(Color.blue)
                        
                    })
                }
            }
            else {
                SignInView().environmentObject(viewModel)
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
    
    func distance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
                
        let radius = 6371e3 // metres
        let rlat1 = lat1 * Double.pi / 180 // φ1
        let rlat2 = lat2 * Double.pi / 180 // φ2
        let dlat = (lat2 - lat1) * Double.pi / 180 // Δφ
        let dlon = (lon2 - lon1) * Double.pi / 180 // Δλ

        let a = pow(sin(dlat/2), 2) + cos(rlat1) * cos(rlat2) * pow(sin(dlon/2), 2)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))

        return radius * c
    }

    func searchCentre() {
        var mindist = -1.0
        var minitem : Centre?
        
        let myAsset = NSDataAsset(name: "CentresEducatius", bundle: Bundle.main)
        let centres = try! JSONDecoder().decode([Centre].self, from: myAsset!.data)
        
        for item in centres {
            //print(item.Nom)
            //print(item.Coordenades_GEO_Y)
            //print(item.Coordenades_GEO_X)
            let dist = distance(lat1: userLatitude, lon1: userLongitude, lat2: item.Coordenades_GEO_Y, lon2: item.Coordenades_GEO_X)
            if (dist < mindist || mindist < 0) {
                // print(dist)
                mindist = dist
                minitem = item
            }
        }
        
        if (mindist >= 0) {
            print(">>>", mindist)
            centre = minitem!
            showCentreName = true
        }
    }


    func visitCentre() {
        /*
        val url = "https://cork-86201-default-rtdb.europe-west1.firebasedatabase.app"
                database = FirebaseDatabase.getInstance(url)
        
        val currentTime = java.util.Calendar.getInstance()
                    centre.visitTime = currentTime.time.toString()
                    centre.user = auth.currentUser!!.email.toString()
                    database.getReference("centres").child(centre.Codi!!).setValue(centre)
*/
        //let url = "https://cork-86201-default-rtdb.europe-west1.firebasedatabase.app"

        if (centre.Codi != 0) {
            var ref: DatabaseReference!
            
            ref = Database.database().reference()
            
            let centreRef = ref.child("centres").child(String(centre.Codi))

            centreRef.setValue(String(centre.Codi))
            
            centreRef.child("codi").setValue(centre.Codi)
            centreRef.child("nom").setValue(centre.Nom)
            centreRef.child("nom_comarca").setValue(centre.Nom_comarca)
            centreRef.child("nom_municipi").setValue(centre.Nom_municipi)
            centreRef.child("coordenades_GEO_X").setValue(centre.Coordenades_GEO_X)
            centreRef.child("coordenades_GEO_Y").setValue(centre.Coordenades_GEO_Y)
            centreRef.child("email").setValue(centre.Email_centre)
           
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E MMM dd HH:mm:ss yyyy"
            let date = Date()
            let dateString = dateFormatter.string(from: date)
            
            centreRef.child("visitTime").setValue(dateString)
            centreRef.child("user").setValue(viewModel.user)
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        ContentView(centre: Centre(Codi: 0, Nom: "", Nom_comarca: "", Nom_municipi: "", Coordenades_GEO_X: 1.0, Coordenades_GEO_Y: 1.0, Email_centre: "")).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
