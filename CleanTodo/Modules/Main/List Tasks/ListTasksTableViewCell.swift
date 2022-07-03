//
//  ListTasksTableViewCell.swift
//  CleanSwift
//
//  Created by Kirill Drozdov on 02.07.2022.
//

import UIKit

class ListTasksTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet var taskLabel: UILabel!
    
    // MARK: TableViewCell LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
