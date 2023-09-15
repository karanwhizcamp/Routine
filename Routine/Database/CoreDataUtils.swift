//
//  CoreDataUtils.swift
//  Routine
//
//  Created by 한현규 on 2023/09/14.
//


import UIKit
import CoreData




extension NSManagedObjectContext{    
    static func mainContext() throws -> NSManagedObjectContext{
        var mainContext: NSManagedObjectContext?
        
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as? AppDelegate
            mainContext = delegate?.persistentContainer.viewContext
        }
        
        if mainContext == nil{
            throw DBError.CoreDataError(reason: "Main Context nil")
        }

        return mainContext!
    }
    
    
    func query<T>(_ query: NSFetchRequest<T>) -> [T]{
        let object: [T]
        do{
            object =  try self.fetch(query)
        }catch let err{
            object = []
            print(err)
        }
        
        return object
    }
}

extension NSManagedObject{
    static var entityName: String {
      return String(describing: self)
    }
}
