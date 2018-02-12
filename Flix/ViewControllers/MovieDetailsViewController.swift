//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Simona Virga on 1/15/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

enum MovieKeys{
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
    
    var movie: Movie?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let movie = movie
        {
            movieTitleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            
            movieBackdropImage.af_setImage(withURL: movie.backdropURL!)
            movieBackdropImage.layer.zPosition = -5;
            
            moviePosterImage.af_setImage(withURL: movie.posterURL!)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



