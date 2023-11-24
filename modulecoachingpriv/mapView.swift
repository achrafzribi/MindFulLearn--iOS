//
//  mapView.swift
//  modulecoachingpriv
//
//  Created by Mac-Mini_2021 on 07/11/2023.
//
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var selectedAnnotation: MKPointAnnotation?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        if let annotation = selectedAnnotation {
            uiView.selectAnnotation(annotation, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation as? MKPointAnnotation {
                // Handle the marker click event here
                // You can perform actions when the marker is clicked
                // For example, update a @State variable to show details
                parent.selectedAnnotation = annotation
            }
        }

        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            // Handle deselection if needed
            parent.selectedAnnotation = nil
        }
    }
}
