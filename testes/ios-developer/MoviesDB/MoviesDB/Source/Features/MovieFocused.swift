//
//  MovieFocused.swift
//  MoviesDB
//
//  Created by Michelli Cristina de Paulo Lima on 18/12/21.
//

import UIKit
import SDWebImage

class MovieFocused: UIViewController {
    @IBOutlet weak var focusedTitle: UILabel!
    @IBOutlet weak var focusedImg: UIImageView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var professional: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
        
    var movieId: Int?
    var movieDetails: MovieDetails?
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFocusedMovie()
        configFocusedMovie()
    }
    
    //chama API
    func getFocusedMovie() {
        guard let movieId = self.movie?.id else { return }
        MovieDetailsWorker().fetchMovieDetails(
            of: movieId,
            sucess: { [self] details in
                guard let details = details else { return }
                
                var getTime = ("\(details.runtime) minutos")
                var getBudget = ("\(details.budget) dolars")
                var getProfessional = ""
                for cast in details.credits.cast{
                    getProfessional += cast.name + ", "
                }
                DispatchQueue.main.async {
                    self.time.text = getTime
                    self.budget.text = getBudget
                    self.professional.text = getProfessional
                    
                }
                
            },
            failure: { error in
                print(error!)
            })
    }
     
    
    // Substituindo informações do main pelas informações do Movie
    func configFocusedMovie() {
        self.focusedTitle.text = self.movie?.title
        self.overview.text = self.movie?.overview
        
        guard let posterPath = movie?.posterPath else { return }
        let imgPath = MovieAPI.build(image: posterPath, size: MovieAPI.ImageSize.w300)
            if let url = URL(string:imgPath){
                focusedImg.sd_imageIndicator = SDWebImageActivityIndicator.medium
                focusedImg.sd_setImage(with: url)
        }
        guard let backgroundPath = movie?.backdropPath else { return}
        let imgBackground = MovieAPI.build(image: backgroundPath, size: MovieAPI.ImageSize.w500)
            if let backdropURL = URL(string: imgBackground){
                backgroundImg.sd_imageIndicator = SDWebImageActivityIndicator.large
                backgroundImg.sd_setImage(with: backdropURL)
        }
    }
        
}

