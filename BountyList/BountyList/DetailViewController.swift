//
//  DetailViewController.swift
//  BountyList
//
//  Created by 임태빈 on 2020/12/19.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    var name : String?
    var bountry : Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        
    }
    
    func updateUI(){
        if let name = self.name, let bountry = self.bountry{
            let img = UIImage(named: "\(name).jpg")
            imgView.image =  img
            nameLabel.text = name
            bountyLabel.text = "\(bountry)"
        }
    }
    
    
    
    
    
    
    
    

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        //종료되고 나서 진횅되는 함수
    }
    
 

        
        
    
    
}
