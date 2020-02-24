//
//  TweetCell.swift
//  Twitter
//
//  Created by user163612 on 2/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool=true
    var retweeted:Bool=false
    var tweetId:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavorite(_ isFavorited:Bool){
        self.favorited=isFavorited
        if(self.favorited){
            favoriteButton.setImage(UIImage(named: "favor-icon-red"),for:UIControl.State.normal)
        }
        else{
            favoriteButton.setImage(UIImage(named: "favor-icon"),for:UIControl.State.normal)
        }
    }
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"),for:UIControl.State.normal)
            retweetButton.isEnabled=false
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"),for:UIControl.State.normal)
            retweetButton.isEnabled=true
            
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId,  success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed:\(Error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId,  success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("unfavorite did not succeed:\(Error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId,  success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error is retweeting:\(Error)")
        })    }
}
