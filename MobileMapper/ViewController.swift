//
//  ViewController.swift
//  MobileMapper
//
//  Created by student3 on 3/20/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    let address = "Tokyo"
    let geocoder = CLGeocoder()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let herseyAnnotation = MKPointAnnotation()
        let lat: Double = 42.102332924
        let long: Double = -87.955667844
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        herseyAnnotation.coordinate = coordinate
        herseyAnnotation.title = "Hersey High School"
        mapView.addAnnotation(herseyAnnotation)
        
        mapView.delegate = self
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            //print(placemarks?.count)
            for place in placemarks!
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (place.location?.coordinate)!
                annotation.title = place.name
                self.mapView.addAnnotation(annotation)
            }
        }
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        var pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.image = UIImage(named: "reapergirl")
        
        pin.canShowCallout = true
        let button = UIButton(type: .detailDisclosure)
        pin.rightCalloutAccessoryView = button
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: (view.annotation?.coordinate)!, span: span)
        mapView.setRegion(region, animated: true)
    }

}

