import CoreData
import UIKit
class DataBaseManager {
    static let shared = DataBaseManager()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    var userData = [SearchedMovie]()
  
    func save(_ data: [Result]){
        let context = self.appDelegate.persistentContainer.viewContext
        // let _register = NSEntityDescription.entity( forEntityName: "RegisterList", in: context) as? RegisterList
//        let register = NSEntityDescription.insertNewObject(forEntityName: "SearchedMovieList", into: context) as! SearchedMovieList
//        let userRegisterData = data
//        register.movieImage = userRegisterData.movieImage
//        register.movieName = userRegisterData.movieName
//        register.id = userRegisterData.
        
        
        for user in data {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "SearchedMovie", into: context)
            newUser.setValue(user.id, forKey: "id")
            newUser.setValue(user.title, forKey: "movieName")
            newUser.setValue(user.posterPath, forKey: "movieImage")
        }
        do {
            try context.save()
        } catch let error {
            print("save error", error.localizedDescription)
        }
    }
    
    
     let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchedMovie")
    
    func fetch() -> [SearchedMovie] {
        let context = self.appDelegate.persistentContainer.viewContext
        do{
            userData = try context.fetch(SearchedMovie.fetchRequest())
            
        }catch{
            debugPrint("")
        }
        return userData
    }
   
    func deleteData(results: [Result]) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let  fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchedMovie")
        //fetchRequest.predicate = NSPredicate(format: "username = %@", "mps 2")
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else {
                return
            }
            
            for iten in result {
                managedContext.delete(iten)
            }
            //  guard let objc = result.first else { return }
            // managedContext.delete(objc)
            do {
                try managedContext.save()
                debugPrint("Record deleted")
            } catch let error as NSError {
                debugPrint(error)
            }
        } catch let error as NSError {
            debugPrint(error)
        }
        //self.save(results)
        
    }
    
    func updateData(result: Result?){
        
        let allData = self.fetch()
        //self.deleteData(results: lastFive)
        if allData.count <= 5 {
            guard let reresultData = result else{
                return
            }
            let context = self.appDelegate.persistentContainer.viewContext
      
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "SearchedMovie", into: context)
            newUser.setValue(reresultData.id, forKey: "id")
            newUser.setValue(reresultData.title, forKey: "movieName")
            newUser.setValue(reresultData.posterPath, forKey: "movieImage")
            
            do {
                try context.save()
            } catch let error {
                print("save error", error.localizedDescription)
            }
        }else {
            var lastFive = [Result]()
            let reutlAllData = allData.suffix(5)
            
//          
            self.save(lastFive)
        }
        
    }
}
