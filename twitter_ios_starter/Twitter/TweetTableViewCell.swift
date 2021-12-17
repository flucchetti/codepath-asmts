//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Francesca on 12/9/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var favorited:Bool = false
    var tweetId: Int = -1

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.favButton.setTitle("", for: .normal)
        self.retweetButton.setTitle("", for: .normal)
    }

    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if favorited {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if  (isRetweeted) {
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func favoriteTweet(_ sender : Any){
        let toBeFavorited = !self.favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {self.setFavorite(true)}, failure: {(error) in print("Favorite did not succeed \(error)")})
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {self.setFavorite(false)}, failure: {(error) in print("Unfavorite did not succeed \(error)")})
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {self.setRetweeted(true)}, failure: {(error) in print("Retweet did not succeed \(error)")})
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
