//
//  NYCSchoolNameRow.swift
//  20220206-UdayBoyanapalli-NYCSchools
//
//  Created by Achint Lehal on 2/6/22.
//

import SwiftUI

struct NYCSchoolNameRow: View {
    var nycSchools: SATResponse
    let satValues: [String] = ["SAT Test Takers", "Critical Reading Avg Score", "Math Avg Score", "Writing Average Score"]
    
    var body: some View {
        GroupBox() {
            DisclosureGroup(nycSchools.school_name.localizedCapitalized) {

                HStack {
                    Text(satValues[0])
                    Spacer(minLength: 25)
                    Text(nycSchools.sat_math_avg_score)
                }
                HStack {
                    Text(satValues[1])
                    Spacer(minLength: 25)
                    Text(nycSchools.sat_critical_reading_avg_score)
                }
                HStack {
                    Text(satValues[2])
                    Spacer(minLength: 25)
                    Text(nycSchools.sat_math_avg_score)
                }

                HStack {
                    Text(satValues[3])
                    Spacer(minLength: 25)
                    Text(nycSchools.sat_writing_avg_score)
                }
               
            }
            .font(Font.system(.body).bold())
            .foregroundColor(.black)
        }

    }
}
