//
//  ScrollViewController.swift
//  GalleryApp
//
//  Created by 임태빈 on 2021/04/05.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView = {
            let flowlayout = UICollectionViewFlowLayout()
            flowlayout.scrollDirection = .horizontal
            flowlayout.minimumLineSpacing = 80
            
            //inset 설정하기
            flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 50)
            
            collectionView.collectionViewLayout = flowlayout
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            // 배경하면
            collectionView.backgroundColor = UIColor.red
            return collectionView
        }()
        
        NSLayoutConstraint.activate([
//            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
//            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300)

            ])
        // Do any additional setup after loading the view.
    }

}
extension ScrollViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
}

extension ScrollViewController: UICollectionViewDelegate {
    
}

extension ScrollViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 200, height: collectionView.frame.height)
    }
}
