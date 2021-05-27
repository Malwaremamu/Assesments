//
//  SchoolBO.swift
//  20210525-UdayBoyanapalli-NYCSchools
//
//  Created by Boyanapalli, Uday on 5/25/21.
//

import Foundation

struct SchoolBO {
    var dbn:String
    var schoolName:String
    var address:String
    var totalStudents:String
    var website: String
    
    init(dbn:String, schoolName:String, address:String, totalStudents:String, website: String) {
        self.dbn = dbn
        self.schoolName = schoolName
        self.address = address
        self.totalStudents = totalStudents
        self.website = website
    }
}
