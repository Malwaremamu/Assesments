//
//  ContentView.swift
//  20220206-UdayBoyanapalli-NYCSchools
//
//  Created by Achint Lehal on 2/6/22.
//

import SwiftUI
import Foundation
import UIKit

struct APIConstants {
    static let satURL = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")
    static let nycSchoolURL = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
}

struct Response: Hashable, Codable {
    let dbn: String
    let school_name: String
    let primary_address_line_1: String
    let city: String
    let zip: String
    let state_code: String
    let phone_number: String
}

struct SATResponse: Hashable, Codable {
    let dbn: String
    let school_name: String
    let num_of_sat_test_takers: String
    let sat_critical_reading_avg_score: String
    let sat_math_avg_score: String
    let sat_writing_avg_score: String
}

struct FinalObject: Hashable, Codable{
    let dbn: String
    let school_name: String
    let primary_address_line_1: String
    let city: String
    let zip: String
    let state_code: String
    let phone_number: String
    
}

class ViewModel: ObservableObject {

    @Published var responses: [Response] = []
    @Published var satResponse: [SATResponse] = []
    @Published var finalObject: [SATResponse] = []
    
    func fetchSAT() {

        URLSession.shared.dataTask(with: APIConstants.satURL!) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Error")
                return
            }

            //Data

            do {
                let jsonObject = try JSONDecoder().decode([SATResponse].self, from: data)
                DispatchQueue.main.async {
                    self?.satResponse = jsonObject
                }
            } catch {
                print("\(error.localizedDescription)")
            }

        }.resume()
    }

    func fetchAPI() {

        URLSession.shared.dataTask(with: APIConstants.nycSchoolURL!) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Error")
                return
            }

            //Data

            do {
                let jsonObject = try JSONDecoder().decode([Response].self, from: data)
                DispatchQueue.main.async { [self] in
                    self?.responses = jsonObject
                    for values in self!.responses {
                        self?.finalObject.append(contentsOf: (self!.satResponse.filter({$0.dbn == values.dbn })))
                        
                    }
                }

            } catch {
                print("\(error.localizedDescription)")
            }

        }.resume()


    }

    func filterData() {
        fetchSAT()
        fetchAPI()
    }
}


struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.finalObject, id: \.self) { response in
                    HStack {
                        NYCSchoolNameRow(nycSchools: response)
//                        Text(response.school_name)
//                            .bold()
                    }
                    .padding(3)
                }
            }
            .navigationTitle("NYC High Schools")
            .onAppear {
                viewModel.filterData()
            }
        }
    }
}

