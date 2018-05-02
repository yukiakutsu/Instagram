//
//  CommentTableViewCell.swift
//  Instagram
//
//  Created by Classtream on 2018/04/26.
//  Copyright © 2018年 yuki.akutsu. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var comment: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // 投稿者の名前、コメントを取得し、表示
    func setComment(_ index: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.name.text = appDelegate.postData!.commentUser[index]
        self.comment.text = appDelegate.postData!.comment[index]
    }
}
