//
//  CommentViewController.swift
//  Instagram
//
//  Created by Classtream on 2018/04/26.
//  Copyright © 2018年 yuki.akutsu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

// コメント入力のView
class CommentViewController: UIViewController {
    @IBOutlet weak var CommentText: UITextField!
    
    var postdata: PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // キャンセルボタンが押された
    @IBAction func CancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    // 送信ボタンが押された
    @IBAction func SendButton(_ sender: Any) {
        // ログインしていれば実行
        if let user = Auth.auth().currentUser?.displayName{
            // 増えたコメントをFirebaseに保存する
            let postRef = Database.database().reference().child(Const.PostPath).child(self.postdata.id!)
            let comment = CommentText.text
            if comment != "" && comment != nil{
                self.postdata.comments.insert([user, comment!], at: 0)
                
                // コメントをデータベースに入れる
                postRef.updateChildValues(["comments" : postdata.comments])
                
                // HUDで投稿完了を表示する
                SVProgressHUD.showSuccess(withStatus: "コメントしました")
            }else{
                SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
            }
        }
        
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
