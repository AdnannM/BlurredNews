//
//  NewsTableViewController.swift
//  BlurredNews
//
//  Created by Adnann Muratovic on 03.09.21.
//

import UIKit

final class NewsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 400.0
        tableView.rowHeight = UITableView.automaticDimension
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell

        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "red-lights-lisbon")
            cell.postTitle.text = "Red Lights, Lisbon"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            cell.postAuthor.text = "Adnann Muratovic (@adnann)"
        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "red-lights-lisbon")
            cell.postTitle.text = "Red Lights, Lisbon"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            cell.postAuthor.text = "Adnann Muratovic (@adnann)"
        } else if indexPath.row == 2 {
            cell.postImageView.image = UIImage(named: "red-lights-lisbon")
            cell.postTitle.text = "Red Lights, Lisbon"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            cell.postAuthor.text = "Adnann Muratovic (@adnann)"
        } else {
            cell.postImageView.image = UIImage(named: "red-lights-lisbon")
            cell.postTitle.text = "Red Lights, Lisbon"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            cell.postAuthor.text = "Adnann Muratovic (@adnann)"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
