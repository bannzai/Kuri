
## Customize
### Variable

The prepared variables can be used for the files prepared under the KuriTemplate folder.

- \_\_Entity\_\_
- \_\_DataStore\_\_
- \_\_Repository\_\_
- \_\_UseCase\_\_
- \_\_Translator\_\_
- \_\_Model\_\_
- \_\_Presenter\_\_
- \_\_View\_\_
- \_\_Wireframe\_\_
- \_\_Builder\_\_

They are replaced by the name of each component.  

さらに下記の変数も使えます。
- \_\_USERNAME\_\_ - Equal `echo $USER`
- \_\_DATE\_\_ - Current system date format from `yyyy/MM/dd`

e.g.

Prepare this kind of template
```
//
//  __REPOSITORY__Impl.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © 2016年 __USERNAME__. All rights reserved.
//

struct __REPOSITORY__Impl: __REPOSITORY__ {
    private let dataStore: __DATASTORE__

    init(
        dataStore: __DATASTORE__
        ) {
        self.dataStore = dataStore
    }

    func fetch() throws -> __ENTITY__ {
        return try dataStore.fetch()
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
```
//
//  KuriRepositoryImpl.swift
//  Kuri
//
//  Created by yourname on 2016/12/25.
//  Copyright © 2016年 yourname. All rights reserved.
//

struct KuriRepositoryImpl: KuriRepository {
    private let dataStore: KuriDataStore

    init(
        dataStore: KuriDataStore
        ) {
        self.dataStore = dataStore
    }

    func fetch() throws -> KuriEntity {
        return try dataStore.fetch()
    }
}
```
