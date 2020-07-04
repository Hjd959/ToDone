//
//  HomePageTableViewController.swift
//  ToDone
//
//  Created by عبدالوهاب العنزي on 30/06/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit

class HomePageTableViewController: UITableViewController {

    var ItemArray = ["A1","A2","A3","🆔"]
    
    // هذا الامر عشان يحفظ لك اخر شي وقفت عليه
    let defultes = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // برضو هذا الامر عشان يعرض لك التعديلات ويحفظ اخر شي سو المستخدم 
        if let items = defultes.array(forKey: "ToDoListArray") as? [String]{
            ItemArray = items
        }

     
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ItemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        
        
        cell.textLabel?.text = self.ItemArray[indexPath.row]

        return cell
      
        
    }
    

    //Marke - TableView Delget Methods
    
    // هذا اذا حددت على الرو يعني اذا حددت على شي ينقلك الى الي تبي حسب الكود
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // يطبع لك رقم الصف الي حددت
        print(indexPath.row)
        //يطبع لك اسم الي حددت
        print(ItemArray[indexPath.row])
        
        // هذي يحط لك اذا تبي فيو مثلا اذا حددت عليه يطلع لك صح
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        // هذي الامر حق التنفيذ
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        // نعرف متغير من نوع تكست عشان يحفظ لنا النص
        var textField = UITextField()
        let textFieldForNill = "New Item"
    
        
        let alert = UIAlertController(title: "Add New To Do item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .cancel) { (action) in
            // اي شي يحدث لازم تحطه هنا
            
            print("Success!")
              print([self.ItemArray])
         //   self.ItemArray.append(textField.text ?? "")
          //  self.ItemArray.append(textField.text)
            
            if textField.text != ""{
                self.ItemArray.append(textField.text!)
            }else {
                // اذا حط قيمة فارغه حوله لي الى النص المكتوب مسبقاً
                self.ItemArray.append(textFieldForNill)
            }
            
            // عشان يحفظ لك اخر شي وقفت عليه
            self.defultes.set(self.ItemArray, forKey: "ToDoListArray")
            print(textField.text!)
            self.tableView.reloadData()
        
        }
        
    
        // اضافة نص بشكل مخفي على الحقل
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "ادخل النص"
            textField = alertTextField
            
           
        }
        // بدون هذا الكود ما راح يشتغل هذا تفعيل لل alert
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
}
