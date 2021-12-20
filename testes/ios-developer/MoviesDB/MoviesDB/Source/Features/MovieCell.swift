//
//  MovieCell.swift
//  MoviesDB
//
//  Created by Michelli Cristina de Paulo Lima on 17/12/21.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var mediaCell: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var countCell: UILabel!
    
    var movie: Movie?
 
    // configuração das celulas
    func configCell(movie: Movie){
        self.movie = movie
        
        titleCell.text = movie.title
        mediaCell.text = String(movie.voteAverage)
        countCell.text = String(movie.voteCount)
        
        guard let posterPath = movie.posterPath else { return }
        let imgPath = MovieAPI.build(image: posterPath, size: MovieAPI.ImageSize.w500)
        if let url = URL(string:imgPath){
            imgCell.sd_imageIndicator = SDWebImageActivityIndicator.medium
            imgCell.sd_setImage(with: url)
        }
    }
}
