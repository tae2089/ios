//
//  ViewController.swift
//  TestUicell
//
//  Created by 임태빈 on 2021/04/05.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        // Do any additional setup after loading the view.
    }


}


extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .orange
        return cell
    }
    
    
}
