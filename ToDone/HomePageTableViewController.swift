//
//  HomePageTableViewController.swift
//  ToDone
//
//  Created by عبدالوهاب العنزي on 30/06/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit

class HomePageTableViewController: UITableViewController {

    let ItemArray = ["A1","A2","A3","🆔"]
    override func viewDidLoad() {
        super.viewDidLoad()
        

     
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

}
