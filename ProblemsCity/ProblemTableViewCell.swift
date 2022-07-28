//
//  ProblemTableViewCell.swift
//  ProblemsCity
//
//  Created by Lucas Oliveira de Borba on 27/07/22.
//

import UIKit

class ProblemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageViewProblem: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureWith(_ problem: Problem){
        labelName.text = problem.name
        labelAddress.text = problem.address
        labelDate.text = problem.date
        if let image = problem.image{
        imageViewProblem.image = UIImage(data: image)
            
        }
    }
}
