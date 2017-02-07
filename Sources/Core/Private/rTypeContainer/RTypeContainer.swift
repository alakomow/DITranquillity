//
//  RTypeContainer.swift
//  DITranquillity
//
//  Created by Alexander Ivlev on 10/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

class RTypeContainer {
  func append(key: DIType, value: RType) {
    values.append(key: DITypeKey(key), value: value)
  }

  func contains(key: DIType, value: RType) -> Bool {
    return values.contains(key: DITypeKey(key), value: value)
  }

  subscript(key: DIType) -> [RType] { return values[DITypeKey(key)] }

  func data() -> [DITypeKey: [RType]] {
    return values.dictionary
  }

  func copyFinal() -> RTypeContainerFinal {
    var map: [RType: RTypeFinal] = [:]
    var result: [DITypeKey: [RTypeFinal]] = [:]
    
    for data in self.values.dictionary {
      for rType in data.value {
        let final = map[rType] ?? rType.copyFinal()
        map[rType] = final // additional operation, but simple syntax
        
        if nil == result[data.key] {
          result[data.key] = []
        }
        
        result[data.key]!.append(final)
        
      }
    }

    return RTypeContainerFinal(values: result)
  }

  private var values = DIMultimap<DITypeKey, RType>()
}

class DITypeKey: Hashable {
  let value: DIType
  let name: String
  
  init(_ value: DIType) {
    self.value = value
    self.name = String(describing: value)
  }
  
  var hashValue: Int {  return name.hashValue }
  
  static func ==(lhs: DITypeKey, rhs: DITypeKey) -> Bool {
    return lhs.name == rhs.name
  }
}
