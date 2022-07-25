//
//  DetailsVC.swift
//  MilestoneProjects13-15
//
//  Created by Mehmet Can Şimşek on 23.07.2022.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageViewDetails: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var capitalCityName: UILabel!
    @IBOutlet weak var FoundationYearLbl: UILabel!
    @IBOutlet weak var populationLbl: UILabel!
    @IBOutlet weak var currencyUnitLbl: UILabel!
    @IBOutlet var descriptionLbl: UITextView!
    
    var countryNameText: String?
    var capitalCityNameText: String?
    var foundationYearText: String?
    var populationText: String?
    var currencyUnitText: String?
    var descriptionText: String?
    var imageViewText: String?
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getItem()
       
        
       animationFlag()
       

    }
    
    
    func getItem() {
        guard let country = country else {
            return
        }

        
        let image = String(country.image)
        
        if let images  = getImage(from: image) {
            imageViewDetails.image = images
        }else {
            print("error22")
        }
        countryName.text = "\(country.name.uppercased())"
        capitalCityName.text = "Capital City: \(country.capitalCity)"
        FoundationYearLbl.text = "Foundation Year: \(country.foundationYear)"
        populationLbl.text = "Population: \(country.population)"
        currencyUnitLbl.text = "Currency Unit: \(country.currencyUnit)"
        descriptionLbl.text = "\(country.description)"
        
    }
   
    
    func getImage(from image: String) -> UIImage? {
        
        guard let url = URL(string: image) else {
            print("error")
            return nil
        }
        var images: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            
            images = UIImage(data: data)
        }catch {
            print(error.localizedDescription)
        }
       return images
            
        
    }

    
    func animationFlag() {
        imageViewDetails.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        imageViewDetails.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func tapImage() {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 8, options: []) {
            self.imageViewDetails.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { finished in
            // self.imageViewDetails.transform = .identity
        }

    }

}
