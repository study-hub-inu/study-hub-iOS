//
//  UIViewcontrollerExtention.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/10/12.
//

import UIKit

extension UIViewController: UITextFieldDelegate, UITextViewDelegate {
  func alertShow(title: String, message: String) {
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인",
                                  style: .default,
                                  handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - UI 생성 함수
  func createContactButton(title: String, selector: Selector) -> UIButton {
    let button = UIButton()
    button.setTitle(title, for: .normal)
    button.setTitleColor(UIColor(hexCode: "#A1AAB0"), for: .normal)
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor(hexCode: "#D8DCDE").cgColor
    button.layer.cornerRadius = 5
    button.backgroundColor = .white
    button.addTarget(self, action: selector, for: .touchUpInside)
    return button
  }
  
  func createFineButton(selector: Selector) -> UIButton {
    let button = UIButton()
    button.setImage(UIImage(named: "ButtonEmpty"), for: .normal)
    button.setImage(UIImage(named: "ButtonChecked"), for: .selected)
    button.tintColor = UIColor(hexCode: "#FF5530")
    button.addTarget(self, action: selector, for: .touchUpInside)
    return button
  }
  
  // 날짜 선택하는 버튼
  func createDateButton(selector: Selector) -> UIButton {
      // 버튼 초기화
      let button = UIButton()
      
      // 버튼에 이미지 설정
      let image = UIImage(named: "RightArrow")
      button.setImage(image, for: .normal)
      
      // 버튼의 이미지 위치 조절
      button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 320, bottom: 0, right: 10)
      
      // 버튼의 나머지 속성 설정
      button.setTitle("선택하기", for: .normal)
      button.contentHorizontalAlignment = .left
      button.setTitleColor(UIColor(hexCode: "#A1AAB0"), for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
      button.backgroundColor = .white
      button.layer.borderWidth = 1
      button.layer.borderColor = UIColor(hexCode: "#D8DCDE").cgColor
      button.layer.cornerRadius = 5
      button.addTarget(self, action: selector, for: .touchUpInside)
      
      return button
  }

  // info
  func createTextField(title: String) -> UITextField {
    let textField = UITextField()
    let placeholderTextAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: UIColor.bg50,
      .font: UIFont.systemFont(ofSize: 14)
    ]
    
    textField.attributedPlaceholder = NSAttributedString(string: title,
                                                         attributes: placeholderTextAttributes)
    
    textField.backgroundColor = .white
    textField.textColor = .black
    textField.font = UIFont.systemFont(ofSize: 14)
    textField.borderStyle = .roundedRect
    textField.layer.cornerRadius = 5
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.layer.borderWidth = 0.5
    textField.delegate = self
    return textField
  }
  
  func createLabel(title: String, textColor: UIColor, fontSize: CGFloat) -> UILabel {
    let label = UILabel()
    label.text = title
    label.textColor = textColor
    label.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    return label
  }
  
  func createStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = axis
    stackView.spacing = spacing
    
    return stackView
  }
  
  func createDividerLine(height: CGFloat) -> UIView {
    let dividerLine = UIView()
    dividerLine.backgroundColor = UIColor(hexCode: "#F3F5F6")
    dividerLine.heightAnchor.constraint(equalToConstant: height).isActive = true
    
    return dividerLine
  }
  
  func createMypageButton(title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.setTitleColor(UIColor(hexCode: "#49545C"), for: .normal)
    return button
  }
  
  // MARK: - 날짜 변경 함수
  func convertToFormat(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년 MM월 dd일" // 입력된 날짜의 형식
    guard let date = dateFormatter.date(from: dateString) else { return "" }
    
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
  }
  
  // MARK: -  UITextField가 선택될 때 호출되는 메서드
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.layer.borderColor = UIColor.black.cgColor // 테두리 색상을 검은색으로 변경
    textField.layer.borderWidth = 1.0 // 테두리 두께 설정
  }
  
  // MARK: - UITextField가 선택 해제될 때 호출되는 메서드
  public func textFieldDidEndEditing(_ textField: UITextField) {
    textField.layer.borderColor = UIColor.clear.cgColor // 테두리 색상을 초기화 (투명)
    textField.layer.borderWidth = 0.0 // 테두리 두께 초기화
  }
  
  public func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil // 텍스트를 날려줌
      textView.textColor = UIColor.black
    }
    textView.layer.borderColor = UIColor.black.cgColor // 테두리 색상을 검은색으로 변경
    textView.layer.borderWidth = 1.0 // 테두리 두께 설정
    
  }
  public func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "스터디에 대해 알려주세요\n (운영 방법, 대면 여부,벌금,공부 인증 방법 등)"
      textView.textColor = UIColor.lightGray
    }
    textView.layer.borderColor = UIColor.lightGray.cgColor // 테두리 색상을 초기화 (투명)
    textView.layer.borderWidth = 1.0 // 테두리 두께 초기화
  }
  
  // MARK: - toast message, 이미지가 뒤에 나오고 있음 앞으로 빼기
  func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75,
                                           y: self.view.frame.size.height-100,
                                           width: 300,
                                           height: 35))
    
    toastLabel.backgroundColor = UIColor.g100
    toastLabel.textColor = UIColor.g10
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    
    if let text = toastLabel.text {
      
      let imageAttachment = NSTextAttachment()
      imageAttachment.image = UIImage(named: "WarningImg")

      let attributedString = NSMutableAttributedString(string: text)
      attributedString.append(NSAttributedString(attachment: imageAttachment))

      toastLabel.attributedText = attributedString
    }
    
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 10.0, delay: 0.1,
                   options: .curveEaseOut, animations: {
      toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
      toastLabel.removeFromSuperview()
    })
  }
}


