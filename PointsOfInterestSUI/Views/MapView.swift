//
//  MapView.swift
//  PointsOfInterestSUI
//
//  Created by elias on 16/8/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let pointOfInterest: PointOfInterest
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        centerAndPinMapOnLocation(pointOfInterest: pointOfInterest, mapView: mapView)
        return mapView
    }
    func updateUIView(_ view: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }
    
    func centerAndPinMapOnLocation(pointOfInterest: PointOfInterest, mapView: MKMapView) {
        let latlong = pointOfInterest.geocoordinates.split(separator: ",")
        let latitude = Double(latlong[0])!
        let longitude = Double(latlong[1])!
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0,
                                                  longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.coordinate = centerCoordinate
        annotation.title = pointOfInterest.title
        annotation.subtitle = pointOfInterest.address
        mapView.addAnnotation(annotation)
    }
//    var body: some View {
//        MapView(pointOfInterest: pointOfInterest)
//
//    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let description = "description"
        let poi = PointOfInterest(id: 1,
                                  title: "Casa Batlló",
                                  geocoordinates: "41.391926,2.165208",
                                  desc: description,
                                  email: "info@casabatllo.cat",
                                  phone: "612345678",
                                  transport: "Underground:Passeig de Gràcia -L3",
                                  address: "Paseo de Gracia, 43, 08007 Barcelona")
        
        MapView(pointOfInterest: poi)
    }
}
