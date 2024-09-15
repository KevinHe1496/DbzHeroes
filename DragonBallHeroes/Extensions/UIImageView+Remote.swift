//
//  UIImageView+Remote.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 15/9/24.
//

import UIKit

extension UIImageView{
    func setImage(url: URL){
        // capturamos self para no crear dependencias circulares
        downloadWithURLSession(url: url) { [weak self] image in
            DispatchQueue.main.async{
                self?.image = image
            }
        }
    }
    // Este metodo obtiene una imagen a partir de una URL
    private func downloadWithURLSession(url: URL, completion: @escaping (UIImage?) -> Void){
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data, let image = UIImage(data: data) else{
                // no puedo desempaquetar data ni la imagen
                // lamo al completion con nil
                completion(nil)
                return
            }
            completion(image)
        }
        .resume()
    }
}
