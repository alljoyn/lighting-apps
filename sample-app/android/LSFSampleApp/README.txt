Building the LSF Sample App for Android

Prerequisites:
 1) The Eclipse development environment with the Android SDK and NDK plugins.
 2) An AllJoyn SDK for Android.
 3) An AllJoyn Config Service build for Android
 4) An AllJoyn Notification Service build for Android
 5) An AllJoyn ControlPanel Service build for Android
 6) An AllJoyn Onboarding Service build for Android
 7) The LSF Sample App project depends on the LSF Java bindings project and
    the LSF Java Helper library project. Make sure all three projects are
    imported into your Eclipse workspace.

Nine path variables in Eclipse are required to build the LSF Sample App for Android.
The following steps will show you how to add the required variables to Eclipse.

 1) From the top menu bar, select Window -> Preferences.
 2) On the left side, expand the General -> Workspace menus and select Linked Resources.
 3) Click "New" to create a new variable.
 4) Enter "ALLJOYN_HOME" for the variable name.
 5) For location, click the "Folder..." button.
 6) Locate the root folder of the AllJoyn Android SDK and set the path of the ALLJOYN_HOME
    variable to "<path_to_android_AJ_SDK_root_folder>/alljoyn_android/core/alljoyn-14.02.00-rel"
 7) Click OK and then OK again. You should see your newly created variable.
 8) Repeat steps 3-7 to create another variable named "NDK_HOME" that points to the root folder
    of the Android NDK (e.g., "<path_to_downloads_folder>/android-ndk-r9c").
 9) Repeat steps 3-7 to create another variable named "ANDROID_HOME" that points to the root folder
    of the Android SDK (e.g., "<path_to_downloads_folder>/adt-bundle-linux-x86_64-20131030/sdk")
10) Repeat steps 3-7 to create another variable named "CONFIG_HOME" that points to
    the top level folder of an AllJoyn Config Service SDK release for Android (e.g.,
    "<path_to_git_downloads_folder>/alljoyn-config-14.12.00a-rel").
11) Repeat steps 3-7 to create another variable named "CONFIG_CLIENT_SAMPLE_HOME" that points to
    the ConfigClientSample folder of an AllJoyn Config Service SDK release for Android (e.g.,
    "<path_to_git_downloads_folder>/alljoyn-config-14.12.00a-rel/samples/ConfigClientSample").
12) Repeat steps 3-7 to create another variable named "NOTIFICATION_HOME" that points to
    the top level folder of an AllJoyn Notification Service SDK release for Android (e.g.,
    "<path_to_git_downloads_folder>/alljoyn-notification-14.12.00a-rel").
13) Repeat steps 3-7 to create another variable named "CONTROLPANEL_HOME" that points to
    the top level folder of an AllJoyn ControlPanel Service SDK release for Android (e.g.,
    "<path_to_git_downloads_folder>/alljoyn-controlpanel-14.12.00a-rel").
14) Repeat steps 3-7 to create another variable named "ONBOARDING_HOME" that points to
    the top level folder of an AllJoyn Onboarding Service SDK release for Android (e.g.,
    "<path_to_git_downloads_folder>/alljoyn-onboarding-14.12.00a-rel").
15) Repeat steps 3-7 to create another variable named "LSF_JAVA_HOME" that points to
    the root folder of LSF Java bindings project (e.g.,
    "<path_to_git_clones_folder>/apps/bindings/java/LSFJava"), or to the appropriate
    Libraries subfolder in the Lighting SDK for Android (e.g.,
    "<path_to_Lighting_SDK_root_folder>/tutorial-app/android/Libraries/LSFJava").
16) Repeat steps 3-7 to create another variable named "LSF_JAVA_HELPER_HOME" that points to
    the root folder of LSF Java Helper library project (e.g.,
    "<path_to_git_clones_folder>/apps/helper-lib/java/LSFJavaHelper"), or to the appropriate
    Libraries subfolder in the Lighting SDK for Android (e.g.,
    "<path_to_Lighting_SDK_root_folder>/tutorial-app/android/Libraries/LSFJavaHelper").
17) Repeat steps 3-7 to create another variable named "LSF_SAMPLE_APP_SRC_MODULE_SCENESV1"
    that points to the configurable scenes v1 source code. To enable full scenes v1
    support, set this variable to
    "<path_to_git_clones_folder>/apps/sample-app/android/LSFSampleApp/modules/scenesv1".
    To disable creation and editing of v1 scenes, set this variable to:
    "<path_to_git_clones_folder>/apps/sample-app/android/LSFSampleApp/modules/null".

