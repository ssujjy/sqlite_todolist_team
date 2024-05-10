//
//  TableViewController.swift
//  SimpleTodoList
//
//  Created by 박정민 on 5/3/24.
//

import UIKit

class SQLTableViewController: UITableViewController {
    
    @IBOutlet var tvTableTodolist: UITableView!
    
    var dataArrayEx: [TodoLists] = []

    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        readValues()
    }
    
    
    
    
    func readValues(){
        let todoListDB = TodoListDB()
        dataArrayEx.removeAll()
        todoListDB.delegate = self
        todoListDB.queryDB()
        tvTableTodolist.reloadData()
    }
    

    @IBAction func btnInsertItem(_ sender: UIBarButtonItem) {
        let addAlert = UIAlertController(title: "Todo List", message: "추가할 내용을 입력하세요!", preferredStyle: .alert)
        addAlert.addTextField{ACTION in
            ACTION.placeholder = "추가 내용"
        }
       
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        let okAction = UIAlertAction(title: "추가", style: .default, handler: {ACTION in
            guard let tfTodo = addAlert.textFields![0].text else {return}
            
            let todoListDB = TodoListDB()
            let todoItem = tfTodo
            
            _ = todoListDB.insertDB(todoItem: todoItem)
            self.readValues()
            
            
        })
        addAlert.addAction(cancelAction)
        addAlert.addAction(okAction)
        
        present(addAlert, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArrayEx.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTodoCell", for: indexPath)

        // Configure the cell...
        var content = cell.defaultContentConfiguration()
        content.text = dataArrayEx[indexPath.row].items
        content.image = UIImage(systemName: "square.and.arrow.up")
        
        cell.contentConfiguration = content
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
            let todolistsDB = TodoListDB()
            
            let id = dataArrayEx[indexPath.row].id
            
            print(id)
            
            _ = todolistsDB.deleteDB(id: Int32(id))
            
            readValues()
            
//            if result {
//                dataArrayEx.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
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




extension SQLTableViewController: QueryModelProtocol{
    func itemDownloaded(items: [TodoLists]) {
        dataArrayEx = items
        tvTableTodolist.reloadData()
    }
    
}
