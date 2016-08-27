import UIKit

class StrangerDynamicPostWallCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var trackImg: UIImageView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBOutlet weak var ArtistNameAlbumNameLabel: UILabel!
    
    @IBOutlet weak var storyTitleLabel: UILabel!
    
    @IBOutlet weak var postDateLabel: UILabel!
    
    @IBOutlet weak var StoryTextView: UITextView!
    
    @IBOutlet weak var reasonLabel: UILabel!
   
    
    @IBOutlet weak var likeImg: UIImageView!
    
    @IBOutlet weak var likeNumLabel: UILabel!
    
    
    @IBOutlet weak var commentImg: UIImageView!
    
    @IBOutlet weak var commentNumLabel: UILabel!
    
    @IBAction func playBtn(sender: UIButton!){
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func drawRect(rect: CGRect) {
       
        trackImg.contentMode = .ScaleAspectFill
        trackImg.layer.cornerRadius = 3.0
        trackImg.clipsToBounds = true
        
        
        
    }
    
    
    
    func configureCell(story: Story){
        let profileImageURL = NSURL(string: story.whoPostStoryImgUrl)
        let profileImageData = NSData(contentsOfURL: profileImageURL!)
        if let imgData = profileImageData{
            let profileImg = UIImage(data: imgData)
            self.profileImg.image = profileImg
        }
        
        
        let albumCoverImageUrl = NSURL(string: story.storySongCoverUrl)
        let albumCoverImageData = NSData(contentsOfURL: albumCoverImageUrl!)
        if let imgData = albumCoverImageData{
            let albumCoverImg = UIImage(data: imgData)
            self.trackImg.image = albumCoverImg
        }
        
        self.commentNumLabel.text = "\(story.storyComments.count)"
        self.likeNumLabel.text = "\(story.storyLikeNum)"
        self.profileNameLabel.text = story.whoPostStory
        self.storyTitleLabel.text = story.storyName
        self.postDateLabel.text = story.storyPostTime
        self.StoryTextView.text = story.storyContent
        self.trackNameLabel.text = story.storySongName
        self.ArtistNameAlbumNameLabel.text = "\(story.stroySongArtistName)"+"  \(story.storySongAlbumName)"
        self.reasonLabel.text = story.reasonToRecommend
        print(self.reasonLabel.text)
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
}
