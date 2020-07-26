
import UIKit

// MARK: - Init
struct ColourInfo: Decodable {
    let colour : String?
    init(json : [String: Any]) {
        colour = json["colour"] as? String ?? ""
    }
}

class ViewController: UIViewController {
    
     // MARK: - Properties
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var colorView: UIView!
    @IBOutlet var selectedColourView: UIView!
    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var lbl_min: UILabel!
    @IBOutlet weak var lbl_max: UILabel!
    @IBOutlet weak var txt_minValue: UITextField!
    @IBOutlet weak var txt_maxValue: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    var colourList = [ColourList]()
    var minValue: Float = 0.0
    var maxValue: Float = 0.0
    
     // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RoundedCorner().UIViewInCircle(uiView: mainView)
        retrieveColoursFromJSON()
        drawCircleUsingSlider()
        hideKeyboard()
    }
    
    // hiding keyboard taping on anywhere in the screen
    func hideKeyboard() {
        let dismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboards))
        view.addGestureRecognizer(dismissKeyboard)
    }
    
     // MARK: - Handlers
    @objc func hideKeyboards() {
        view.endEditing(true)
    }
    
    // configure draw circle
    func drawCircleUsingSlider() {
        progressBar.maximumValue = 200
        progressBar.minimumValue = 0
        progressBar.value = 40
        topConstraint.constant = 200-40
        mainView.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        mainView.layer.shadowRadius = 1.7
        mainView.layer.shadowOpacity = 0.45
        
    }
    
     // MARK: - UISlider action
    @IBAction func progressBar(_ sender: UISlider) {
        let intVal: Int = Int(sender.value)
        topConstraint.constant = CGFloat(200-intVal)
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        txt_minValue.text?.removeAll()
        txt_maxValue.text?.removeAll()
        progressBar.maximumValue = 200
        progressBar.minimumValue = 0
        progressBar.value = 40
        topConstraint.constant = 200-40
        lbl_min.text = GlobalString().minimumValue(value: "0")
        lbl_max.text = GlobalString().maximumValue(value: "200")
    }
    
    @IBAction func btnSetMinMaxValue(_ sender: Any) {
        
        let minString = txt_minValue.text
        let maxString = txt_maxValue.text
        minValue = (minString! as NSString).floatValue
        maxValue = (maxString! as NSString).floatValue
        
        if minValue > maxValue {
            Alert().showErrorAlert(VC: self, OK: nil)
        } else {
            lbl_min.text =  GlobalString().minimumValue(value: minString ?? "")
            lbl_max.text = GlobalString().maximumValue(value: maxString ?? "")
            progressBar.minimumValue = minValue
            progressBar.maximumValue = maxValue
            topConstraint.constant = 200
            progressBar.value = 0
            
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - UICollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colourList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // register cell classes
        let identifier = ColourCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ColourCell
        
        let colours: ColourList
        colours = colourList[indexPath.row]
        cell.btnColours.backgroundColor = UIColor(hexString: colours.colourName ?? "")
        
        cell.actionChangeColour = {
            self.colorView.backgroundColor = UIColor(hexString: colours.colourName ?? "")
            self.selectedColourView.backgroundColor = UIColor(hexString: colours.colourName ?? "")
        }
        
        return cell
    }
}

extension ViewController {
    // MARK: - API :- To get colours list from the JSON file

    func retrieveColoursFromJSON() {
        do {
            let url = Bundle.main.url(forResource: "colours", withExtension: "json")
            let jsonData = try Data(contentsOf: url!)
            let allColours = try JSONDecoder().decode([ColourInfo].self, from: jsonData)
            
            //for the first time getting & changing value.
            colorView.backgroundColor = UIColor(hexString: allColours[7].colour!)
            selectedColourView.backgroundColor = UIColor(hexString: allColours[7].colour!)
            
            for colourName in allColours {
                let colour = colourName.colour
                let setData = ColourList(colourName: colour)
                self.colourList.append(setData)
                collectionView.reloadData()
            }
        } catch let err {
            print(err)
        }
    }
}
