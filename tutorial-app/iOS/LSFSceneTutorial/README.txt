Building the LSF Scene Tutorial App for iOS (LSFSceneTutorial)

Prerequisites:

1) Mac OS X Mavericks (10.9) or above
2) Xcode 5.1.1 or above
3) Be a registered apple developer (https://developer.apple.com/register/index.action)
4) Build OpenSSL for iOS. Directions can be found here (https://allseenalliance.org/developers/develop/building/ios-osx)
   under the section "Set up OpenSSL dependencies" starting from the first "git clone" command and stopping at the last
   "xcodebuild" instruction.

Two Xcode "Source Tree" variables are used to reference the required binaries and header files needed to build the LSFSceneTutorial 
project. The steps to build the app and push it to an iOS device are as follows:

1) After unzipping the SDK, start Xcode.
2) Open Xcode preferences, Xcode -> Preferences...
3) Select the "Locations" tab and select "Source Trees"
4) Click the "+" button to add a new variable
5) Enter the following:
   a) "LSF_SDK_ROOT" for the Name
   b) "LSF SDK Root" for the Display Name
   c) "<lsf_sdk_install_dir>" for the Path (This should be the root folder of the LSF SDK)
6) Create another variable by repeating steps 4-5 using the following information:
   a) "OPENSSL_ROOT" for the Name
   b) "OpenSSL Root" for the Display Name
   c) "<open_ssl_install_dir>" for the Path (see #4 in the prerequisites section)
7) Open the LSFSceneTutorial Xcode project at the following path:
   "<lsf_sdk_install_dir>/iOS/LSFSceneTutorial/LSFSceneTutorial.xcodeproj"
8) In the top-left, ensure that "LSFSceneTutorial" is set as the active build scheme and your are building
    for the connected iOS device.
9) Click the "Play" button in the top-left to build and run the application on your iOS device.

Threading Rules for LSF SDK Usage:
1) One must not block the Lighting thread (note: all of the delegate methods are called on the Lighting thread)
2) One must perform all interaction with the lighting system (i.e. the LightingDirector) on the lighting thread

Example of Mandatory Calls to Initialize the Lighting Director:

        lightingDirector = [LSFSDKLightingDirector getLightingDirector];
        [lightingDirector addDelegate: YOUR_LISTENER];
        [lightingDirector start: @"YOUR_APP_NAME"];

Full Documentation can be found at <lsf_sdk_install_dir>/iOS/Libraries/LSFObjCHelper/doc/html/index.html
