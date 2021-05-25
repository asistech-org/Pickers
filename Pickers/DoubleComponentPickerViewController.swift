//
//  Created by Alexander Svalov on 11.03.2021.
//

import UIKit

class DoubleComponentPickerViewController: UIViewController,
    UIPickerViewDataSource, UIPickerViewDelegate {

    // Индексы компонентов селектора
    private let fillingComponent = 0
    private let breadComponent = 1
    
    // Источники данных для двух компонентов селектора
    private let fillingTypes = [
        "Ham", "Turkey", "Peanut Butter", "Tuna Salad",
        "Chicken Salad", "Roast Beef", "Vegemite"
    ]
    private let breadTypes = [
        "White", "Whole Wheat", "Rye", "Sourdough", "Seven Grain"
    ]
    
    @IBOutlet weak var doublePicker: UIPickerView!
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        
        let fillingRow = doublePicker.selectedRow(inComponent: fillingComponent)
        let breadRow = doublePicker.selectedRow(inComponent: breadComponent)
        let filling = fillingTypes[fillingRow]
        let bread = breadTypes[breadRow]
        
        let message = "Your \(filling) on \(bread) bread will be right up."
        let alert = UIAlertController(
            title: "Thank you for your order",
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: "Great",
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
        return 2  // возвращаем количество компонентов селектора
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // возвращаем количество значений для каждого компонента
        if component == breadComponent {
            return breadTypes.count
        } else {
            return fillingTypes.count
        }
    }

    // MARK:-
    // MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {  // загрузка значений в селектор
        if component == breadComponent {
            return breadTypes[row]
        } else {
            return fillingTypes[row]
        }
    }
}
