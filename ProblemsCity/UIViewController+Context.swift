//
//  UIViewController+Context.swift
//  ProblemsCity
//
//  Created by Lucas Oliveira de Borba on 28/07/22.
//

import Foundation
import UIKit
import CoreData

extension UIViewController{
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
