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
    
    
    var movies: [[String: Any]] = []
    
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
        let movie = movies[indexPath.item]
       
        if let posterPathString = movie["poster_path"] as? String
        {
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURL + posterPathString)!
            cell.posterImageView.af_setImage(withURL: posterURL)
        }
        
        return cell
        
    }
    
    func getNetworkRequest()
    {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            
            if let error = error
            {
                print(error.localizedDescription)
            }
            else if let data = data
            {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.collectionView.reloadData()
               // self.refreshControl.endRefreshing()
                
                /* for movie in movies
                 {
                 let title = movie["title"] as! String
                 print(title)
                 }*/
            }
        }
        dataTask.resume()
    }
}
