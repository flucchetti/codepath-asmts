//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Francesca on 1/7/22.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let myRefreshControl =  UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    var numPosts = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        myRefreshControl.addTarget(self, action: #selector(queryPosts), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        queryPosts()
    }
    
    @objc func queryPosts(){
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
//        query.limit = numPosts
        
        query.findObjectsInBackground{(posts, error) in
            if posts != nil {
                self.posts = posts!
                self.posts = self.posts.reversed()
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
                print("Found posts")
            } else {
                print("Did not find posts")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell

        let post = posts[indexPath.row]

        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as! String

        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!

        cell.photoView.af.setImage(withURL: url)

        return cell
    }
    
    func onRefresh() {
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
