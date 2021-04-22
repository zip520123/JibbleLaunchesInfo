//
//  LaunchTableViewCell.swift
//  JibbleLaunchesInfo
//
//  Created by zip520123 on 13/04/2021.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var launchNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var upcomingLabel: UILabel!
    
    func setData(_ launch: Launch) {
        nameLabel.text = launch.name
        launchNumberLabel.text = "flightNumber: " + String(launch.flightNumber)
        dateLabel.text = "date: " + launch.dateLocal.description
        upcomingLabel.text = launch.upcoming ? "upcoming" : ""
        detailLabel.text = launch.details
    }
}
