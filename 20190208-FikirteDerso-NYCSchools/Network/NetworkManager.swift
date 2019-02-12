//
//  NetworkManager.swift
//  20190208-FikirteDerso-NYCSchools
//
//  Created by Fikirte  Derso on 2/8/19.
//  Copyright © 2019 Fikirte  Derso. All rights reserved.
//

import Foundation
enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case unableToDecode = "We could not decode the response."
    case failed = "Network request failed."
    case noDataReturned = "Response returned with no data to decode."
}

enum NetworkResult<String> {
    case success
    case failure(String)
}

public struct NetworkManager {
    
    typealias SchoolComplitionHandler = (_ schoolData:[School]?, _ error:String?) -> Void
    typealias ScoreComplitionHandler = (_ scoreData:SATScore?, _ error:String?) -> Void
    
    // MARK : Network Response Check
    private func checkNetworkResponse(response:HTTPURLResponse) -> NetworkResult<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
     // MARK : API Request
    func getSchoolsFromURL(queryItems:[URLQueryItem]? ,complition:@escaping SchoolComplitionHandler) {
        
        //get School API Type
        let schoolApi = SchoolDataAPI.school
        
        //make a network service call for school API Type
        let networkService = NetworkService()
        networkService.makeApiRequest(apiType: schoolApi, queryItems: queryItems) { (data:Data?, response:URLResponse?, error:Error?) in
           
            if error != nil  {
                complition(nil,"Netowrk Error. Please check your network")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.checkNetworkResponse(response: response)
                switch result {
                case .success:
                    //Check if there is data first
                    guard let responseData = data else {
                        complition(nil, NetworkResponse.noDataReturned.rawValue)
                        return
                    }
                    do {
                    //Decode JSON Response data
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! [[String : Any]]
                        let sortedJsonData = jsonData.sorted{
                            let aSchool = $0["school_name"] as! String
                            let bSchool =  $1["school_name"] as! String
                            return aSchool.compare(bSchool) == .orderedAscending
                            
                        }
 
                        //print("Sorted json \(sortedJsonData)")
                        var schoolList:[School] = []
                        for item in sortedJsonData {
                            let schoolObject = School(data: item as [String : AnyObject])
                            schoolList.append(schoolObject)
                        }
 
                        complition(schoolList,nil)
                    }
                    catch {
                        print("Error decoding: \(error)")
                        complition(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let NetworkFailureError):
                    complition(nil, NetworkFailureError)
                }
            }
        }
    }
    
    func getSatScoresFromURL(queryItems:[URLQueryItem]?, complition:@escaping ScoreComplitionHandler) {
        //get SatScore API Type
        let scoreApi = SchoolDataAPI.score
     
        //make a network service call for Score API Type
        let networkService = NetworkService()
        networkService.makeApiRequest(apiType: scoreApi, queryItems: queryItems) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil  {
                complition(nil,"Netowrk Error. Please check your network")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.checkNetworkResponse(response: response)
                switch result {
                case .success:
                    //Check if there is data first
                    guard let responseData = data else {
                        complition(nil, NetworkResponse.noDataReturned.rawValue)
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! [[String : Any]]
                        print("Score json \(jsonData)")
                      
                        let scoreObject = SATScore(data: jsonData.first as [String : AnyObject]?)
                        
                        complition(scoreObject,nil)
                    }
                    catch {
                        print("Error decoding: \(error)")
                        complition(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let NetworkFailureError):
                    complition(nil, NetworkFailureError)
                }
            }
        }
    }
    
}

