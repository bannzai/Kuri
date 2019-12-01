PROJECT?=Kuri
PACKAGE?=Kuri
DEMO_DIRECTORY=KuriDemo
BUILD_DIRECTORY?=.build

dry-run: build
	cd $(DEMO_DIRECTORY)
	kuri generate Demo
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
