public protocol Instantiatable {
    
    static func instantiate() -> Self
}

import SwiftUI

public extension UIViewControllerRepresentable where Self: UIViewController & Instantiatable {
    
    typealias UIViewControllerType = Self
    
    @inlinable
    func makeUIViewController(context: Context) -> Self {
        .instantiate()
    }
    
    @inlinable
    func updateUIViewController(_ uiViewController: Self, context: Context) {}
}
