//
//  LoginFormController.swift
//  Weather
//
//  Created by Nikolai Krusser on 27.10.2021.
//

import UIKit

class LoginFormController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var loginInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    
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
               let login = loginInput.text!
               // Получаем текст-пароль
               let password = passwordInput.text!
               
               // Проверяем, верны ли они
               if login == "admin" && password == "123456" {
                   print("успешная авторизация")
               } else {
                   print("ошибка")
               }
    }
}
