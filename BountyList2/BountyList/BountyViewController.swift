//
//  BountyViewController.swift
//  BountyList
//
//  Created by 임태빈 on 2020/12/19.
//

import UIKit

//UITableViewDataSource -> 테이블뷰 셀 몇개, 테이블 뷰 어떻게 보여줄거야?
//UITableViewDelegate -> 테이블 뷰 클릭하면 어떻게 반응해?

class BountyViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,
                            UICollectionViewDelegateFlowLayout{

    
    
    //MVVM
    
    // Model
    // - BountyInfo
    // > BountyInfo make
    
    // View
    // - ListCell
    // > ListCell 필요한 정보를 ViewModel한테서 받아야 겠다
    // > ListCell은 ViewModel로 부터 받은 정보로 뷰 업데이트 하기
    
    // ViewModel
    // - bountyViewModel을 만든다, 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기,, BountyInfo 들

  let ViewModel = BountyViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //세그웨이가 시작하기 직전에 진행
        //DetailViewController 한테 데이터 주기
        if segue.identifier == "showdetail"{
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int{
                let bountyInfo = ViewModel.bounttInfo(at: index)
                vc?.viewModel.update(model: bountyInfo)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 몇개를 보여줄까요?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewModel.numOfBountyInfoList
    }
    
    // 셀은 어떻게 표현할까요?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Gridcell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        
          let bountyInfo = ViewModel.bounttInfo(at: indexPath.item)
          cell.update(info: bountyInfo)
          return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showdetail", sender: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    //너비와 높이가 필요
        let itemSpanning : CGFloat = 10
        let textAreaHeight : CGFloat = 65
        
        let width: CGFloat = (collectionView.bounds.width - itemSpanning)/2
        let height: CGFloat = width * 10/7 + textAreaHeight
        
        return CGSize(width: width, height: height)
    }
    
}




