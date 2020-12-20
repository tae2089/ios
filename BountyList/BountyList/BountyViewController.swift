//
//  BountyViewController.swift
//  BountyList
//
//  Created by 임태빈 on 2020/12/19.
//

import UIKit

//UITableViewDataSource -> 테이블뷰 셀 몇개, 테이블 뷰 어떻게 보여줄거야?
//UITableViewDelegate -> 테이블 뷰 클릭하면 어떻게 반응해?

class BountyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
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

    //UITabelViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.numOfBountyInfoList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        let bountyInfo = ViewModel.bounttInfo(at: indexPath.row)
        cell.update(info: bountyInfo)
        return cell
    }
    
    //UItableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showdetail", sender: indexPath.row)
    }
}



