//
//  ConfViewController.swift
//  GalleryApp
//
//  Created by 임태빈 on 2021/04/03.
//

import UIKit
import Photos
import PhotosUI

class ConfViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        //cell.imageView.image = list[indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("test")
//    }
    
    var list: [UIImage] = []
        
        @IBOutlet var collectionView: UICollectionView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
        
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            
            let images = self.setPhotoLibraryImage()
            self.printImageUrl(images: images)
        }
    
    func setPhotoLibraryImage() -> PHFetchResult<PHAsset> {
        
        // 불러올 이미지의 옵션 설정
        let fetchOption = PHFetchOptions()
        //fetchOption.fetchLimit = 1
        fetchOption.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        
        let fetchPhotos = PHAsset.fetchAssets(with: PHAssetMediaType.image,options: fetchOption)
        print(fetchPhotos.count)

        return fetchPhotos
    }
    
    
    
    func setPhotoLibraryImage2() -> PHFetchResult<PHCollection> {
        
        // 불러올 이미지의 옵션 설정
        let fetchOption = PHFetchOptions()
        //fetchOption.fetchLimit = 1
        fetchOption.sortDescriptors = [NSSortDescriptor(key:"parentFolder", ascending: false)]
        
        let fetchPhotos = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        print(fetchPhotos)
        return fetchPhotos
    }
    
    
    
    
    
    
    
    func printImageUrl(images: PHFetchResult<PHAsset>) -> Void{
        
        
        images.enumerateObjects { (asset, count, stop) in
            print("asset",asset)
            print("count",count)
            print("stop",stop)
            
            let targetSize = CGSize(width: 350, height: 350)
            let imageManager = PHImageManager.default()
            let optinos = PHImageRequestOptions()
            
            
              optinos.isSynchronous = true // 순서대로 불러온다.
              
              // 이미지 정보 얻어오기
              imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFit, options: optinos, resultHandler: { (image, info) in
                
                self.list.append(image!)
                //self.testBtn.setImage(image, for: .normal)
                    print("Image : ", image)
                  print("Info : ", info)
              })
            
        }
        
    }
    
}

