//
//  PATableViewCell.swift
//  HackatonsManager
//
//  Created by Nir Shervi on 27/06/2022.
//

import UIKit

class PATableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dept: UILabel!
    @IBOutlet weak var theme: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var parts: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
