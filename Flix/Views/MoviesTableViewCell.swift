//
//  MoviesTableViewCell.swift
//  Flix
//
//  Created by Simona Virga on 1/10/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell
{

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    //var movie: Movie!
    
    var movie: Movie?
    {
        didSet {
            movieTitleLabel.text = movie?.title
            movieDescriptionLabel.text = movie?.overview
            posterImage.af_setImage(withURL: (movie?.posterURL)!)
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
