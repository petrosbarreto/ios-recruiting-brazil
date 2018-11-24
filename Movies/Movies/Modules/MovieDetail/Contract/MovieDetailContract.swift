//
//  MovieDetailContract.swift
//  Movies
//
//  Created by Renan Germano on 24/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

protocol MovieDetailView: class {
    
    var presenter: MovieDetailPresentation! { get set }
    
}

protocol MovieDetailPresentation {
    
    var view: MovieDetailView? { get set }
    var router: MovieDetailWireframe! { get set }
    var interactor: MovieDetailUseCase! { get set }
    
}

protocol MovieDetailUseCase {
    
    var output: MovieDetailInteractorOutput! { get set }
    
}

protocol MovieDetailInteractorOutput {
    
    
    
}

protocol MovieDetailWireframe {
    
    var view: UIViewController? { get set }
    
}
