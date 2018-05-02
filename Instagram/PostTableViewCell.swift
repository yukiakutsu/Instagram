//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Classtream on 2018/04/25.
//  Copyright © 2018年 yuki.akutsu. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // テーブルセルのタップを無効にする
        tableView.allowsSelection = false
        
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "commentCell")
        
        // テーブル行の高さをAutoLayoutで自動調整する
        tableView.rowHeight = UITableViewAutomaticDimension
        // テーブル行の高さの概算値を設定しておく
        tableView.estimatedRowHeight = 400
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData){
        // デバッグ
        print("DEBUG_PRINT: setPostDataが実行された")
        
        postImageView.image = postData.image
        
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: postData.date!)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.postData = postData
        
        // コメント一覧のTableViewを表示する
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // デバッグ
        print("DEBUG_PRINT: Post numberOfRowsInSection postdata数 = \(appDelegate.postData!.comment.count)")
        
        return appDelegate.postData!.comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // デバッグ
        print("DEBUG_PRINT: Post cellForRowAtが実行")
        
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        cell.setComment(indexPath.row)
        
        return cell
    }
    
    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //    return 400.0
    //}
 
}
