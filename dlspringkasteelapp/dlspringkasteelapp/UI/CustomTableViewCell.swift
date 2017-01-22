// een custom UITableViewCell voor de UITable waar de springkastelen in staan

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var BeschikbaarLabel: UILabel!
    @IBOutlet weak var DimensieLabel: UILabel!
    @IBOutlet weak var springkasteelImage: UIImageView!
    
    func setDimension(x: Double, y:Double, z:Double) -> String {
        return "L \(String(x)) m x B \(String(y)) m x  H \(String(z)) m"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
