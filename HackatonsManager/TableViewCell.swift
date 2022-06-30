//
//  TableViewCell.swift
//  HackatonsManager
//
//  Created by Nir Shervi on 25/06/2022.
//

import UIKit


protocol TableViewNew {
    func onClickMe(index: Int)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dept: UILabel!
    @IBOutlet weak var theme: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var parts: UILabel!
    
    var cellDelegate: TableViewNew?
    var index: IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func subscribe(_ sender: Any) {
        cellDelegate?.onClickMe(index: (index?.row)!)
    }
}
