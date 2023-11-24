//
//  mapviewreprentable.swift
//  modulecoachingpriv
//
//  Created by Mac-Mini_2021 on 07/11/2023.
//

import SwiftUI
import MapKit
struct mapviewrepresentable : UIViewRepresentable{
    @StateObject var UserViewModel = Userviewmodel2()
    @EnvironmentObject var viewModel : Locationsearchviewmodel
    var mapView = MKMapView()
    let locationManager = locatiomanager()
    @Binding var mapstate :mapviewstate
    @Binding var coachloc : Bool
    func makeUIView(context: Context) -> UIView
    {mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        UserViewModel.fetchUsers()
         
        let x = MKPointAnnotation()
        x.coordinate   =  CLLocationCoordinate2D(latitude: 33.8869, longitude: 10.560764)
        x.title = "Marker Title"

        mapView.addAnnotation (x)
        let y = MKPointAnnotation()
        y.coordinate   =  CLLocationCoordinate2D(latitude: 35.9269, longitude: 11.960764)
        y.title = "Marker iheb"

        mapView.addAnnotation (y)
        let b = MKPointAnnotation()
        b.coordinate   =  CLLocationCoordinate2D(latitude: 36.9269, longitude: 11.960764)
        b.title = "tuniss marsaa"

        mapView.addAnnotation (b)
     
        return mapView
    }
     func updateUIView(_ uiView: UIView, context: Context) {
        /*if let coordinate = viewModel.selectedLocationCoordinate{
         context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
         /*context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)*/
         }*/
         if UserViewModel.annotation != UserViewModel.users.count {
             print(UserViewModel.users.count)
             print(UserViewModel.annotation)

            for user in UserViewModel.users {
                //print(user)
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: user.latitude ?? 0.0,
                    longitude: user.longitude ?? 0.0)
                annotation.title = user.firstname+"  "+user.lastname
                
                self.mapView.addAnnotation(annotation)
                UserViewModel.annotation = UserViewModel.users.count
                viewModel.coachs.append(user.firstname+"  "+user.lastname)
            }
        }
            let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(MapCoordinator.handleTap(gesture:)))
            mapView.addGestureRecognizer(tapGesture)
        
        switch mapstate {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            
            break
        case .searchingForLocation:
            break
        case .displaycoachview:
            break
        case.locationSelected:
            if let coordinate = viewModel.selectedLocationCoordinate{
                context.coordinator.addAndSelectAnnotation (withCoordinate: coordinate)
                /*context.coordinator.configurePolyline (withDestinationCoordinate: coordinate)*/
                break
                
            } else{
                if (viewModel.selectedcoach != nil){
                    context.coordinator.findandselectAnnotation(viewModel.selectedcoach!)
                    
                }
                
            }
            break
        }
        if mapstate == .noInput {
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
        }
        
    }
    func makeCoordinator() -> MapCoordinator{
        return MapCoordinator(parent: self)
    }
    
  
}
extension mapviewrepresentable{
    class MapCoordinator:NSObject,MKMapViewDelegate
    {
        @objc func handleTap(gesture: UITapGestureRecognizer) {
            guard let mapView = gesture.view as? MKMapView else { return }
            if parent.coachloc{
                let matchingAnnotations = parent.mapView.annotations.filter{ $0.title == parent.viewModel.coachusername}
                if matchingAnnotations.isEmpty{
                    
                    let touchPoint = gesture.location(in: mapView)
                    let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                    let x = MKPointAnnotation()
                    x.coordinate   =  coordinate
                    x.title = "Marker lol"
                    print(parent.coachloc)
                    self.parent.mapView.addAnnotation (x)
                    parent.coachloc = false
                    print(parent.coachloc)
                }
            }
        }
           
        var currentRegion: MKCoordinateRegion?

        let parent:mapviewrepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        init(parent:mapviewrepresentable){
            self.parent=parent
            super.init()
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 1.05, longitudeDelta: 1.05))
            self.currentRegion = region
            //parent.mapView.setRegion(region, animated: true)
            
            
        }
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            self.parent.viewModel.selectedcoach = self.parent.mapView.selectedAnnotations.first?.title!
            self.parent.mapstate = .displaycoachview
            
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        func addAndSelectAnnotation (withCoordinate coordinate:CLLocationCoordinate2D) {
            /*parent.mapView.removeAnnotation(parent.mapView.annotations )*/
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            self.parent.mapView.addAnnotation (anno)
            self.parent.mapView.selectAnnotation (anno, animated: true)
          
           
           
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 30000, longitudinalMeters: 30000)
            parent.mapView.setRegion(region, animated: true)

            
            
        }
        func findandselectAnnotation (_ selectedcoach :String) {
            let matchingAnnotations = parent.mapView.annotations.filter{ $0.title == selectedcoach}
            parent.mapView.selectAnnotation (matchingAnnotations.first!, animated: true)
           
            let region = MKCoordinateRegion(center: matchingAnnotations.first!.coordinate, latitudinalMeters: 300000, longitudinalMeters: 300000)
            parent.mapView.setRegion(region, animated: true)
            //parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
            
            
            
        }
        /*func configurePolyline (withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            getDestinationRoute (from: userLocationCoordinate,
                                 to: coordinate){ route in
                self.parent.mapView.addOverlay(route.polyline)
            }
        }
        func getDestinationRoute(from userLocation : CLLocationCoordinate2D , to destination : CLLocationCoordinate2D,completion : @escaping(MKRoute) -> Void) {
            print("hellloooo")
            print(destination)
            
            let userPlacemark = MKPlacemark (coordinate: userLocation)
            let destPlacemark = MKPlacemark (coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            let directions = MKDirections (request: request)
            directions.
            directions.calculate{ response, error in
                if let error = error {
                    print("DEBUG: Failed to get directions with error\(error.localizedDescription)")
                    return
                    
                }
                print("hello2")
                print(response?.routes)
                guard let route = response?.routes.first else { return }
                completion (route)
            }
        }*/
        func clearMapViewAndRecenterOnUserLocation() {
            if !parent.mapView.annotations.isEmpty{
                //print(parent.mapView.annotations.last!)
                for annotation in parent.mapView.selectedAnnotations {
                    parent.mapView.deselectAnnotation(annotation, animated: false)
                        }

                //parent.mapView.removeAnnotations ([parent.mapView.annotations.last!])
               // parent.mapView.removeOverlays (parent.mapView.overlays)
               
            }
        }
    }
}
