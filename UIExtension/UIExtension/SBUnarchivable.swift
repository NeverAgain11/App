import UIKit

public protocol SBUnarchivable: UIViewController {

    static var sbName: String { get }
}

public protocol SBIdentifiedUnarchivable: SBUnarchivable {

    static var sbIdentifier: String { get }
}

extension SBUnarchivable {

    @inlinable
    public static var sbName: String {
        return "\(Self.self)"
    }

    @inlinable
    static var sb: UIStoryboard {
        return UIStoryboard(name: sbName, bundle: Bundle(for: Self.self))
    }

    @inlinable
    public static func instantiate() -> Self {
        return sb.instantiateInitialViewController() as! Self
    }
}

extension SBIdentifiedUnarchivable {

    @inlinable
    public static var sbIdentifier: String {
        return "\(Self.self)"
    }

    @inlinable
    public static func instantiate() -> Self {
        return sb.instantiateViewController(withIdentifier: sbIdentifier) as! Self
    }
}
