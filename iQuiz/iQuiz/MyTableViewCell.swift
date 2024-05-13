//
//  MyTableViewCell.swift
//  iQuiz
//
//  Created by Audrey Kim on 5/12/24.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    static let identifier = "MyTableViewCell"
//    
//    static func nib() -> UINib {
//        return UINib(nibName:"MyTableViewCell", bundle: nil)
//    }
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
