//
//  MovieDetailsViewController.swift
//  week1-flix
//
//  Created by Francesca on 12/3/21.
//

import UIKit
import AlamofireImage
import SwiftUI

class MovieDetailsViewController: UIViewController {

    var movie : [String:Any]!
    var videoResponse : [[String:Any]]!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!{ didSet { posterView.isUserInteractionEnabled = true }}
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieID = movie["id"] as! Int
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/" + String(movieID) + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    
                 self.videoResponse = dataDictionary["results"] as? [[String:Any]]
             }
        }
        task.resume()
        

        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        dateLabel.text = movie["release_date"] as? String
        dateLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af.setImage(withURL: backdropUrl!)
    }
    

    @IBAction func didTapPoster(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "trailerSegue", sender: sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let video = videoResponse[0]
        let key = video["key"] as! String
        let trailerViewController = segue.destination as! TrailerViewController
        trailerViewController.movieURL = URL(string :"https://www.youtube.com/watch?v=" + key)
        
    }
}

struct MovieDetailsViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
