//
//  ViewController.swift
//  MilestoneProjects13-15
//
//  Created by Mehmet Can Şimşek on 23.07.2022.
//

import UIKit

class CollectionVC: UICollectionViewController {
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Country Information"        
        getData()
 
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? Cellvc else {
            fatalError("Unable to dequeue cellVC")
        }
        let countries = countries[indexPath.item]
        cell.labelCell.text = countries.name
        
        let image = String(countries.image)
        
        if let images  = getImage(from: image) {
            cell.imageViewCell.image = images
        }else {
            print("error")
        }
        
        cell.imageViewCell.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageViewCell.layer.borderWidth = 2
        cell.imageViewCell.layer.cornerRadius = 3
        cell.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 6
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsVC {
            
            vc.country = countries[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getData() {
        let uuidString: String = "https://62dd4f7cccdf9f7ec2c489a2.mockapi.io/Country"
        
        if let url = URL(string: uuidString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                countries.sort {
                    $1.name < $0.name
                }
                return
                
            }
        }
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonCountries = try? decoder.decode([Country].self, from: json) {
            countries = jsonCountries
            
            collectionView.reloadData()
        }
            
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
    

}

