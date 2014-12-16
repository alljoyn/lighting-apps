Building the LSF Tutorial App for iOS (LSFTutorial)

Prerequisites:

1) Mac OS X Mavericks (10.9) or above
2) Xcode 5.1.1 or above
3) Be a registered apple developer (https://developer.apple.com/register/index.action)
4) Build OpenSSL for iOS. Directions can be found here (https://allseenalliance.org/developers/develop/building/ios-osx)
   under the section "Set up OpenSSL dependencies" starting from the first "git clone" command and stopping at the last
   "xcodebuild" instruction.

Four Xcode "Source Tree" variables are used to reference the required binaries and header files needed to build the LSFTutorial 
project. The steps to build the app and push it to an iOS device are as follows:

1) After unzipping the SDK, start Xcode.
2) Open Xcode preferences, Xcode -> Preferences...
3) Select the "Locations" tab and select "Source Trees"
4) Click the "+" button to add a new variable
5) Enter the following:
   a) "ALLJOYN_HOME" for the Name
   b) "AllJoyn Home" for the Display Name
   c) "<lsf_tutorial_install_dir>/iOS/Projects/alljoyn" for the Path
6) Create another variable by repeating steps 4-5 using the following information:
   a) "APPS_HOME" for the Name
   b) "Apps Home" for the Display Name
   c) "<lsf_tutorial_install_dir>/iOS/Projects/lsf" for the Path
7) Create another variable by repeating steps 4-5 using the following information:
   a) "LSF_HOME" for the Name
   b) "LSF Home" for the Display Name
   c) "<lsf_tutorial_install_dir>/iOS/Projects/service_framework" for the Path
8) Create another variable by repeating steps 4-5 using the following information:
   a) "OPENSSL_ROOT" for the Name
   b) "OpenSSL Root" for the Display Name
   c) "<open_ssl_install_dir>" for the Path (see #4 in the prerequisites section)
9) Open the LSFTutorial Xcode project at the following path:
   "<lsf_tutorial_install_dir>/iOS/Projects/lsf/apps/tutorial-app/iOS/LSFTutorial/LSFTutorial.xcodeproj"
10) In the top-left, ensure that "LSFTutorial" is set as the active build scheme and your are building
    for the connected iOS device.
11) Click the "Play" button in the top-left to build and run the application on your iOS device.