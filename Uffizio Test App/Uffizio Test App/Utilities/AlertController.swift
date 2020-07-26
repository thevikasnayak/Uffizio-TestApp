import UIKit


class Alert: NSObject {
    // MARK: - Global function for alert view
    
    func showErrorAlert(VC : UIViewController, OK: ((UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: GlobalString().error(), message: GlobalString().errorDescription(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: GlobalString().ok(), style: .default, handler: OK))
        alert.view.backgroundColor = UIColor.white
        alert.view.layer.cornerRadius = 10
        VC.present(alert, animated: true)
    }
}
