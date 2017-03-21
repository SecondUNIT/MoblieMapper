//
//  ViewController.swift
//  MobileMapper
//
//  Created by student3 on 3/20/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let address = "Mount Fuji"
    let geocoder = CLGeocoder()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let herseyAnnotation = MKPointAnnotation()
        let lat: Double = 42.102332924
        let long: Double = -84.955667844
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        herseyAnnotation.coordinate = coordinate
        herseyAnnotation.title = "Hersey High School"
        mapView.addAnnotation(herseyAnnotation)
        
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


}

