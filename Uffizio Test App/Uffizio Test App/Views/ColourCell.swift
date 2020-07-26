
import UIKit

class ColourCell: UICollectionViewCell {
    
    static let identifier = GlobalString().cellID()
    @IBOutlet weak var btnColours: UIButton!
    var actionChangeColour : (() -> Void)? = nil
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        RoundedCorner().ButtonInCircle(button: btnColours)
    }
    
    @IBAction func setBGColour(_ sender: UIButton) {
        if let changeColour = actionChangeColour {
            changeColour()
        }
    }
}
