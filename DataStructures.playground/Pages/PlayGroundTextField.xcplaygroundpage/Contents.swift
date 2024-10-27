import PlaygroundSupport
import UIKit

class V: UIViewController {
    var textField = UITextField(frame: CGRect(x: 20, y: 20, width: 200, height: 24))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        textField.backgroundColor = .white
        textField.delegate = self
    }
}
extension V: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Do stuff here
        return true
    }
}
let v = V()
v.view.frame = CGRect(x: 0, y: 0, width: 700, height: 100)
PlaygroundPage.current.liveView = v.view
PlaygroundPage.current.needsIndefiniteExecution = true
