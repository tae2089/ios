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
    
    
    
    let nameList = ["brook","chopper","franky","luffy","nami","robin","sanji","zoro"]
    let bountyList = [33000000,50,44000000,30000000,80000000,77000000,120000000,300000000]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //세그웨이가 시작하기 직전에 진행
        //DetailViewController 한테 데이터 주기
        if segue.identifier == "showdetail"{
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int{
                vc?.name = nameList[index]
                vc?.bountry = bountyList[index]
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //UITabelViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bountyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        //이미지 넣는 방법
        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        cell.imgView.image = img
        //text에 값 넣는 방법
        cell.nameLabel.text = nameList[indexPath.row]
        //text에다가는 string만들어갈 수 있음
        cell.bountyLabel.text = "\(bountyList[indexPath.row])"
        return cell
    }
    
    //UItableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showdetail", sender: indexPath.row)
        
    }
    

}


class ListCell: UITableViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    
}
