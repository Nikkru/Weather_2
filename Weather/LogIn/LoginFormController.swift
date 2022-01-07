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
    
    @IBOutlet weak var passwordTitleView: UILabel!
    @IBOutlet weak var loginTitleView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var authViewButton: UIButton!
    
    private var backDoorKey = false
    var interactiveAnimator: UIViewPropertyAnimator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateTitlesAppearing()
        animateTitleAppearing()
        animateFieldsAppearing()
        animateAuthButton()
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        // Do any additional setup after loading the view.
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(recognizer)
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         dampingRatio: 0.5,
                                                         animations: {
                                                            self.authViewButton.transform = CGAffineTransform(translationX: 0,
                                                                                                              y: 150)
                                                         })
            
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = translation.y / 100
        case .ended:
            interactiveAnimator.stopAnimation(true)
            
            interactiveAnimator.addAnimations {
                self.authViewButton.transform = .identity
            }
            
            interactiveAnimator.startAnimation()
        default: return
        }
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: kbSize.height,
                                         right: 0.0)
        
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
        if !checkResult {
            showLoginError()
        }
        
        // Вернем результат
        return checkResult
    }
    
    func checkUserData() -> Bool {
        guard let login = loginInput.text,
              let password = passwordInput.text else { return false }
        
        if login == "admin" && password == "123456" || backDoorKey {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        // Создаем контроллер
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Введены неверные данные пользователя",
                                      preferredStyle: .alert)
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK:- Animation block
    
    func animateTitlesAppearing() {
        
        let offset = abs(self.loginTitleView.frame.midY - self.passwordTitleView.frame.midY)
        
        self.loginTitleView.transform = CGAffineTransform(translationX: 0, y: offset)
        self.passwordTitleView.transform = CGAffineTransform(translationX: 0, y: -offset)
        
        UIView.animateKeyframes(withDuration: 1,
                                delay: 1,
                                options: .calculationModeCubicPaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.5,
                                                       animations: {
                                                        self.loginTitleView.transform = CGAffineTransform(translationX: 150, y: 50)
                                                        self.passwordTitleView.transform = CGAffineTransform(translationX: -150, y: -50)
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 0.5,
                                                       relativeDuration: 0.5,
                                                       animations: {
                                                        self.loginTitleView.transform = .identity
                                                        self.passwordTitleView.transform = .identity
                                                       })
                                }, completion: nil)
        //        UIView.animate(withDuration: 1,
        //                       delay: 1,
        //                       options: .curveEaseOut,
        //                       animations: {
        //                        self.loginTitleView.transform = .identity
        //                        self.passwordTitleView.transform = .identity
        //                       },
        //                       completion: nil)
    }
    
    func animateTitleAppearing() {
        self.titleView.transform = CGAffineTransform(translationX: 0,
                                                     y: -self.view.bounds.height/2)
        
        let animator = UIViewPropertyAnimator(duration: 1,
                                              dampingRatio: 0.5,
                                              animations: {
                                                self.titleView.transform = .identity
                                              })
        
        animator.startAnimation(afterDelay: 1)
        //        UIView.animate(withDuration: 1,
        //                       delay: 1,
        //                       usingSpringWithDamping: 0.5,
        //                       initialSpringVelocity: 0,
        //                       options: .curveEaseOut,
        //                       animations: {
        //                           self.titleView.transform = .identity
        //                       },
        //                       completion: nil)
    }
    
    func animateFieldsAppearing() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 1
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.stiffness = 150
        scaleAnimation.mass = 2
        
        let animationsGroup = CAAnimationGroup()
        animationsGroup.duration = 1
        animationsGroup.beginTime = CACurrentMediaTime() + 1
        animationsGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animationsGroup.fillMode = CAMediaTimingFillMode.backwards
        animationsGroup.animations = [fadeInAnimation, scaleAnimation]
        
        self.loginInput.layer.add(animationsGroup, forKey: nil)
        self.passwordInput.layer.add(animationsGroup, forKey: nil)
    }
    func animateAuthButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.authViewButton.layer.add(animation, forKey: nil)
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
    @IBAction func backDooorButtonTapped(_ sender: UIButton) {
        backDoorKey = !backDoorKey
    }
    
    @IBAction func backDoorTappedButton(_ sender: UIButton) {
    }
}
