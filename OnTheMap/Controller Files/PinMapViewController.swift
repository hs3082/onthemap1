//
//  PinMapViewController.swift
//  OnTheMap
//
//  Created by Howard Snyder on 9/7/20.
//  Copyright © 2020 Howard Snyder. All rights reserved.
//

import UIKit
import MapKit

class PinMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var location: String!
    var coordinate: CLLocationCoordinate2D!
    var updatePin: Bool!
    var url: String!
    var studentLocArray: [StudentLocation]!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self as? MKMapViewDelegate
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard coordinate != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        addPin(coordinate: coordinate)
    }
    
    @IBAction func pressedFinished(_ sender: Any) {
        
        // get User data : firstName, lastName
        UdacityClient.getUserData { (userData, error) in
            guard let userData = userData else {
                return
            }
            
            let firstName: String = ""
            let lastName: String = ""
     
            let studentLocationRequest = PostLocation(uniqueKey: userData.key, firstName: firstName, lastName: lastName, mapString: self.location, mediaURL: self.url, latitude: Float(self.coordinate.latitude), longitude: Float(self.coordinate.longitude))
            
            
            // network request
            self.updatePin ? self.updateExistedPin(postLocationData: studentLocationRequest) : self.postPin(postLocationData: studentLocationRequest)
        }

    }
    
    
    func postPin(postLocationData: PostLocation) {
        UdacityClient.postStudentLoaction(postLocation: postLocationData) { (success,error) in
            if error != nil{
                self.showAlert(title: "can't post new pin", message: "Error message :\n\(error?.localizedDescription ?? "can't post")")
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
    }

    func updateExistedPin(postLocationData: PostLocation) {
        if studentLocArray.isEmpty { return }
        
        UdacityClient.putStudentLocation(objectID: studentLocArray[0].objectID, postLocation: postLocationData) { (success, error) in
            
            if error  != nil{
                self.showAlert(title: "can't post new pin", message: "Error message :\n\(error?.localizedDescription ?? "can't post")")
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
    
        }
    }
    
}


extension PinMapViewController: MKMapViewDelegate {
    
    func addPin(coordinate: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = location
        
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        DispatchQueue.main.async {
            self.mapView.addAnnotation(annotation)
            self.mapView.setRegion(mapRegion, animated: true)
            self.mapView.regionThatFits(mapRegion)
        }
    }
    
}

