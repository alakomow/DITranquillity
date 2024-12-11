//
//  DIComponentBuilder.Injection.swift
//  DITranquillity
//
//  Created by Alexander Ivlev on 03/02/2017.
//  Copyright © 2017 Alexander Ivlev. All rights reserved.
//

extension DIComponentBuilder {

  private func append(injection signature: MethodSignature) -> Self {
    component.append(injection: signature, cycle: false)
    return self
  }

  /// Function for appending an injection method
  ///
  /// Using:
  /// ```
  /// container.register(YourClass.self)
  ///   .injection { yourClass, p0, p1,... in yourClass.yourMethod(p0, p1, ...) }
  /// ```
  ///
  /// - Parameters:
  ///   - method: Injection method. First input argument is the always created object.
  /// - Returns: Self
  @discardableResult
  public func injection<each P>(_ method: @escaping (Impl, repeat each P) -> Void) -> Self {
    return append(injection: MethodMaker.eachMake(useObject: true, by: method))
  }

  /// Function for appending an injection method
  ///
  /// Using:
  /// ```
  /// container.register(YourClass.self)
  ///   .injection { yourClass, p0, p1,... in yourClass.yourMethod(p0, p1, ...) }
  /// ```
  ///
  /// - Parameters:
  ///   - method: Injection method. First input argument is the always created object.
  /// - Returns: Self
  @discardableResult
  public func injection<each P>(_ method: @escaping @MainActor @Sendable (Impl, repeat each P) -> Void) -> Self {
    return append(injection: MethodMaker.eachMake(useObject: true, by: method))
  }
}
