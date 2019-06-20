//
//  TableViewController.swift
//  finalAPP
//
//  Created by User20 on 2019/6/16.
//  Copyright © 2019 ouo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var cartoons = [Cartoon]()
    var num = 0
    
    @IBAction func unwindToLoverTableView(segue: UIStoryboardSegue) {
        print("push done")
        if let controller = segue.source as? EditCartoonTableViewController, let cartoon = controller.cartoon {
            
            cartoons.insert(cartoon, at: 0)
            Cartoon.saveToFile(cartoons: cartoons)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            print("fuck you!!!!!!!! finish")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if num < 1
        {
            if let urlString = "https://api.myjson.com/bins/nowy5".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
             let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                 let decoder = JSONDecoder()
                 if let data = data, let cartoons = try? decoder.decode([Cartoon].self, from: data) {
                    //self.cartoons = cartoons
                     for cartoon in cartoons{
                        self.cartoons = cartoons
                     }
                    if let cartoons = Cartoon.readCartoonsFromFile() {
                        self.cartoons = cartoons
                        for cartoon in cartoons{
                            self.num = self.num+1
                         //self.cartoons.append(cartoon)
                        }
                        print("num = "+String(self.num))
                    }
                     DispatchQueue.main.async {
                        self.tableView.reloadData()
                     }
                     print(cartoons)
                 }
             
                }
                 print("hello?")
                 task.resume()
             }
        }
        
        if let cartoons = Cartoon.readCartoonsFromFile() {
            self.cartoons = cartoons
            /*for cartoon in cartoons{
                self.cartoons.append(cartoon)
            }*/
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("count = "+String(cartoons.count))
        return cartoons.count
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        cartoons.remove(at: indexPath.row)
        Cartoon.saveToFile(cartoons: cartoons)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartoonCell", for: indexPath) as! CartoonTableViewCell
        print("fuck you!!!!!!!!")
        // Configure the cell...
        let cartoon = cartoons[indexPath.row]
        cell.nameLabel?.text = cartoon.name
        print(cartoon.name)
        print(cartoons.count)
        if indexPath == [0,cartoons.count-1] || indexPath == [0,cartoons.count-2]
        {
            let url = URL(string:cartoon.imageName)
            cell.photoImage.kf.setImage(with: url)
        }
        else{
            let url = Cartoon.documentsDirectory.appendingPathComponent(cartoon.imageName).appendingPathExtension("jpg")
            cell.photoImage.image = UIImage(contentsOfFile: url.path)
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let controller = segue.destination as? CartoonViewController, let row = tableView.indexPathForSelectedRow?.row {
            controller.cartoons = [cartoons[row]]
            print([cartoons[row]])
            print(row)
            }
        }

}
