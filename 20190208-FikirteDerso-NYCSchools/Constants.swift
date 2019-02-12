//
//  Constants.swift
//  20190208-FikirteDerso-NYCSchools
//
//  Created by Fikirte  Derso on 2/10/19.
//  Copyright © 2019 Fikirte  Derso. All rights reserved.
//

import Foundation

public struct Constants {
    
    struct API {
        static let Scheme = "https"
        static let Host = "data.cityofnewyork.us"
        static let URL = "https://data.cityofnewyork.us/"
        static let Token = "hPsUUEsXXQidr2zbbDeabM3bJ"
    }
    
    struct HeaderKey {
        static let XAppToken = "X-App-Token"
    }
    
    struct Path {
        static let SchoolPath = "/resource/s3k6-pzi2.json"
        static let ScorePath = "/resource/f9bf-2cp4.json"
    }
    
    struct JSONResponseKey {
        
        static let SchoolName = "school_name"
        //Mark: School
        static let PhoneNumber = "phone_number"
        static let SchoolEmail = "school_email"
        static let Location = "location"
        static let Website = "website"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        
        // Mark: SATScores
        static let SATMathAvgScore = "sat_math_avg_score"
        static let SATReadingAvgScore = "sat_critical_reading_avg_score"
        static let SATWritingAvgScore = "sat_writing_avg_score"
        static let NumOfSATTestTakers = "num_of_sat_test_takers"
    }
}
