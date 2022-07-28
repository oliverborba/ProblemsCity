//
//  ProblemsTableViewController.swift
//  ProblemsCity
//
//  Created by Lucas Oliveira de Borba on 27/07/22.
//

import UIKit
import CoreData

class ProblemsTableViewController: UITableViewController {
    
    var fetchedresultsController: NSFetchedResultsController<Problem>!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadProblems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let problemViewController =  segue.destination as? ProblemViewController,
              let indexPath = tableView.indexPathForSelectedRow{
                problemViewController.problem = fetchedresultsController.object(at: indexPath)
        }
    }
    
    func loadProblems(){
        let fetchRequest: NSFetchRequest<Problem> = Problem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
       fetchedresultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedresultsController.delegate = self
        try? fetchedresultsController.performFetch()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedresultsController.fetchedObjects?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProblemTableViewCell else{
            return UITableViewCell()
            
        }
                
        let problem = fetchedresultsController.object(at: indexPath )
       cell.configureWith(problem)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let problem = fetchedresultsController.object(at: indexPath)
            context.delete(problem)
            try? context.save()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProblemsTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        tableView.reloadData()
    
    }
}
