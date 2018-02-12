//
//  PosterCellCollectionViewCell.swift
//  Flix
//
//  Created by Simona Virga on 1/15/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class PosterCellCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie?
    {
        didSet
        {
            posterImageView.af_setImage(withURL: (movie?.posterURL)!)
        }
    }
    
}
