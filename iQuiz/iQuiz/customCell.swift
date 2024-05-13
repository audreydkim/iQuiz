//
//  customCell.swift
//  iQuiz
//
//  Created by Audrey Kim on 5/12/24.
//

import UIKit

class customCell: UITableViewCell {

    // MARK: - Variables
    static let identifier = "customCell"
    
    // MARK: - UI Components
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descr: UILabel!
    
    //    static func nib() -> UINib {
//        return UINib(nibName: "customCell", bundle: nil)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
