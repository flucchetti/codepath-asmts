//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Francesca on 12/17/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var userId: Int = -1
    var userDict = NSDictionary()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen_name = "f_francesca_f"
        
        TwitterAPICaller.client?.getUser(userID: screen_name, success: {(user: NSDictionary) in
            self.userDict = user
        }, failure: {(error: Error) in
            print("Could not retrieve user data")
        })

        self.loadData()
    }
    
    
    func loadData(){
        let numFollowers = self.userDict["followers_count"] as! Int
        let numFollowing = self.userDict["friends_count"] as! Int
        let tagline = self.userDict["name"] as! String
        let numTweets = self.userDict["statuses_count"] as! Int
        
        self.followerCount.text = "\(numFollowers)"
        self.followingCount.text = "\(numFollowing)"
        self.tweetCount.text = "\(numTweets)"
        self.tagLabel.text = tagline
        
        let imageURL = URL(string: (self.userDict["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)

        if let imageData = data {
            self.profileImage.image = UIImage(data: imageData)
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
