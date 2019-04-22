//
//  MoviesViewController.swift
//  flix_app
//
//  Created by Malcolm Treacy on 4/13/19.
//  Copyright © 2019 malctech. All rights reserved.
//

import UIKit
import AlamofireImage
// Add classes: UIViewController, UITableViewDelegate to allow movies view controller to work with table.
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // variables created here are called properties and they are available for the lifetime of the screen
    //creates an array of dictionaries
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String:Any]]()
    // this is a special function the first time a screen loads up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // example of casting, casting as an array of dictionaries
                self.movies = dataDictionary["results"] as! [[String:Any]]
                // waits for the data to arrive
                self.tableView.reloadData()
                print(dataDictionary)
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    // manages rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // manages cells in row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tells the processor to reuse cells that are off-screen, if there are non available then create a new one.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        // get the current movie from the JSON
        let movie = movies[indexPath.row]
        // get the movie title from the JSON, cast it as a String
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        //? == swift optionals
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        cell.posterView.af_setImage(withURL: posterUrl!)
        return cell
    }
    
    // Prepare: prepares the content for moving into the next view
    // Sender: the cell that was tapped on
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        // 1. Find the selected movie
        let cell = sender as! UITableViewCell
        // 2. Determine the indexPath for a given cell
        let indexPath = tableView.indexPath(for: cell)!
        // 3. Get the selected movie from the selected cell, and determine its
        // index path (step 2).
        let movie = movies[indexPath.row]
        // 4. Pass the selected movie to the details view controller
        // Segue knows where it is going, but it needs to be casted as a
        // MoviesDetailViewController (not the generic version).
        let detailsViewController = segue.destination as! MovieDetailsViewController
        // refer to the selected movie here
        detailsViewController.movie = movie
        // 5. Deselect the row when the user comes back to the MoviesView
        tableView.deselectRow(at: indexPath, animated: true)
    }
 

}
