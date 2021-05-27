//
//  NYCTableViewCell.swift
//  20210525-UdayBoyanapalli-NYCSchools
//
//  Created by Boyanapalli, Uday  on 5/25/21.
//

import UIKit

class NYCTableViewCell: UITableViewCell {
    
    //MARK:- Label Outlets
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var totalStudents: UILabel!
    @IBOutlet weak var website: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
