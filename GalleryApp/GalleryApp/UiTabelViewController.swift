//
//  UiTabelViewController.swift
//  GalleryApp
//
//  Created by 임태빈 on 2021/04/03.
//

import UIKit
import BouncyLayout
import TRMosaicLayout
import Swinflate
import Photos
import PhotosUI
import M13Checkbox
import CheckMarkView
import Then
class UiTabelViewController: UIViewController {
    //var checkbox: M13Checkbox! = nil
    var list: [UIImage] = []
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = true
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let images = self.setPhotoLibraryImage()
        self.printImageUrl(images: images)
        
       //checkbox 설정하기
//        checkbox = M13Checkbox(frame: CGRect(x: 180.0, y: 360.0, width: 40.0, height: 40.0))
//        checkbox.stateChangeAnimation = .bounce(.fill)
//        //checkbox 기능 추가하기
//        checkbox.addTarget(self, action: #selector(self.changeState), for: .touchUpInside)
//
//        view.addSubview(checkbox)
        // Do any additional setup after loading the view.
    }

//    @objc
//    func changeState() -> Void {
//        checkbox.setCheckState(.checked, animated: true)
//    }
    
    
    
    
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



extension UiTabelViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        //cell.imageView.image = list[indexPath.row]
        cell.backgroundColor = .orange
        cell.checkMark.backgroundColor = .none
        cell.checkMark.style = .grayedOut
        cell.checkMark.setNeedsDisplay()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 90)
        }
    

    
}
