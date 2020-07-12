//
//  HomePageTableViewController.swift
//  ToDone
//
//  Created by عبدالوهاب العنزي on 30/06/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData



@available(iOS 13.0, *)
class HomePageTableViewController: UITableViewController{
    
    var ItemArray = [Item]()
    var selectedCategory : Category? {
        
        didSet{
            loadItems()
        }
    }

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //.first?.appendingPathComponent("Itrms.plist")
       // هذا الامر عشان يحفظ لك اخر شي وقفت عليه
    let defultes = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  searchBar.delegate = self
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        //        // برضو هذا الامر عشان يعرض لك التعديلات ويحفظ اخر شي سو المستخدم

        loadItems()
    }

    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ItemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = ItemArray[indexPath.row]
        
        
        cell.textLabel?.text = item.title
        
        // هذي if و else
        
        // Ternary operator ==>
        // value = condition ? valueIsTrue : valueIsFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        // الاختصار
        //        if item.done == true {
        //        cell.accessoryType = .checkmark
        //       }else {
        //        cell.accessoryType = .none
        //        }
        
        return cell
        
        
    }
    
    
    //Marke - TableView Delget Methods
    
    // هذا اذا حددت على الرو يعني اذا حددت على شي ينقلك الى الي تبي حسب الكود
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // يطبع لك رقم الصف الي حددت
        print(indexPath.row)
        //يطبع لك اسم الي حددت
        print(ItemArray[indexPath.row])
        
        //         context.delete(ItemArray[indexPath.row])
        //        ItemArray.remove(at: indexPath.row)
        
        
        ItemArray[indexPath.row].done = !ItemArray[indexPath.row].done
        saveItems()
        //        if ItemArray[indexPath.row].done == false {
        //            ItemArray[indexPath.row].done = true
        //        }else {
        //            ItemArray[indexPath.row].done = false
        //        }
        
        tableView.reloadData()
        // هذي يحط لك اذا تبي فيو مثلا اذا حددت عليه يطلع لك صح
        // هذي الامر حق التنفيذ
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // Marke - Add new item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        //        // نعرف متغير من نوع تكست عشان يحفظ لنا النص
        var textField = UITextField()
        //        let textFieldForNill = "New Item"
        //
        //
        let alert = UIAlertController(title: "Add New To Do item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .cancel) { (action) in
            
            
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.ItemArray.append(newItem)
            print(textField.text!)
            print("Success!")
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "ادخل النص"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func saveItems() {
        
        do{
            
            try context.save()
        }catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate:NSPredicate? = nil)
    {
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addtionalPredicate])
        }else {
            request.predicate = categoryPredicate
        }
        do {
            ItemArray =  try context.fetch(request)
        }catch {
            print("Error fetcheing data from context \(error)")
        }
        tableView.reloadData()
    }
    
    
}

//MARK: - Search bar methods
@available(iOS 13.0, *)
extension HomePageTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        print(searchBar.text!)
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
         
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
       
        
        loadItems(with: request , predicate: predicate)
      //
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
       
            // الكيبورد يختفي
            // عشان االضغط المتكرر
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
