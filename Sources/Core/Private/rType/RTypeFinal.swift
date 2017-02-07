//
//  RTypeFinal.swift
//  DITranquillity
//
//  Created by Alexander Ivlev on 18/07/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

class RTypeFinal: RTypeBase {
  typealias MethodKey = String
  
  init(component: DIComponent, initials: [MethodKey: Any], injections: [(_ scope: DIScope, _ obj: Any) -> ()], names: Set<String>, isDefault: Bool, lifeTime: DILifeTime) {
    self.initials = initials
    self.injections = injections
    self.names = names
    self.isDefault = isDefault
    self.lifeTime = lifeTime
    super.init(component: component)
  }
  
  func new<Method, T>(_ method: (Method) throws -> T) throws -> T {
    guard let initializer = initials[MethodKey(describing: Method.self)] as? Method else {
      throw DIError.initializationMethodWithSignatureIsNotFoundFor(component: component, signature: Method.self)
    }
    
    return try method(initializer)
  }
  
  func has(name: String) -> Bool {
    return names.contains(name)
  }
  
  let lifeTime: DILifeTime
  let isDefault: Bool
  let injections: [(_ scope: DIScope, _ obj: Any) -> ()]
  
  private let initials: [MethodKey: Any]
  private let names: Set<String>
}
