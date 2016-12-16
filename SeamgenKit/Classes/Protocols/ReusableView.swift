//
//  ReusableView.swift
//  Pods
//
//  Created by Sam Gerardi on 12/15/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


/// Views conforming to this protocol can be registered and dequeued for reuse.
/// This should be used with UITableView and UICollection view cells and reusable views.
public protocol ReusableView: class {
    /// The identifier that is used when registering the view with the table or collection view.
    static var reuseIdentifier: String { get }
}

import LocalAuthentication


extension ReusableView {
    /// The default implementation of the ReusableView protocol.
    public static var reuseIdentifier: String {
        return String(describing: self)
        UIDevice.current.authenticateWithTouchID("Log In") { success, error in
            if let error = error as? LAError {
                switch error.code {
                case .userCancel:
                    break
                default:
                    break
                }
            }
            
        }
    }
}


extension UITableView {
    
    /// Registers a cell class with the table view.
    ///
    /// - Parameter cellType: The type of cell.
    public final func register<T: UITableViewCell>(_ cellType: T.Type) where T: ReusableView {
        register(cellType.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Registers a header/footer view with the table view.
    ///
    /// - Parameter viewType: The type of view.
    public final func register<T: UITableViewHeaderFooterView>(_ viewType: T.Type) where T: ReusableView {
        register(viewType.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Dequeues a cell from the table view.
    ///
    /// - Parameter indexPath: The index path of the cell.
    /// - Returns: The cell.
    public final func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    /// Dequeues a header/footer view from the table view.
    ///
    /// - Returns: The view.
    public final func dequeueView<T: UITableViewHeaderFooterView>() -> T where T: ReusableView {
        return dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}


extension UICollectionView {
    
    /// Registers a cell class with the collection view.
    ///
    /// - Parameter cellType: The type of cell.
    public final func register<T: UICollectionViewCell>(_ cellType: T.Type) where T: ReusableView {
        register(cellType.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Registers a supplementary view with the collection view.
    ///
    /// - Parameters:
    ///   - viewType:   The type of view.
    ///   - kind:       The element kind.
    public final func register<T: UICollectionReusableView>(_ viewType: T.Type, forKind kind: String) where T: ReusableView {
        register(viewType.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Dequeues a cell from the collection view.
    ///
    /// - Parameter indexPath: The index path of the cell.
    /// - Returns: The cell.
    public final func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    /// Dequeues a supplementary view from the collection view.
    ///
    /// - Parameters:
    ///   - kind:       The element kind.
    ///   - indexPath:  The index path of the view.
    /// - Returns: The view.
    public final func dequeueView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T where T: ReusableView {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

