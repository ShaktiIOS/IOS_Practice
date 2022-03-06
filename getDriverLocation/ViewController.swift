//
//  ViewController.swift
//  getDriverLocation
//
//  Created by Yusata Infotech on 2/22/22.
//

import UIKit
import MapKit
import Firebase
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var dbRef:DatabaseReference?
    
    var driverAnnotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
       dbRef = Database.database().reference()
        
        dbRef?.child("Driver_Data").observe(.value, with: { (data) in
            
            let dict = data.value as? [String:Double] ?? [:]
            let latitude = dict["latitude"]
            let longitude = dict["longitude"]
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            
            print(coordinate)
            
            self.setlocation(currentDriverLocation: coordinate)
            
        })
        
    }
    
   @IBAction func mapTypes(_ sender: UIBarButtonItem) {
       
       if sender.title == "Satellite"{
           mapView.mapType = .satellite
       }
       else{
           mapView.mapType = .standard
       }
       
    }
    var isDriverMarkerSet = false
    
    private func setlocation(currentDriverLocation:CLLocationCoordinate2D){
        
        driverAnnotation.coordinate = currentDriverLocation
        
        let radius:CLLocationDistance = 1000.0
        
        if !isDriverMarkerSet {
            
            mapView.addAnnotation(driverAnnotation)
            
            let region = MKCoordinateRegion(center: currentDriverLocation, latitudinalMeters: radius, longitudinalMeters: radius)
            
            mapView.setRegion(region, animated: true)
            
        }
  
        
    }


}

