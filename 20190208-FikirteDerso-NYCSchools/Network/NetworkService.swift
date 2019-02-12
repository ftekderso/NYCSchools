//
//  NetworkService.swift
//  20190208-FikirteDerso-NYCSchools
//
//  Created by Fikirte  Derso on 2/8/19.
//  Copyright © 2019 Fikirte  Derso. All rights reserved.
//

import Foundation

public class NetworkService {
    
    typealias NetworkComplition = (_ data:Data?, _ response:URLResponse?, _ error:Error?) -> Void
    
    func makeApiRequest(apiType:SchoolDataAPI, queryItems:[URLQueryItem]?, complition:@escaping NetworkComplition) {
        
        //Build Request and send API Request to server
        let urlRequest = buildRequest(apiType: apiType, queryItems: queryItems)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { (data:Data?, response:URLResponse?, error:Error?) in
            complition(data, response, error)
        }
        task.resume()
    }
    
    func buildRequest(apiType:SchoolDataAPI, queryItems:[URLQueryItem]?) -> URLRequest {
        
        // Building the url request with the selected api request type
        var urlComp = URLComponents()
        urlComp.scheme = Constants.API.Scheme
        urlComp.host = Constants.API.Host
        urlComp.path = apiType.path
        //let queryItems = URLQueryItem(name: "school_name", value: "Liberation Diploma Plus High School")
        if let queryItems = queryItems {
             urlComp.queryItems = queryItems
        }
       
        print("URL \(String(describing: urlComp.url))")
       
        var request = URLRequest(url: urlComp.url!)
        
        
       // var request = URLRequest(url: apiType.baseURL.appendingPathComponent(apiType.path))
        request.httpMethod = apiType.httpMethod.rawValue
        
        //Passing App token as part of the URL Request header instade of part of the URL string
        request.addValue(Constants.HeaderKey.XAppToken, forHTTPHeaderField: Constants.API.Token)
        
        return request
    }
}
