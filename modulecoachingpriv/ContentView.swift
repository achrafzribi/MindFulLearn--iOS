//
//  ContentView.swift
//  modulecoachingpriv
//
//  Created by yahya fhima on 6/11/2023.
//

import SwiftUI
import CoreData
import MapKit
/*struct IdentifiablePlace: Identifiable {
    let id: UUID
    var location: CLLocationCoordinate2D
    init(loc:CLLocationCoordinate2D) {
        self.id  = UUID()
        self.location=loc
       
     
     
    }
}
extension MKPointAnnotation: Identifiable {
    public var id: String {
        self.title ?? UUID().uuidString
    }
}
struct ContentView: View {
    var locations: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 33.8869, longitude: 9.560764),
        CLLocationCoordinate2D(latitude: 33.1234, longitude: 10.5678),
        // Add more locations here
    ]
    @Environment(\.managedObjectContext) private var viewContext
    var place : IdentifiablePlace=IdentifiablePlace(loc:CLLocationCoordinate2D.userLocation)
    
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var region = MKCoordinateRegion.userRegion
    @State private var selectedAnnotation: MKPointAnnotation?
    @State private var annotations: [MKPointAnnotation] = []
    var body: some View {
        NavigationView {
            VStack{
                // Wrap your entire view in a NavigationView
                ZStack{
                    
                    
                    Map(coordinateRegion: $region, showsUserLocation: true,  annotationItems: annotations) { annotation in
                        MapMarker(coordinate: annotation.coordinate, tint: .red)
                        }
                    
                            .onAppear {
                                // Add markers (annotations) to the map
                                let annotation = MKPointAnnotation()
                                annotation.coordinate = CLLocationCoordinate2D(latitude: 33.8869, longitude: 10.560764)
                                annotation.title = "Marker Title"
                                annotation.subtitle = "Marker Subtitle"
                                let annotation1 = MKPointAnnotation()
                                annotation1.coordinate = CLLocationCoordinate2D(latitude: 33.8869, longitude: 9.560764)
                                annotation1.title = "Marker Title"
                                annotation1.subtitle = "Marker Subtitle"
                                annotations.append(annotation)
                                annotations.append(annotation1)
                                
                            }
                    /* Map(coordinateRegion: $region, annotationItems: [place]) { place in
                     
                     MapMarker.init(coordinate: place.location,tint: Color.red)
                     }
                     .edgesIgnoringSafeArea(.all)*/
                    
                    
                    HStack{
                        Spacer()
                        NavigationLink(destination: MessagerieView()) {
                            Text("online coaches") .padding(7)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }.position(x: UIScreen.main.bounds.width - 90, y: 30)
                        
                    }
                    // Replace "ProfileView" with the actual destination view for "iheb debbech"
                    
                    
                }
                HStack{
                    Button("check"){
                        
                    }
                    Spacer()
                    Button("back"){
                        
                    }
                    
                }
                
           }
        }
    }
}

extension CLLocationCoordinate2D{
    static var userLocation:CLLocationCoordinate2D{
        return .init(latitude: 33.8869, longitude: 9.560764)
    }
}
extension MKCoordinateRegion{
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
                     latitudinalMeters:500000,
                     longitudinalMeters: 500000)
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}*/
