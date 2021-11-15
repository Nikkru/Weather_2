//
//  LoginFormController.swift
//  Weather
//
//  Created by Nikolai Krusser on 27.10.2021.
//

import UIKit

class LoginFormController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var teacherSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        // Do any additional setup after loading the view.
    }
    
    // Когда клавиатура появляется
      @objc func keyboardWasShown(notification: Notification) {
          
          // Получаем размер клавиатуры
          let info = notification.userInfo! as NSDictionary
          let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
          let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
          
          // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
          self.scrollView?.contentInset = contentInsets
          scrollView?.scrollIndicatorInsets = contentInsets
      }
      
      //Когда клавиатура исчезает
      @objc func keyboardWillBeHidden(notification: Notification) {
          // Устанавливаем отступ внизу UIScrollView, равный 0
          let contentInsets = UIEdgeInsets.zero
          scrollView?.contentInset = contentInsets
      }
    
    @objc func hideKeyboard() {
            self.scrollView?.endEditing(true)
        }
    
 // MARK: Логика проверки ввода и перехода на первую странцу приложения
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            // Проверяем данные
            let checkResult = checkUserData()
            
            // Если данные не верны, покажем ошибку
        if !checkResult && !teacherSwitch.isOn {
                showLoginError()
            }
            
            // Вернем результат
            return checkResult
        }
        
        func checkUserData() -> Bool {
            guard let login = loginTextField.text,
                let password = passwordTextField.text else { return false }
            
            if (login == "admin" && password == "123456") || teacherSwitch.isOn {
                return true
            } else {
                return false
            }
        }
        
        func showLoginError() {
            // Создаем контроллер
            let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
            // Создаем кнопку для UIAlertController
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            // Добавляем кнопку на UIAlertController
            alert.addAction(action)
            // Показываем UIAlertController
            present(alert, animated: true, completion: nil)
        }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
           NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
           // Второе — когда она пропадает
           NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       }

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    @IBAction func loginInputTextField(_ sender: Any) {
    }
    @IBAction func passwordInputTextField(_ sender: Any) {
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        // Получаем текст логина
               let login = loginTextField.text!
               // Получаем текст-пароль
               let password = passwordTextField.text!
               
               // Проверяем, верны ли они
               if login == "admin" && password == "123456" {
                   print("успешная авторизация")
               } else {
                   print("ошибка")
               }
    }
    @IBAction func tappedSwitch(_ sender: UISwitch) {
    }
    
}
