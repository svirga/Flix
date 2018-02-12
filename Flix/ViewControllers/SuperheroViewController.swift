//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Simona Virga on 1/15/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource
{

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var movies: [Movie] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        collectionView.dataSource = self
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumLineSpacing = flowLayout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 2
        let interItemSpacingTotal = flowLayout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        flowLayout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        getNetworkRequest()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCellCollectionViewCell
        
        cell.movie = movies[indexPath.item]
        
        return cell
    }
    
    func getNetworkRequest()
    {
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies
            {
                self.movies = movies
                self.collectionView.reloadData()
            }
        }
        
        self.collectionView.reloadData()
        
    }
}
