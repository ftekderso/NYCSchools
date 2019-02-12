//
//  School.swift
//  20190208-FikirteDerso-NYCSchools
//
//  Created by Fikirte  Derso on 2/8/19.
//  Copyright © 2019 Fikirte  Derso. All rights reserved.
//

import Foundation

public struct School {
    
    var schoolName:String?
    var location:String?
    var phoneNumber:String?
    var website:String?
    var schoolEmail:String?
    var latitude:String?
    var longitude:String?
    
    public init(data:[String:AnyObject]?)  {
        
        if let data = data {
            for (key,value) in data {
                if key == Constants.JSONResponseKey.SchoolName {
                    self.schoolName = value as? String
                }
                if key == Constants.JSONResponseKey.Location {
                    self.location = value as? String
                }
                if key == Constants.JSONResponseKey.PhoneNumber {
                    self.phoneNumber = value as? String
                }
                if key == Constants.JSONResponseKey.Website {
                    self.website = value as? String
                }
                if key == Constants.JSONResponseKey.SchoolEmail {
                    self.schoolEmail = value as? String
                }
                if key == Constants.JSONResponseKey.Latitude {
                    self.latitude = value as? String
                }
                if key == Constants.JSONResponseKey.Longitude {
                    self.longitude = value as? String
                }
            }
        }
    }
        
}


    

 
 


