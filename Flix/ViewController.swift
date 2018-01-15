//
//  ViewController.swift
//  Flix
//
//  Created by Simona Virga on 1/10/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource
{
    
    var refreshControl: UIRefreshControl!
    var movies: [[String: Any]] = []
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Start the activity indicator
        activityIndicator.startAnimating()
        
        // Stop the activity indicator
        // Hides automatically if "Hides When Stopped" is enabled
       
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.didPullRefresh(_:)), for: .valueChanged)
        
        movieTableView.insertSubview(refreshControl, at: 0)
        
        movieTableView.dataSource = self
        
        getNetworkRequest()
         activityIndicator.stopAnimating()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell
        
        let movie = movies[indexPath.row]
        let movieTitle = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.movieTitleLabel.text = movieTitle
        cell.movieDescriptionLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImage.af_setImage(withURL: posterURL)
        
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
                self.movieTableView.reloadData()
                self.refreshControl.endRefreshing()
                
                /* for movie in movies
                 {
                 let title = movie["title"] as! String
                 print(title)
                 }*/
            }
        }
        dataTask.resume()
    }
    
    @objc func didPullRefresh(_ refreshControl: UIRefreshControl)
    {
        getNetworkRequest()
    }
    
}

