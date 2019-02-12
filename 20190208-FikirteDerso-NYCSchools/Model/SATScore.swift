//
//  SATScore.swift
//  20190208-FikirteDerso-NYCSchools
//
//  Created by Fikirte  Derso on 2/8/19.
//  Copyright © 2019 Fikirte  Derso. All rights reserved.
//

import Foundation

public struct SATScore {
    
    var schoolName:String?
    var mathScore:String?
    var readingScore:String?
    var writingScore:String?
    var numberOfTestTakerss:String?
    
    public init(data:[String:AnyObject]?) {
        if let data = data {
            for (key, value) in data {
                if key == Constants.JSONResponseKey.SchoolName {
                    self.schoolName = value as? String
                }
                if key == Constants.JSONResponseKey.SATMathAvgScore {
                    self.mathScore = value as? String
                }
                if key == Constants.JSONResponseKey.SATReadingAvgScore {
                    self.readingScore = value as? String
                }
                if key == Constants.JSONResponseKey.SATWritingAvgScore {
                    self.writingScore = value as? String
                }
                if key == Constants.JSONResponseKey.NumOfSATTestTakers {
                    self.numberOfTestTakerss = value as? String
                }
            }
        }
    }
}

