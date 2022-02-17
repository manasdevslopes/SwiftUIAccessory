//
//  CoreDataRelationshipsViewModel.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 16/02/22.
//

import SwiftUI
import CoreData

class CoreDataManager {
    // Singleton class
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error  {
                print("Error loading core data \(error.localizedDescription)")
                return
            } else {
                print("Successfully loaded Core Data!")
            }
        }
        context = container.viewContext
    }
    
    func saveData() {
        do {
            try context.save()
            print("Saved successfully!")
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipsViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployee()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
        // let filter = NSPredicate(format: "name == %@", "Apple")
        // request.predicate = filter
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
        // add existing departments to the new business
        // newBusiness.departments = [departments[0], departments[1]]
        
        // add existing employees to the new business
        // newBusiness.employees = [employees[1]]
        
        // add new business to the existing department
        // newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new business to the existing employee
        // newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartments() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
        
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
        // newDepartment.employees = [employees[1]]
        newDepartment.addToEmployees(employees[1])
        save()
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 21
        newEmployee.dateJoined = Date()
        newEmployee.name = "John"
        
        newEmployee.business = businesses[2]
        newEmployee.department = departments[1]
        
        save()
    }
    
    func getEmployee() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getEmployees(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func updateBusiness() {
        let existingBusiness = businesses[2]
        existingBusiness.addToDepartments(departments[0])
        
        save()
    }
    
    func deleteDepartment() {
        let department = departments[1]
        manager.context.delete(department)
        save()
    }
    
    func save() {
        // force reload whole screen
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.manager.saveData()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployee()
        }
    }
}


/* Deletion Rule: -
    1. Nullify - it will delete only particular item say Finace department and not the sub elements like Businesses and Employees
    2. Cascade -  it will delete everything inside Finance department
    3. Deny - It will do nothing even Finance not able to delete itself on button click.
 
 
 */
