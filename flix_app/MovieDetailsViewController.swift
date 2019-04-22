//
//  MovieDetailsViewController.swift
//  flix_app
//
//  Created by Malcolm Treacy on 4/21/19.
//  Copyright © 2019 malctech. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    // Outlets at the top (preference)
    // 1. backdropView: This is the banner in the movies details view.
    @IBOutlet weak var backdropView: UIImageView!
    // 2. posterView: The is the smaller view of the selected movie
    @IBOutlet weak var posterView: UIImageView!
    // 3. titleLabel: the selected movie's title
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    // movie: Singular movie object of type dictionary, value any.
    // read more into swift optionals
    var movie: [String:Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        // .sizeToFit: Grow the synopsis to fit the available label
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        // Grow the synopsis to fit the available label
        synopsisLabel.sizeToFit()
        // baseURL is from the moviesDb json documentation
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        // posterPath url
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        // set the posterView
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        // set the posterView
        backdropView.af_setImage(withURL: backdropUrl!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
