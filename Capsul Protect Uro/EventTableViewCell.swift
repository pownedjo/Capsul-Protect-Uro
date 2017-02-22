import UIKit

class EventTableViewCell: UITableViewCell
{

    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var descriptionEventLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }

}
