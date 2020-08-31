import UIKit

public protocol IBInstantiatable: UIViewController {

    static var ibName: String { get }
}

public protocol IBIdentifiedInstantiatable: IBInstantiatable {

    static var ibIdentifier: String { get }
}

extension IBInstantiatable {

    @inlinable
    public static var ibName: String {
        return "\(Self.self)"
    }

    @inlinable
    static var sb: UIStoryboard {
        return UIStoryboard(name: ibName, bundle: Bundle(for: Self.self))
    }

    @inlinable
    public static func instantiate() -> Self {
        return sb.instantiateInitialViewController() as! Self
    }
}

extension IBIdentifiedInstantiatable {

    @inlinable
    public static var ibName: String {
        return "Main"
    }

    @inlinable
    public static var ibIdentifier: String {
        return "\(Self.self)"
    }

    @inlinable
    public static func instantiate() -> Self {
        return sb.instantiateViewController(withIdentifier: ibIdentifier) as! Self
    }
}
