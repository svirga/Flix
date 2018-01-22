//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Simona Virga on 1/15/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

enum MovieKeys {
    static let title = "title"
    static let backdropImagePath = "backdrop_path"
    static let posterImagePath = "poster_path"
}

class MovieDetailsViewController: UIViewController
{

    @IBOutlet weak var movieBackdropImage: UIImageView!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String: Any]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let movie = movie
        {
            movieTitleLabel.text = movie[MovieKeys.title] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            
            let backdropImagePathString = movie[MovieKeys.backdropImagePath] as! String
            let posterImagePathString = movie[MovieKeys.posterImagePath] as! String
            let baseURL = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURL + backdropImagePathString)!
            movieBackdropImage.af_setImage(withURL: backdropURL)
            
            let posterURL = URL(string: baseURL + posterImagePathString)!
            moviePosterImage.af_setImage(withURL: posterURL)
            
            
            
        }
    }

   
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



