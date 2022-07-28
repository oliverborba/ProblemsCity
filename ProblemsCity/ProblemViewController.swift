//
//  ProblemViewController.swift
//  ProblemsCity
//
//  Created by Lucas Oliveira de Borba on 27/07/22.
//

import UIKit

class ProblemViewController: UIViewController {

    
    @IBOutlet weak var imageViewProblem: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    
    var problem: Problem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let problemFormViewController = segue.destination as? ProblemFormViewController{
            problemFormViewController.problem = problem
        }
    }
    
    
    
    func prepareScreen(){
        if let problem = problem{
            if let image = problem.image{
                imageViewProblem.image = UIImage(data: image)}
            labelName.text = problem.name
            labelAddress.text = problem.address
            labelDate.text = problem.date
            textViewDescription.text = problem.occurrence
        }
    }
    
}

