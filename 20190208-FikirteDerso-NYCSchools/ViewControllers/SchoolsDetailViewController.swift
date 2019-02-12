//
//  SchoolsDetailViewController.swift
//  20190208-FikirteDerso-NYCSchools
//
//  Created by Fikirte  Derso on 2/8/19.
//  Copyright © 2019 Fikirte  Derso. All rights reserved.
//

import UIKit
import MapKit

class SchoolsDetailViewController: UIViewController {
    
    var satScores:SATScore?
    var schoolDetail:School?
    
    @IBOutlet weak var activiyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var schoolMapView: MKMapView!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var mathScore: UILabel!
    @IBOutlet weak var readingScore: UILabel!
    @IBOutlet weak var writingScore: UILabel!
    @IBOutlet weak var numOfTestTakers: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var website: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.activiyIndicator.hidesWhenStopped = true
        self.schoolName.text = schoolDetail?.schoolName
        self.address.text = schoolDetail?.location
        self.phoneNumber.text = schoolDetail?.phoneNumber
        self.email.text = schoolDetail?.schoolEmail
        self.website.text = schoolDetail?.website
            
        self.mathScore.text = satScores?.mathScore
        self.readingScore.text = satScores?.readingScore
        self.writingScore.text = satScores?.writingScore
        if let numOfTestTakers = satScores?.numberOfTestTakerss {
          self.numOfTestTakers.text = "Number of SAT Test Takers:" + " " + numOfTestTakers
        }
        
        //Show School location on map
        self.addAnnotation()
      
        //UI effect for Score Label
        self.scoreLabelUIEffect()
        
    }
    
    func addAnnotation() {
        //Map annotation
        let schoolAnnotation = MKPointAnnotation()
        schoolAnnotation.title = schoolDetail?.schoolName
        if let lat = schoolDetail?.latitude, let long = schoolDetail?.longitude {
            schoolAnnotation.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
            
        }
        schoolMapView.addAnnotation(schoolAnnotation)
        schoolMapView.showAnnotations([schoolAnnotation], animated: true)
        
    }
    
    func scoreLabelUIEffect() {
        //creates circle label
        self.mathScore.layer.cornerRadius = self.mathScore.frame.width/2
        self.mathScore.layer.masksToBounds = true
        
        self.readingScore.layer.cornerRadius = self.mathScore.frame.width/2
        self.readingScore.layer.masksToBounds = true
        
        self.writingScore.layer.cornerRadius = self.mathScore.frame.width/2
        self.writingScore.layer.masksToBounds = true
    }

}

extension SchoolsDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}
