//
//  SATViewController.swift
//  20210525-UdayBoyanapalli-NYCSchools
//
//  Created by Boyanapalli, Uday on 5/26/21.
//

import UIKit
import Alamofire

class SATViewController: UIViewController {

    //MARK:- Label Outlets
    @IBOutlet weak var lblSchoolName: UILabel!
    @IBOutlet weak var lblMathScore: UILabel!
    @IBOutlet weak var lblReadingScore: UILabel!
    @IBOutlet weak var lblWritingScore: UILabel!
    @IBOutlet weak var lblSatTestTakers: UILabel!
    
    var dbn:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Alamofire request for SAT API.
        AF.request("https://data.cityofnewyork.us/resource/f9bf-2cp4.json")
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [AnyObject]{
                    self.showSATDetails(data: json)
                }
            case .failure(_):
                print("Error")
            }
        }
    }
   
    //MARK:- Methods
    /// Filtering Json data with dbn code
    /// - Parameter data: json data received from SAT API.
    func showSATDetails(data:[AnyObject]){
        
        let satDls = data.filter{
            return $0["dbn"] as! String == self.dbn
        }
        
        if(satDls.count > 0){
            let SATItem = satDls[0]
            let satTestTakers = SATItem["num_of_sat_test_takers"] as! String
            let satCritical = SATItem["sat_critical_reading_avg_score"] as! String
            let satMathScore = SATItem["sat_math_avg_score"] as! String
            let satWritingScore = SATItem["sat_writing_avg_score"] as! String
            let satSchoolName = SATItem["school_name"] as! String
           
            DispatchQueue.main.async {
                self.lblSchoolName.text = "School Name: \(satSchoolName)"
                self.lblMathScore.text = "Math Score: \(satMathScore)"
                self.lblReadingScore.text = "Reading Score: \(satCritical)"
                self.lblWritingScore.text = "Writing Score: \(satWritingScore)"
                self.lblSatTestTakers.text = "Number of Test Takers: \(satTestTakers)"
                
            }
            
            
        }
    }

}
