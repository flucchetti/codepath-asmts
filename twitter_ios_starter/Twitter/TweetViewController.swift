//
//  TweetViewController.swift
//  Twitter
//
//  Created by Francesca on 12/17/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
    }
    

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString : tweetTextView.text,
                success: {self.dismiss(animated: true, completion: nil)},
                failure: {(error) in print("Error posting tweet \(error)")})
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Set the max character limit
        let characterLimit = 280

        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)

        characterCountLabel.text = "\(characterLimit - newText.count)"

        // The new text should be allowed? True/False
        return newText.count < characterLimit
    }
    


}
