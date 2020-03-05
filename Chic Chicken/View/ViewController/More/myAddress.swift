//
//  myAddress.swift
//  Chic Chicken
//
//  Created by Tariq on 11/26/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class myAddress: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var countryTf: UITextField!
    @IBOutlet weak var cityTf: UITextField!
    @IBOutlet weak var regionTf: UITextField!
    @IBOutlet weak var streetTf: UITextField!
    @IBOutlet weak var builderNumberTf: UITextField!
    @IBOutlet weak var floorNumberTf: UITextField!
    
    var userLat = 0.0
    var userLng = 0.0
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        addTitleImage()
    }
    
    @IBAction func getMyLocationBtn(_ sender: UIButton) {
        getMyLocation()
    }
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("error")
                return
            }
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0] as CLPlacemark?
                let address = (pm?.thoroughfare)! + " " + (pm?.locality)! + " " + (pm?.country)!
                self.regionTf.text = ("\(pm?.subLocality ?? "")")
                self.cityTf.text = "\(pm?.administrativeArea ?? "")"
                self.countryTf.text = "\(pm?.country ?? "")"
                self.streetTf.text = "\(pm?.subThoroughfare ?? "") \(pm?.thoroughfare ?? "")"
                print("addersssss \(address)")
                
            }else {
                print("error2")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        convertLatLongToAddress(latitude: locValue.latitude, longitude: locValue.longitude)
        self.locationManager.stopUpdatingLocation()
    }
    
    func getMyLocation(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
}
