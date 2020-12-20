//
//  DetailViewController.swift
//  BountyList
//
//  Created by 임태빈 on 2020/12/19.
//

import UIKit

class DetailViewController: UIViewController {
    //MVVM
    
    // Model
    // - BountyInfo
    // > BountyInfo make
    
    // View
    // - imgView, namelabel, bountylabel
    // > view들은 viewModel를 통해서 구성되기
    
    // ViewModel
    // - DetailViewModel
    // > 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기,, BountyInfo 들
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        if let bountyInfo = viewModel.bountyInfo{
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        //종료되고 나서 진횅되는 함수
    }
}



