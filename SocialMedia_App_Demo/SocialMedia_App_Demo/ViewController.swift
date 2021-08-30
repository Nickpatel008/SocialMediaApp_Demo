//
//  ViewController.swift
//  SocialMedia_App_Demo
//
//  Created by Nick patel on 29/08/21.
//  Copyright © 2021 Nick patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sql = SqlHandler.sh
    
    private let myTableView = UITableView()
    
    var not:[USERPOST] = []
    
    var dataArr = ["Arjun","Dhaval","Rohit"]
    
    var imgArr = ["1","1","1","1"]
    
    private let mybtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 25
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleBtn), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Face-Gram"
        
        view.addSubview(myTableView)
        view.addSubview(mybtn)
        
        setup()
        not = sql.Select_Notice()
        myTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        myTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myTableView.frame = CGRect(x: 0, y: 80, width: view.width, height: view.height)
        mybtn.frame = CGRect(x: view.width - 60, y: view.height - 60, width: 50, height: 50)
        
    }

    @objc func handleBtn()
    {
        let vc = AddPostVC()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func setup()
    {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(mediaTBL.self, forCellReuseIdentifier: "mediaTBL")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return not.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "mediaTBL", for: indexPath) as! mediaTBL
        
        cell.mySocialMediaSetup(title: not[indexPath.row].name, img: not[indexPath.row].img , desc1: not[indexPath.row].detail
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
    
    
}

