//
//  Created by Alexander Svalov on 11.03.2021.
//

import UIKit

class SingleComponentPickerViewController:
    UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let characterNames = ["Luke", "Leia", "Han", "Chewbacca", "Artoo", "Threepio", "Lando"]

    @IBOutlet weak var singlePicker: UIPickerView!
        
    @IBAction func onButtonPressed(_ sender: UIButton) {
        
        let row = singlePicker.selectedRow(inComponent: 0)  // запрос информации о выбранной строке
        let selected = characterNames[row]
        let title = "You selected \(selected)!"
        let alert = UIAlertController(
            title: title,
            message: "Thank you for choosing",
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: "You're welcome",
            style: .default,
            handler: nil
        )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1  // возвращаем количество компонентов селектора
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characterNames.count
    }

    // MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return characterNames[row]
    }
}
