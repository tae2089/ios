//
//  ViewController.swift
//  GalleryApp
//
//  Created by 임태빈 on 2021/04/01.
//

import UIKit
import PhotosUI
import Photos
import Nuke


class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var testBtn: UIButton!
    
    @IBOutlet var myImageView: UIImageView!
    private var allPhotos = PHFetchResult<PHAsset>()
    private var smartAlbums = PHFetchResult<PHAssetCollection>()
    private var userCollections = PHFetchResult<PHAssetCollection>()
    
    let readWriteStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
    let allPhotosOptions = PHFetchOptions()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .notDetermined:
                // The user hasn't determined this app's access.
                print("1")
            case .restricted:
                // The system restricted this app's access.
                print("1")
            case .denied:
                print("1")
                // The user explicitly denied this app's access.
            case .authorized:
                print("authorized")

                //self.setPhotoLibraryImage2()
                //self.printImageUrl(images:images)
                // The user authorized this app to access Photos data.
            case .limited:
                print("1")
                // The user authorized this app for limited Photos access.
            @unknown default:
                fatalError()
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.imagePicker.sourceType = .photoLibrary // 앨범에서 가져옴
//        self.imagePicker.allowsEditing = true // 수정 가능 여부
//        self.imagePicker.delegate = self // picker delegate
            // present(imagePicker, animated: false, completion: nil)
        let images = self.setPhotoLibraryImage()
        self.printImageUrl(images: images)
        
    }
    
    
    
    func setPhotoLibraryImage() -> PHFetchResult<PHAsset> {
        
        // 불러올 이미지의 옵션 설정
        let fetchOption = PHFetchOptions()
        fetchOption.fetchLimit = 1
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
                self.myImageView.image = image
             
                
                //self.testBtn.setImage(image, for: .normal)
                    print("Image : ", image)
                  print("Info : ", info)
              })
            
        }
        
    }
    
}




