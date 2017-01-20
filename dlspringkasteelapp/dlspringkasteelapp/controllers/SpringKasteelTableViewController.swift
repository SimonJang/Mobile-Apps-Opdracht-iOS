//
//  SpringKasteelTableViewController.swift
//  dlspringkasteelapp


import UIKit

class SpringKasteelTableViewController: UITableViewController {
    
    var springKastelen:[Springkasteel:Int] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    private func loadData() {
        springKastelen = ReservationManager.haalSpringkastelenOp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return springKastelen.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "springkasteelCel", for: indexPath)
        let keys = Array(springKastelen.keys)
        
        let aantal = springKastelen[keys[indexPath.row]]

        cell.textLabel?.text = "\(keys[indexPath.row].rawValue) (beschikbaar: \(String(describing: aantal!)))"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
