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
    
    var movieDetails: MovieDetails?
    var movie: Movie?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getFocusedMovie()
        configPage()
    }
    
    func getFocusedMovie() {
        guard let movieId = movie?.id else { return}
        MovieDetailsWorker().fetchMovieDetails(
            of: movieId, // COLOQUE O ID DO FILME AQUI
            sucess: { details in
                guard let details = details else { return }
                let budget = (details.budget)
                let time = String(details.runtime)
                
                var professional = ""
                for crew in details.credits.crew{
                    professional = crew.name
                }
                
                        
                DispatchQueue.main.async {
                    self.budget.text = String(budget)
                    self.time.text = "\(time) min."
                    self.professional.text = professional
                    }
                
            },
            failure: { error in
                print(error!)
            })
    }
        
        func configPage() {
            DispatchQueue.main.async { [self] in
                self.focusedTitle.text = self.movie?.title
                self.overview.text = self.movie?.overview
                
                // imagem principal
                
                guard let posterPath = self.movie?.posterPath else { return }
                let imgPosterPath = MovieAPI.build(image: posterPath, size: MovieAPI.ImageSize.w200)
                if let url = URL(string:imgPosterPath){
                    focusedImg.sd_imageIndicator = SDWebImageActivityIndicator.medium
                    focusedImg.sd_setImage(with: url)
                }
                
                //imagem background
                guard let backdropPath = movie?.backdropPath else { return}
                let imgBackdropPath = MovieAPI.build(image: backdropPath, size: MovieAPI.ImageSize.w500)
                if let backdropURL = URL(string: imgBackdropPath){
                    backgroundImg.sd_imageIndicator = SDWebImageActivityIndicator.large
                    backgroundImg.sd_setImage(with: backdropURL)
                }
            }
        }
        
        
    }

