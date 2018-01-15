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
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
