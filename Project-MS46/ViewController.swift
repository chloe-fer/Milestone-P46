//
//  ViewController.swift
//  Project-MS46
//
//  Created by Chloe Fermanis on 18/8/21.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList: [String] = ["Milk", "Ice Cream", "Tim Tam Biscuits"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Shopping List"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteList))
        
        // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target:self, action: #selector(shareTapped))
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
       
        navigationItem.rightBarButtonItems = [shareButton, addButton]
        
        // Show Toolbar and set color
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.barTintColor = .systemPink
    }
    
    @objc func deleteList() {
        // Delete shopping List
        self.shoppingList = []
        tableView.reloadData()
    }
    
    @objc func shareTapped() {
        
        let list = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addItem = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.add(answer)
        }
        
        ac.addAction(addItem)
        present(ac, animated: true)
    }
    
    
    func add(_ answer: String) {
        shoppingList.insert(answer, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        // Set text color of the cell
        //cell.textLabel?.textColor = .pink
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Delete cell with swipe
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}

