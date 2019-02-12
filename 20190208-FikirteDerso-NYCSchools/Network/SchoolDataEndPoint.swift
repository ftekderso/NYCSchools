//
//  SchoolDataEndPoint.swift
//  20190208-FikirteDerso-NYCSchools
//
//  Created by Fikirte  Derso on 2/10/19.
//  Copyright © 2019 Fikirte  Derso. All rights reserved.
//

import Foundation

typealias HTTPHeader = [String:String]

protocol Components {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethods { get }
    var httpHeader: HTTPHeader? { get }
}

public enum SchoolDataAPI {
    case school
    case score
}

extension SchoolDataAPI: Components {
    
    var baseURL: URL {
        return URL(string: Constants.API.URL)!
    }
    
    var path: String {
        switch self {
        case .school:
            return Constants.Path.SchoolPath
        case .score:
            return Constants.Path.ScorePath
        }
    }
    
    var httpMethod: HTTPMethods {
        return .get
    }
    
    var httpHeader: HTTPHeader? {
        return nil
    }
}

