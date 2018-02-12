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
    var movies: [Movie] = []
    
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.didPullRefresh(_:)), for: .valueChanged)
        movieTableView.insertSubview(refreshControl, at: 0)
        
        movieTableView.dataSource = self
        
        getNetworkRequest()
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
 
        cell.movie = movies[indexPath.row]
        
        return cell
    }
    
    
    func getNetworkRequest()
    {
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies
            {
                self.movies = movies
                self.movieTableView.reloadData()
            }
        }
        
        self.movieTableView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    
    @objc func didPullRefresh(_ refreshControl: UIRefreshControl)
    {
        getNetworkRequest()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let cell = sender as! UITableViewCell
        if let indexPath = movieTableView.indexPath(for: cell )
        {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! MovieDetailsViewController
            detailViewController.movie = movie
        }
    }
    
    
    
    
}



