//
//  MapViewController.swift
//  bi-ios-2018
//
//  Created by Jan Misar on 27/11/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func loadView() {
        super.loadView()
        
        let mapView = MKMapView()
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.mapView = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        mapView.removeAnnotations(mapView.annotations)
        
        locations.forEach { locationDict in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: locationDict["lat"]!, longitude: locationDict["lon"]!)
            annotation.title = "A location"
            annotation.subtitle = "A location subtitle"
            mapView.addAnnotation(annotation)
        }
    }
    
    let reuseIdentifier = "reuseIdentifier"
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        annotationView.image = UIImage(named: "location-pin")
        
        annotationView.canShowCallout = true
        
        let button = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = button
        
        annotationView.detailCalloutAccessoryView = UIImageView(image: UIImage(named: "location-pin"))
        
        annotationView.isDraggable = true // that's nonsense here of course 😏 - just for example
        
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            
            locationManager.startUpdatingLocation() // we should also stop it somewhere!
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! // we are sure we have at least one location there
        print(location)
    }
    
    let locations = [
        ["lat": 50.10155117, "lon": 14.50131164],
        ["lat": 50.04845155, "lon": 14.40643163],
        ["lat": 50.01436603, "lon": 14.48202576],
        ["lat": 50.09773545, "lon": 14.42862526],
        ["lat": 50.02386574, "lon": 14.418157],
        ["lat": 50.10891206, "lon": 14.50023615],
        ["lat": 50.13137991, "lon": 14.43188124],
        ["lat": 50.03085971, "lon": 14.43437316],
        ["lat": 50.05523586, "lon": 14.36531867],
        ["lat": 50.12467219, "lon": 14.39459484],
        ["lat": 50.00616185, "lon": 14.41959398],
        ["lat": 50.06693629, "lon": 14.43925259],
        ["lat": 50.08936261, "lon": 14.53516745],
        ["lat": 50.03396537, "lon": 14.48803967],
        ["lat": 50.06252636, "lon": 14.49942098],
        ["lat": 50.01692711, "lon": 14.37874073],
        ["lat": 50.07238541, "lon": 14.37937722],
        ["lat": 50.02807288, "lon": 14.51289626],
        ["lat": 50.0276592, "lon": 14.48751812],
        ["lat": 50.1340302, "lon": 14.45877785]
    ]
}
