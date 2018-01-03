
## Customize
### Variable

The prepared variables can be used for the files prepared under the KuriTemplate folder.

- \_\_PREFIX\_\_ - If you execute `kuri generate Item`, `__PREFIX__` is `Item`.
- \_\_USERNAME\_\_ - Equal `echo $USER`
- \_\_TARGET\_\_ - Generate for Xcode target name.
- \_\_DATE\_\_ - Current system date format from `yyyy/MM/dd`
- \_\_YEAR\_\_ - Current system year.
- \_\_MONTH\_\_ - Current system month.
- \_\_DAY\_\_ - Current system day.

e.g.

Prepare this kind of template
```swift
//
//  __PREFIX__Repository.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import Foundation

protocol __PREFIX__Repository {
    func fetch(_ closure: (__PREFIX__Entity) -> Void) throws
}


struct __PREFIX__RepositoryImpl: __PREFIX__Repository {
    private let dataStore: __PREFIX__DataStore

    init(
        dataStore: __PREFIX__DataStore
        ) {
        self.dataStore = dataStore
    }

    func fetch(_ closure: (__PREFIX__Entity) -> Void) throws  {
        return try dataStore.fetch(closure)
    }
}
```

exec kuri generate.
```
echo $USER
 yourname

kuri generate Kuri
```

The output looks like this
```swift
//
//  KuriRepository.swift
//  Kuri
//
//  Created by hirose on 2017/4/11.
//  Copyright © 2017 hirose. All rights reserved.
//

import Foundation

protocol KuriRepository {
    func fetch(_ closure: (KuriEntity) -> Void) throws 
}


struct KuriRepositoryImpl: KuriRepository {
    private let dataStore: KuriDataStore
    
    init(
        dataStore: KuriDataStore
        ) {
        self.dataStore = dataStore
    }
    
    func fetch(_ closure: (KuriEntity) -> Void) throws  {
        return try dataStore.fetch(closure)
    }
}
```
