//
//  CoreDataManager.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 15.08.2022.
//

import Foundation
import CoreData

import UIKit
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    private init() {}
    
    // MARK: Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "geo_reminder")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            //проверить корректность выбора политики
        })
//        Вывод адреса где лежит БД
        print("CoreData: \(String(describing: container.persistentStoreCoordinator.persistentStores.first?.url))")
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
}
