//
//  ChatViewController.swift
//  ChatModule
//
//  Created by Duc Tran on 7/30/20.
//

import UIKit

class ChatViewController: UIViewController, StoryboardInstantiable {
  static func create() -> ChatViewController {
     let view = ChatViewController.instantiateViewController(Bundle(for: Self.self).resource)
     return view
  }
}

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

public extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
      guard let vc = storyboard.instantiateViewController(withIdentifier: fileName) as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}
