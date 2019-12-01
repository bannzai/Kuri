EXECUTE?=kuri
PROJECT?=Kuri
PACKAGE?=Kuri
DEMO_DIRECTORY?=KuriDemo
BUILD_DIRECTORY?=.build
RELEASE_BINARY_DIRECTORY?=$(BUILD_DIRECTORY)/release/$(PROJECT)

install: release
	rm -rf ./bin/$(EXECUTE)
	mkdir -p ./bin
	cp -f $(RELEASE_BINARY_DIRECTORY) bin/$(EXECUTE)

release:
	swift build -c release 

dry-run: build
	cd $(DEMO_DIRECTORY)
	rm -rf KuriDemo.xcodeproj/project.pbxproj \ 
		KuriDemo/Hoge/DataStore/HogeDataStore.swift \ 
		KuriDemo/Hoge/HogeBuilder.swift \ 
		KuriDemo/Hoge/HogeEntity.swift \ 
		KuriDemo/Hoge/Model/HogeModel.swift \ 
		KuriDemo/Hoge/Presenter/HogePresenter.swift \ 
		KuriDemo/Hoge/Repository/HogeRepository.swift \ 
		KuriDemo/Hoge/Translator/HogeTranslator.swift \ 
		KuriDemo/Hoge/UseCase/HogeUseCase.swift \ 
		KuriDemo/Hoge/View/HogeViewController.storyboard \ 
		KuriDemo/Hoge/View/HogeViewController.swift \  
		KuriDemo/Hoge/Wireframe/HogeWireframe.swift \ 
		KuriDemoTests/Hoge/Tests/HogeTests.swift
	kuri generate Hoge
	cd -

build:
	swift build

xcodeproj: 
	swift package generate-xcodeproj

clean:
	swift package clean
	rm -rf $(BUILD_DIRECTORY) $(PROJECT).xcodeproj

test: build xcodeproj
	xcodebuild clean build test -project $(PROJECT).xcodeproj \
		-scheme $(PACKAGE) \
		-destination platform="macOS" \
		-enableCodeCoverage YES \
		-derivedDataPath .build/derivedData \
		CODE_SIGN_IDENTITY="" \
		CODE_SIGNING_REQUIRED=NO \
		ONLY_ACTIVE_ARCH=NO

