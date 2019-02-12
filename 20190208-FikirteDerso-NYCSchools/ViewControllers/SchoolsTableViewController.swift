//
//  SchoolsTableViewController.swift
//  20190208-FikirteDerso-NYCSchools
//
//  Created by Fikirte  Derso on 2/8/19.
//  Copyright © 2019 Fikirte  Derso. All rights reserved.
//

import UIKit

class SchoolsTableViewController: UITableViewController {
    
    var schoolsArray:[School] = []
    var satScorsArray:[SATScore] = []
    static let satScoreCache = NSCache<AnyObject, AnyObject>()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Get School data
        self.getSchoolData()
    }
    
    func getSchoolData() {
        let networkManager = NetworkManager()
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
        networkManager.getSchoolsFromURL(queryItems: nil) { (schools:[School]?, error:String?) in
            if error != nil {
                print("Network Error School List: \(String(describing: error))")
            }
            else {
                if let schoolsList = schools {
                    self.schoolsArray = schoolsList
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = schoolsArray[indexPath.row].schoolName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedSchool = self.schoolsArray[indexPath.row]
        
        //check cached score data for selected school
        if let selectedSchoolName = selectedSchool.schoolName {
            //get cached score data for chool
            self.getCachedData(key: selectedSchoolName) { (cachedSatScore:SATScore?) in
                
                if let cachedSatScore = cachedSatScore {
                    self.loadDetailViewForSchool(selectedSchool: selectedSchool, satScore: cachedSatScore)
                } else {
                    //downlad score data for school
                    let networkManager = NetworkManager()
                    let queryItem = [URLQueryItem(name: Constants.JSONResponseKey.SchoolName, value: selectedSchool.schoolName?.uppercased())]
                    
                    //get score data for selected school
                    networkManager.getSatScoresFromURL(queryItems: queryItem) { (satScore:SATScore?, error:String?) in
                        if error != nil {
                            print("Network Error geting SATScore data: \(String(describing: error))")
                        }
                        else {
                            if let satScore = satScore {
                                DispatchQueue.main.async {
                                    // cache score data
                                    SchoolsTableViewController.satScoreCache.setObject(satScore as AnyObject, forKey: selectedSchool.schoolName as AnyObject)
                                    self.loadDetailViewForSchool(selectedSchool: selectedSchool, satScore: satScore)
                                }
                            }
                        }
                    }
                }
            } 
            
        }
  
    }
    
    func loadDetailViewForSchool(selectedSchool:School, satScore:SATScore) {
        self.activityIndicator.stopAnimating()
        let storyboared = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let schoolsDetailViewController = storyboared.instantiateViewController(withIdentifier: "SchoolsDetailViewController") as! SchoolsDetailViewController
        schoolsDetailViewController.schoolDetail = selectedSchool
        schoolsDetailViewController.satScores = satScore
        self.navigationController?.pushViewController(schoolsDetailViewController, animated: true)
    }
    
    func getCachedData(key:String, completion: @escaping (_ cachedData:SATScore?)->()) {
        if let data = SchoolsTableViewController.satScoreCache.object(forKey: key as AnyObject) {
            completion(data as? SATScore)
        }
        else {
            completion(nil)
        }
    }
    
}
