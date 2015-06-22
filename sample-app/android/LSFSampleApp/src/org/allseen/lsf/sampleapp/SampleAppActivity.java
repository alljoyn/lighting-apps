/*
 * Copyright (c) AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

package org.allseen.lsf.sampleapp;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Queue;

import org.allseen.lsf.ErrorCode;
import org.allseen.lsf.LampGroup;
import org.allseen.lsf.LampGroupManager;
import org.allseen.lsf.MasterSceneManager;
import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.SceneManager;
import org.allseen.lsf.TrackingID;
import org.allseen.lsf.sdk.AllCollectionListener;
import org.allseen.lsf.sdk.AllJoynListener;
import org.allseen.lsf.sdk.ControllerErrorEvent;
import org.allseen.lsf.sdk.Group;
import org.allseen.lsf.sdk.Lamp;
import org.allseen.lsf.sdk.LightingController;
import org.allseen.lsf.sdk.LightingItemErrorEvent;
import org.allseen.lsf.sdk.MasterScene;
import org.allseen.lsf.sdk.Preset;
import org.allseen.lsf.sdk.PulseEffect;
import org.allseen.lsf.sdk.Scene;
import org.allseen.lsf.sdk.SceneElement;
import org.allseen.lsf.sdk.SceneV1;
import org.allseen.lsf.sdk.TransitionEffect;
import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.manager.GroupCollectionManager;
import org.allseen.lsf.sdk.manager.LampCollectionManager;
import org.allseen.lsf.sdk.manager.LightingSystemManager;
import org.allseen.lsf.sdk.manager.LightingSystemQueue;
import org.allseen.lsf.sdk.manager.MasterSceneCollectionManager;
import org.allseen.lsf.sdk.manager.SceneCollectionManager;
import org.allseen.lsf.sdk.model.AllLampsDataModel;
import org.allseen.lsf.sdk.model.ColorAverager;
import org.allseen.lsf.sdk.model.ColorStateConverter;
import org.allseen.lsf.sdk.model.ControllerDataModel;
import org.allseen.lsf.sdk.model.GroupDataModel;
import org.allseen.lsf.sdk.model.LampAbout;
import org.allseen.lsf.sdk.model.LampCapabilities;
import org.allseen.lsf.sdk.model.LampDataModel;
import org.allseen.lsf.sdk.model.MasterSceneDataModel;
import org.allseen.lsf.sdk.model.NoEffectDataModel;
import org.allseen.lsf.sdk.model.PresetDataModel;
import org.allseen.lsf.sdk.model.PulseEffectDataModel;
import org.allseen.lsf.sdk.model.SceneDataModel;
import org.allseen.lsf.sdk.model.TransitionEffectDataModel;

import android.app.ActionBar;
import android.app.AlertDialog;
import android.app.FragmentTransaction;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.PopupMenu;
import android.widget.TextView;
import android.widget.Toast;

public class SampleAppActivity extends FragmentActivity implements
        ActionBar.TabListener,
        PopupMenu.OnMenuItemClickListener,
        AllCollectionListener,
        AllJoynListener {
    public static final String TAG = "LSFSampleApp";
    public static final String TAG_TRACE = "LSFSampleApp########";
    public static final String LANGUAGE = "en";

    public static final boolean ERROR_CODE_ENABLED = false; // enables all error dialogs
    public static final boolean ERROR_CODE_VERBOSE = true; // when set to false enables only dependency errors

    public static final long STATE_TRANSITION_DURATION = 100;
    public static final long FIELD_TRANSITION_DURATION = 0;
    public static final long FIELD_CHANGE_HOLDOFF = 25;

    private static final String CONTROLLER_ENABLED = "CONTROLLER_ENABLED_KEY";

    private static long lastFieldChangeMillis = 0;

    public enum Type {
        LAMP, GROUP, SCENE, ELEMENT
    }

    private SampleAppViewPager viewPager;
    public Handler handler;

    public volatile boolean isForeground;
    public volatile Queue<Runnable> runInForeground;

    public LightingSystemManager systemManager;
    private LightingController controllerService;
    private boolean controllerServiceEnabled;
    private volatile boolean controllerServiceStarted;

    public GroupDataModel pendingGroupModel;
    public SceneDataModel pendingBasicSceneModel;
    public MasterSceneDataModel pendingMasterSceneModel;

    public LampGroup pendingBasicSceneElementMembers;
    public LampCapabilities pendingBasicSceneElementCapability;
    public ColorAverager pendingBasicSceneElementColorTempAverager = new ColorAverager();
    public boolean pendingBasicSceneElementMembersHaveEffects;
    public int pendingBasicSceneElementMembersMinColorTemp;
    public int pendingBasicSceneElementMembersMaxColorTemp;

    public NoEffectDataModel pendingNoEffectModel;
    public TransitionEffectDataModel pendingTransitionEffectModel;
    public PulseEffectDataModel pendingPulseEffectModel;

    public PageFrameParentFragment pageFrameParent;

    private AlertDialog wifiDisconnectAlertDialog;
    private AlertDialog errorCodeAlertDialog;
    private String errorCodeAlertDialogMessage;

    private MenuItem addActionMenuItem;
    private MenuItem nextActionMenuItem;
    private MenuItem doneActionMenuItem;
    private MenuItem settingsActionMenuItem;

    private String popupItemID;
    private String popupSubItemID;
    private Toast toast;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sample_app);

        toast = Toast.makeText(this, "", Toast.LENGTH_LONG);

        viewPager = (SampleAppViewPager) findViewById(R.id.sampleAppViewPager);
        viewPager.setActivity(this);

        handler = new Handler(Looper.getMainLooper());
        runInForeground = new LinkedList<Runnable>();

        // Setup localized strings in data models
        ControllerDataModel.defaultName = this.getString(R.string.default_controller_name);

        LampAbout.dataNotFound = this.getString(R.string.data_not_found);

        LampDataModel.defaultName = this.getString(R.string.default_lamp_name);
        GroupDataModel.defaultName = this.getString(R.string.default_group_name);
        PresetDataModel.defaultName = this.getString(R.string.default_preset_name);

        NoEffectDataModel.defaultName = this.getString(R.string.effect_name_none);
        TransitionEffectDataModel.defaultName = this.getString(R.string.effect_name_transition);
        PulseEffectDataModel.defaultName = this.getString(R.string.effect_name_pulse);

        SceneDataModel.defaultName = this.getString(R.string.default_basic_scene_name);
        MasterSceneDataModel.defaultName = this.getString(R.string.default_master_scene_name);

        // Start up the LightingSystemManager
        Log.d(SampleAppActivity.TAG, "===========================================");
        Log.d(SampleAppActivity.TAG, "Creating LightingSystemManager");

        systemManager = new LightingSystemManager();

        systemManager.getLampCollectionManager().addListener(this);
        systemManager.getGroupCollectionManager().addListener(this);
        systemManager.getPresetCollectionManager().addListener(this);
        systemManager.getSceneCollectionManagerV1().addListener(this);
        systemManager.getMasterSceneCollectionManager().addListener(this);
        systemManager.getControllerManager().addListener(this);

        // We initialize the dashboard plugin first to avoid an apparent
        // race condition with processing about announcements.
        initDashboard();

        systemManager.init(
            "SampleApp",
            new LightingSystemQueue() {
                @Override
                public void post(Runnable r) {
                    handler.post(r);
                }

                @Override
                public void postDelayed(Runnable r, int delay) {
                    handler.postDelayed(r, delay);
                }

                @Override
                public void stop() {
                    // Currently nothing to do
                }},
            this);

        // Controller service support
        controllerServiceEnabled = getSharedPreferences("PREFS_READ", Context.MODE_PRIVATE).getBoolean(CONTROLLER_ENABLED, true);
        controllerService = LightingController.get();
        controllerService.init(new SampleAppControllerConfiguration(
                getApplicationContext().getFileStreamPath("").getAbsolutePath(), getApplicationContext()));
    }

    @Override
    protected void onDestroy() {
        if (systemManager != null) {
            systemManager.stop();
        }

        setControllerServiceStarted(false);

        super.onDestroy();
    }

    public boolean isControllerServiceStarted() {
        return controllerServiceStarted;
    }

    private void setControllerServiceStarted(final boolean startControllerService) {
        if (controllerService != null) {
            if (startControllerService) {
                if (!controllerServiceStarted) {
                    controllerServiceStarted = true;
                    controllerService.start();
                }
            } else {
                controllerService.stop();
                controllerServiceStarted = false;
            }
        }
    }

    public boolean isControllerServiceEnabled() {
        return controllerServiceEnabled;
    }

    public void setControllerServiceEnabled(final boolean enableControllerService) {

        if (enableControllerService != controllerServiceStarted) {
            SharedPreferences prefs = getSharedPreferences("PREFS_READ", Context.MODE_PRIVATE);
            Editor e = prefs.edit();
            e.putBoolean(CONTROLLER_ENABLED, enableControllerService);
            e.commit();

            setControllerServiceStarted(enableControllerService);
        }

        controllerServiceEnabled = enableControllerService;
    }

    protected boolean isWifiConnected() {
        NetworkInfo wifiNetworkInfo = ((ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE)).getNetworkInfo(ConnectivityManager.TYPE_WIFI);

        // determine if wifi AP mode is on
        boolean isWifiApEnabled = false;
        WifiManager wifiManager = (WifiManager) getSystemService(Context.WIFI_SERVICE);
        // need reflection because wifi ap is not in the public API
        try {
            Method isWifiApEnabledMethod = wifiManager.getClass().getDeclaredMethod("isWifiApEnabled");
            isWifiApEnabled = (Boolean) isWifiApEnabledMethod.invoke(wifiManager);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Log.d(SampleAppActivity.TAG, "Connectivity state " + wifiNetworkInfo.getState().name() + " - connected:" + wifiNetworkInfo.isConnected() + " hotspot:" + isWifiApEnabled);

        return wifiNetworkInfo.isConnected() || isWifiApEnabled;
    }

    @Override
    public void onAllJoynInitialized() {
        Log.d(SampleAppActivity.TAG, "onAllJoynInitialized()");

        // Handle wifi disconnect errors
        IntentFilter filter = new IntentFilter();
        filter.addAction(ConnectivityManager.CONNECTIVITY_ACTION);

        registerReceiver(new BroadcastReceiver() {
            @Override
            public void onReceive(final Context context, Intent intent) {
                postUpdateControllerDisplay();
                wifiConnectionStateUpdate(isWifiConnected());
            }
        }, filter);
    }

    private boolean actionBarHasAdd() {
        boolean hasAdd = false;
        int tabIndex = viewPager.getCurrentItem();

        if (tabIndex != 0) {
            if (tabIndex == 1) {
                // Groups tab
                hasAdd = (systemManager.getGroupCollectionManager().size() < LampGroupManager.MAX_LAMP_GROUPS);
            } else if (tabIndex == 2) {
                // Scenes tab
                hasAdd =
                    (systemManager.getSceneCollectionManagerV1().size() < SceneManager.MAX_SCENES) ||
                    (systemManager.getMasterSceneCollectionManager().size() < MasterSceneManager.MAX_MASTER_SCENES);
            }
        }

        return hasAdd;
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);

        addActionMenuItem = menu.findItem(R.id.action_add);
        nextActionMenuItem = menu.findItem(R.id.action_next);
        doneActionMenuItem = menu.findItem(R.id.action_done);
        settingsActionMenuItem  = menu.findItem(R.id.action_settings);

        if (pageFrameParent == null) {
            updateActionBar(actionBarHasAdd(), false, false, true);
        }

        return true;
    }

    @Override
    public void onResume() {
        super.onResume();

        isForeground = true;
    }

    @Override
    public void onResumeFragments() {
        super.onResumeFragments();

        // run everything that was queued up whilst in the background
        Log.d(SampleAppActivity.TAG, "Clearing foreground runnable queue");
        while (!runInForeground.isEmpty()) {
            handler.post(runInForeground.remove());
        }
    }

    @Override
    public void onPause() {
        super.onPause();

        isForeground = false;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle item selection
        switch (item.getItemId()) {
            case android.R.id.home:
                if (pageFrameParent != null) {
                    onBackPressed();
                }
                return true;
            case R.id.action_add:
                if (pageFrameParent != null) {
                    pageFrameParent.onActionAdd();
                } else if (viewPager.getCurrentItem() == 1) {
                    doAddGroup((GroupsPageFragment)(getSupportFragmentManager().findFragmentByTag(GroupsPageFragment.TAG)));
                } else {
                    showSceneAddPopup(findViewById(R.id.action_add));
                }
                return true;
            case R.id.action_next:
                if (pageFrameParent != null) pageFrameParent.onActionNext();
                return true;
            case R.id.action_done:
                if (pageFrameParent != null) pageFrameParent.onActionDone();
                return true;
            case R.id.action_settings:
                showSettingsFragment();
                return true;
            case R.id.action_dashboard:
                showDashboard();
                return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onTabSelected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
        // When the given tab is selected, switch to the corresponding page in
        // the ViewPager.
        viewPager.setCurrentItem(tab.getPosition());

        updateActionBar(actionBarHasAdd(), false, false, true);
    }

    @Override
    public void onTabUnselected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
    }

    @Override
    public void onTabReselected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
    }

    public void postOnBackPressed() {
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                onBackPressed();
            }
        }, 5);
    }

    @Override
    public void onBackPressed() {
        int backStackCount = pageFrameParent != null ? pageFrameParent.onBackPressed() : 0;

        if (backStackCount == 1) {
            onClearBackStack();
        } else if (backStackCount == 0) {
            super.onBackPressed();
        }
    }

    public void postInForeground(final Runnable r) {
        handler.post(new Runnable() {
            @Override
            public void run() {
                if (isForeground) {
                    Log.d(SampleAppActivity.TAG, "Foreground runnable running now");
                    handler.post(r);
                } else {
                    Log.d(SampleAppActivity.TAG, "Foreground runnable running later");
                    runInForeground.add(r);
                }
            }
        });
    }

    public void onClearBackStack() {
        pageFrameParent = null;
        resetActionBar();
    }

    public void onItemButtonMore(PageFrameParentFragment parent, Type type, View button, String itemID, String subItemID) {
        switch (type) {
            case LAMP:
                showInfoFragment(parent, itemID);
                return;
            case GROUP:
                showGroupMorePopup(button, itemID);
                return;
            case SCENE:
                showSceneMorePopup(button, itemID);
                return;
            case ELEMENT:
                showSceneElementMorePopup(button, itemID, subItemID);
                return;
        }
    }

    private void showInfoFragment(PageFrameParentFragment parent, String itemID) {
        pageFrameParent = parent;

        parent.showInfoChildFragment(itemID);
    }

    public void applyBasicScene(String basicSceneID) {
        SceneDataModel basicSceneModel = systemManager.getSceneCollectionManagerV1().getModel(basicSceneID);

        if (basicSceneModel != null) {
            String message = String.format(this.getString(R.string.toast_basic_scene_apply), basicSceneModel.getName());

            AllJoynManager.sceneManager.applyScene(basicSceneID);

            showToast(message);
        }
    }

    public void applyMasterScene(String masterSceneID) {
        MasterSceneDataModel masterSceneModel = systemManager.getMasterSceneCollectionManager().getModel(masterSceneID);

        if (masterSceneModel != null) {
            String message = String.format(this.getString(R.string.toast_master_scene_apply), masterSceneModel.getName());

            AllJoynManager.masterSceneManager.applyMasterScene(masterSceneID);

            showToast(message);
        }
    }

    public void wifiConnectionStateUpdate(boolean connected) {
        final SampleAppActivity activity = this;
        if (connected) {
            handler.post(new Runnable() {
                @Override
                public void run() {
                    Log.d(SampleAppActivity.TAG, "wifi connected");

                    postInForeground(new Runnable() {
                        @Override
                        public void run() {
                            Log.d(SampleAppActivity.TAG_TRACE, "Restarting system");

                            systemManager.stop();
                            systemManager.start();

                            if (controllerServiceEnabled) {
                                Log.d(SampleAppActivity.TAG_TRACE, "Starting bundled controller service");
                                setControllerServiceStarted(true);
                            }

                            if (wifiDisconnectAlertDialog != null) {
                                wifiDisconnectAlertDialog.dismiss();
                                wifiDisconnectAlertDialog = null;
                            }
                        }
                    });
                }
            });
        } else {
            handler.post(new Runnable() {
                @Override
                public void run() {
                    Log.d(SampleAppActivity.TAG, "wifi disconnected");

                    postInForeground(new Runnable() {
                        @Override
                        public void run() {
                            if (wifiDisconnectAlertDialog == null) {
                                Log.d(SampleAppActivity.TAG, "Stopping system");

                                systemManager.stop();

                                setControllerServiceStarted(false);

                                View view = activity.getLayoutInflater().inflate(R.layout.view_loading, null);
                                ((TextView) view.findViewById(R.id.loadingText1)).setText(activity.getText(R.string.no_wifi_message));
                                ((TextView) view.findViewById(R.id.loadingText2)).setText(activity.getText(R.string.searching_wifi));

                                AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(activity);
                                alertDialogBuilder.setView(view);
                                alertDialogBuilder.setTitle(R.string.no_wifi);
                                alertDialogBuilder.setCancelable(false);
                                wifiDisconnectAlertDialog = alertDialogBuilder.create();
                                wifiDisconnectAlertDialog.show();
                            }
                        }
                    });
                }
            });
        }
    }

    public void showErrorResponseCode(Enum code, String source) {
        final SampleAppActivity activity = this;
        // creates a message about the error
        StringBuilder sb = new StringBuilder();

        final boolean dependencyError = (code instanceof ResponseCode) && (code == ResponseCode.ERR_DEPENDENCY);
        if (dependencyError) {
            // dependency error
            sb.append(this.getString(R.string.error_dependency));

        } else {
            String name = code.name();

            // default error message
            sb.append(this.getString(R.string.error_code));
            sb.append(" ");
            sb.append(name != null ? name : code.ordinal());
            sb.append(source != null ? " - " + source : "");

        }
        final String message = sb.toString();

        Log.w(SampleAppActivity.TAG, message);

        if (ERROR_CODE_ENABLED) {
            handler.post(new Runnable() {
                @Override
                public void run() {
                    AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(activity);
                    alertDialogBuilder.setTitle(R.string.error_title);
                    alertDialogBuilder.setPositiveButton(R.string.dialog_ok, new OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int id) {
                            errorCodeAlertDialog = null;
                            errorCodeAlertDialogMessage = null;
                            dialog.cancel();
                        }
                    });

                    errorCodeAlertDialog = alertDialogBuilder.create();
                    if (ERROR_CODE_VERBOSE || (!ERROR_CODE_VERBOSE && dependencyError)) {
                        if (errorCodeAlertDialogMessage == null) {
                            errorCodeAlertDialogMessage = message;
                            errorCodeAlertDialog.setMessage(errorCodeAlertDialogMessage);
                            errorCodeAlertDialog.show();
                        } else if (!errorCodeAlertDialogMessage.contains(message)) {
                            errorCodeAlertDialogMessage += System.getProperty("line.separator") + message;
                            errorCodeAlertDialog.setMessage(errorCodeAlertDialogMessage);
                            errorCodeAlertDialog.show();
                        }
                    }
                }
            });
        }
    }

    public void showItemNameDialog(int titleID, ItemNameAdapter adapter) {
        if (adapter != null) {
            View view = getLayoutInflater().inflate(R.layout.view_dialog_item_name, null, false);
            EditText nameText = (EditText)view.findViewById(R.id.itemNameText);
            AlertDialog alertDialog = new AlertDialog.Builder(this)
                .setTitle(titleID)
                .setView(view)
                .setPositiveButton(R.string.dialog_ok, adapter)
                .setNegativeButton(R.string.dialog_cancel, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int id) {
                        dialog.cancel();
                    }})
                .create();

            nameText.addTextChangedListener(new ItemNameDialogTextWatcher(alertDialog, nameText));
            nameText.setText(adapter.getCurrentName());

            alertDialog.show();
        }
    }

    private void showConfirmDeleteBasicSceneDialog(final String basicSceneID) {
        if (basicSceneID != null) {
            SceneDataModel basicSceneModel = systemManager.getSceneCollectionManagerV1().getModel(basicSceneID);

            if (basicSceneModel != null) {
                List<String> parentSceneNames = new ArrayList<String>();
                Iterator<MasterScene> i = systemManager.getMasterSceneCollectionManager().getMasterSceneIterator();

                while (i.hasNext()) {
                    MasterSceneDataModel nextMasterSceneModel = i.next().getMasterSceneDataModel();

                    if (nextMasterSceneModel.containsBasicScene(basicSceneID)) {
                        parentSceneNames.add(nextMasterSceneModel.getName());
                    }
                }

                if (parentSceneNames.size() == 0) {
                    showConfirmDeleteDialog(R.string.menu_basic_scene_delete, R.string.label_basic_scene, basicSceneModel.getName(), new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int id) {
                            Log.d(SampleAppActivity.TAG, "Delete basic scene ID: " + basicSceneID);
                            AllJoynManager.sceneManager.deleteScene(basicSceneID);
                        }});
                } else {
                    String memberNames =  MemberNamesString.format(this, parentSceneNames, MemberNamesOptions.en, 3, "");
                    String message = String.format(getString(R.string.error_dependency_scene_text), basicSceneModel.getName(), memberNames);

                    showPositiveErrorDialog(R.string.error_dependency_scene_title, message);
                }
            }
        }
    }

    private void doDeleteSceneElement(String basicSceneID, String elementID ) {
        if (pendingBasicSceneModel != null) {
            pendingBasicSceneModel.removeElement(elementID);
        }

        refreshScene(basicSceneID);
    }

    private void showConfirmDeleteMasterSceneDialog(final String masterSceneID) {
        if (masterSceneID != null) {
            MasterSceneDataModel masterSceneModel = systemManager.getMasterSceneCollectionManager().getModel(masterSceneID);

            if (masterSceneModel != null) {
                showConfirmDeleteDialog(R.string.menu_master_scene_delete, R.string.label_master_scene, masterSceneModel.getName(), new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int id) {
                        Log.d(SampleAppActivity.TAG, "Delete master scene ID: " + masterSceneID);
                        AllJoynManager.masterSceneManager.deleteMasterScene(masterSceneID);
                    }});
            }
        }
    }

    private void showConfirmDeleteGroupDialog(final String groupID) {
        if (groupID != null) {
            GroupDataModel groupModel = systemManager.getGroupCollectionManager().getModel(groupID);

            if (groupModel != null) {
                List<String> parentGroupNames = new ArrayList<String>();
                List<String> parentSceneNames = new ArrayList<String>();
                Iterator<Group> groupIterator = systemManager.getGroupCollectionManager().getGroupIterator();

                while(groupIterator.hasNext()) {
                    GroupDataModel nextGroupModel = groupIterator.next().getGroupDataModel();

                    if (nextGroupModel.containsGroup(groupID)) {
                        parentGroupNames.add(nextGroupModel.getName());
                    }
                }

                Iterator<SceneV1> sceneIterator = systemManager.getSceneCollectionManagerV1().getSceneIterator();

                while (sceneIterator.hasNext()) {
                    SceneDataModel nextSceneModel = sceneIterator.next().getSceneDataModel();

                    if (nextSceneModel.containsGroup(groupID)) {
                        parentSceneNames.add(nextSceneModel.getName());
                    }
                }

                if ((parentGroupNames.size() == 0) && (parentSceneNames.size() == 0)) {
                    showConfirmDeleteDialog(R.string.menu_group_delete, R.string.label_group, groupModel.getName(), new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int id) {
                            Log.d(SampleAppActivity.TAG, "Delete group ID: " + groupID);
                            AllJoynManager.groupManager.deleteLampGroup(groupID);
                        }
                    });
                } else {
                    String memberNames =  MemberNamesString.format(this, parentGroupNames, parentSceneNames, MemberNamesOptions.en, 3, "");
                    String message = String.format(getString(R.string.error_dependency_group_text), groupModel.getName(), memberNames);

                    showPositiveErrorDialog(R.string.error_dependency_group_title, message);
                }
            }
        }
    }

    private void showConfirmDeletePresetDialog(final String presetID) {
        if (presetID != null) {
            PresetDataModel presetModel = systemManager.getPresetCollectionManager().getModel(presetID);

            if (presetModel != null) {
                List<String> parentSceneNames = new ArrayList<String>();
                Iterator<SceneV1> i = systemManager.getSceneCollectionManagerV1().getSceneIterator();

                while (i.hasNext()) {
                    SceneDataModel nextSceneModel = i.next().getSceneDataModel();

                    if (nextSceneModel.containsPreset(presetID)) {
                        parentSceneNames.add(nextSceneModel.getName());
                    }
                }

                if (parentSceneNames.size() == 0) {
                    showConfirmDeleteDialog(R.string.menu_preset_delete, R.string.label_preset, presetModel.getName(), new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int id) {
                            Log.d(SampleAppActivity.TAG, "Delete preset ID: " + presetID);
                            AllJoynManager.presetManager.deletePreset(presetID);
                        }});
                } else {
                    String memberNames =  MemberNamesString.format(this, parentSceneNames, MemberNamesOptions.en, 3, "");
                    String message = String.format(getString(R.string.error_dependency_preset_text), presetModel.getName(), memberNames);

                    showPositiveErrorDialog(R.string.error_dependency_preset_title, message);
                }
            }
        }
    }

    private void showConfirmDeleteDialog(int titleID, int labelID, String itemName, DialogInterface.OnClickListener onOKListener) {
        View view = getLayoutInflater().inflate(R.layout.view_dialog_confirm_delete, null, false);

        String format = getResources().getString(R.string.dialog_text_delete);
        String label = getResources().getString(labelID);
        String text = String.format(format, label, itemName);

        ((TextView)view.findViewById(R.id.confirmDeleteText)).setText(text);

        new AlertDialog.Builder(this)
            .setTitle(titleID)
            .setView(view)
            .setPositiveButton(R.string.dialog_ok, onOKListener)
            .setNegativeButton(R.string.dialog_cancel, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int id) {
                    dialog.cancel();
                }})
            .create()
            .show();
    }

    private void showPositiveErrorDialog(int titleID, String message) {
        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(this);

        alertDialogBuilder.setTitle(titleID);
        alertDialogBuilder.setMessage(message);
        alertDialogBuilder.setPositiveButton(R.string.dialog_ok, new OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int id) {
                dialog.cancel();
            };
        });
        alertDialogBuilder.show();
    }

    private void showSceneInfo(boolean isMaster) {
        ScenesPageFragment scenesPageFragment = (ScenesPageFragment)getSupportFragmentManager().findFragmentByTag(ScenesPageFragment.TAG);
        scenesPageFragment.setMasterMode(isMaster);

        if (!isMaster) {
            // Copy the selected scene into the pending state
            pendingBasicSceneModel = new SceneDataModel(systemManager.getSceneCollectionManagerV1().getModel(popupItemID));
            pendingBasicSceneElementMembers = new LampGroup();
            pendingBasicSceneElementCapability = new LampCapabilities(true, true, true);
        }

        showInfoFragment(scenesPageFragment, popupItemID);
    }

    public void showLampDetailsFragment(LampsPageFragment parent, String key) {
        pageFrameParent = parent;
        parent.showDetailsChildFragment(key);
    }

    public void doAddGroup(GroupsPageFragment parent) {
        if (parent != null) {
            pageFrameParent = parent;
            parent.showEnterNameChildFragment();
        }
    }

    public void showGroupMorePopup(View anchor, String groupID) {
        popupItemID = groupID;

        PopupMenu popup = new PopupMenu(this, anchor);
        popup.inflate(R.menu.group_more);
        popup.getMenu().findItem(R.id.group_delete).setEnabled(groupID != AllLampsDataModel.ALL_LAMPS_GROUP_ID);
        popup.setOnMenuItemClickListener(this);
        popup.show();
    }

    public boolean isSwipeable() {
        return (pageFrameParent == null);
    }

    public void showSceneMorePopup(View anchor, String sceneID) {
        boolean basicScene = systemManager.getSceneCollectionManagerV1().hasID(sceneID);

        popupItemID = sceneID;

        PopupMenu popup = new PopupMenu(this, anchor);
        popup.inflate(basicScene ? R.menu.basic_scene_more : R.menu.master_scene_more);
        popup.setOnMenuItemClickListener(this);
        popup.show();
    }

    public void showSceneAddPopup(View anchor) {
        popupItemID = null;

        PopupMenu popup = new PopupMenu(this, anchor);
        popup.inflate(R.menu.scene_add);
        popup.getMenu().findItem(R.id.scene_add_basic).setEnabled(systemManager.getSceneCollectionManagerV1().size() < SceneManager.MAX_SCENES);
        popup.getMenu().findItem(R.id.scene_add_master).setEnabled(systemManager.getMasterSceneCollectionManager().size() < MasterSceneManager.MAX_MASTER_SCENES);
        popup.setOnMenuItemClickListener(this);
        popup.show();
    }

    public void showSceneElementMorePopup(View anchor, String itemID, String subItemID) {
        popupItemID = itemID;
        popupSubItemID = subItemID;

        PopupMenu popup = new PopupMenu(this, anchor);
        popup.inflate(R.menu.basic_scene_element_more);
        popup.setOnMenuItemClickListener(this);
        popup.show();
    }

    public void showPresetMorePopup(View anchor, String itemID) {
        popupItemID = itemID;
        popupSubItemID = null;

        PopupMenu popup = new PopupMenu(this, anchor);
        popup.inflate(R.menu.preset_more);
        popup.setOnMenuItemClickListener(this);
        popup.show();
    }

    protected void showSettingsFragment() {
        if (pageFrameParent == null) {
            int pageIndex = viewPager.getCurrentItem();
            String pageTag;

            if (pageIndex == 0) {
                pageTag = LampsPageFragment.TAG;
            } else if (pageIndex == 1) {
                pageTag = GroupsPageFragment.TAG;
            } else {
                pageTag = ScenesPageFragment.TAG;
            }

            pageFrameParent = (PageFrameParentFragment)getSupportFragmentManager().findFragmentByTag(pageTag);
        }

        pageFrameParent.showSettingsChildFragment("");
    }

    protected void initDashboard() {
        try {
            // Use reflection for loose coupling with the Dashboard plugin
            Class<?> dashboardPluginClass = Class.forName("org.alljoyn.dashboard.plugin.DashboardPlugin");

            if (dashboardPluginClass != null) {
                Method getDashboardInstanceMethod = dashboardPluginClass.getMethod("getInstance");

                if (getDashboardInstanceMethod != null) {
                    Method initDashboardMethod = dashboardPluginClass.getMethod("init", android.content.Context.class);

                    if (initDashboardMethod != null) {
                        Log.d(SampleAppActivity.TAG_TRACE, "initializing dashboard");
                        initDashboardMethod.invoke(getDashboardInstanceMethod.invoke(null), this);
                    } else {
                        Log.d(SampleAppActivity.TAG_TRACE, "dashboard init() not found");
                    }
                } else {
                    Log.d(SampleAppActivity.TAG_TRACE, "dashboard getInstance() not found");
                }
            } else {
                Log.d(SampleAppActivity.TAG_TRACE, "dashboard class not found");
            }
        } catch (Exception e) {
            Log.d(SampleAppActivity.TAG_TRACE, "dashboard init failed: " + e.toString());
        }
    }

    protected void showDashboard() {
        boolean success = false;

        try {
            // Use reflection for loose coupling with the Dashboard plugin
            Class<?> dashboardPluginClass = Class.forName("org.alljoyn.dashboard.plugin.DashboardPlugin");

            if (dashboardPluginClass != null) {
                Method getDashboardInstanceMethod = dashboardPluginClass.getMethod("getInstance");

                if (getDashboardInstanceMethod != null) {
                    Method showDashboardMethod = dashboardPluginClass.getMethod("showInitialActivity");

                    if (showDashboardMethod != null) {
                        Log.d(SampleAppActivity.TAG_TRACE, "showing dashboard");
                        showDashboardMethod.invoke(getDashboardInstanceMethod.invoke(null));
                        success = true;
                    } else {
                        Log.d(SampleAppActivity.TAG_TRACE, "dashboard show...() not found");
                    }
                } else {
                    Log.d(SampleAppActivity.TAG_TRACE, "dashboard getInstance() not found");
                }
            } else {
                Log.d(SampleAppActivity.TAG_TRACE, "dashboard class not found");
            }
        } catch (Exception e) {
            Log.d(SampleAppActivity.TAG_TRACE, "dashboard show...() failed: " + e.toString());
        }

        if (!success) {
            showPositiveErrorDialog(R.string.error_dashboard, "Onboarding dashboard plugin not installed.");
        }
    }

    @Override
    public boolean onMenuItemClick(MenuItem item) {
        Log.d(SampleAppActivity.TAG, "onMenuItemClick(): " + item.getItemId());
        boolean result = true;

        switch (item.getItemId()) {
            case R.id.group_info:
                showInfoFragment((GroupsPageFragment)(getSupportFragmentManager().findFragmentByTag(GroupsPageFragment.TAG)), popupItemID);
                break;
            case R.id.group_delete:
                showConfirmDeleteGroupDialog(popupItemID);
                break;
            case R.id.basic_scene_info:
                showSceneInfo(false);
                break;
            case R.id.basic_scene_apply:
                applyBasicScene(popupItemID);
                break;
            case R.id.basic_scene_delete:
                showConfirmDeleteBasicSceneDialog(popupItemID);
                break;
            case R.id.basic_scene_element_delete:
                doDeleteSceneElement(popupItemID, popupSubItemID);
                break;
            case R.id.master_scene_info:
                showSceneInfo(true);
                break;
            case R.id.master_scene_apply:
                applyMasterScene(popupItemID);
                break;
            case R.id.master_scene_delete:
                showConfirmDeleteMasterSceneDialog(popupItemID);
                break;
            case R.id.preset_delete:
                showConfirmDeletePresetDialog(popupItemID);
                break;
            case R.id.scene_add_basic:
                doAddScene((ScenesPageFragment)(getSupportFragmentManager().findFragmentByTag(ScenesPageFragment.TAG)), false);
                break;
            case R.id.scene_add_master:
                doAddScene((ScenesPageFragment)(getSupportFragmentManager().findFragmentByTag(ScenesPageFragment.TAG)), true);
                break;
            default:
                result = false;
                break;
        }

        return result;
    }

    public void doAddScene(ScenesPageFragment parent, boolean isMaster) {
        if (parent != null) {
            pendingNoEffectModel = null;
            pendingTransitionEffectModel = null;
            pendingPulseEffectModel = null;

            pageFrameParent = parent;
            parent.setMasterMode(isMaster);

            if (!isMaster) {
                // Create a dummy scene so that we can momentarily display the info fragment.
                // This makes sure the info fragment is on the back stack so that we can more
                // easily support the scene creation workflow. Note that if the user backs out
                // of the scene creation process, we have to skip over the dummy info fragment
                // (see ScenesPageFragment.onBackPressed())
                pendingBasicSceneModel = new SceneDataModel();
                pendingBasicSceneElementMembers = new LampGroup();
                pendingBasicSceneElementCapability = new LampCapabilities(true, true, true);

                parent.showInfoChildFragment(null);
            }

            parent.showEnterNameChildFragment();
        }
    }

    public void resetActionBar() {
        updateActionBar(null, true, actionBarHasAdd(), false, false, true);
    }

    public void updateActionBar(int titleID, boolean tabs, boolean add, boolean next, boolean done, boolean settings) {
        updateActionBar(getResources().getString(titleID), tabs, add, next, done, settings);
    }

    protected void updateActionBar(String title, boolean tabs, boolean add, boolean next, boolean done, boolean settings) {
        Log.d(SampleAppActivity.TAG, "Updating action bar to " + title);
        ActionBar actionBar = getActionBar();

        actionBar.setTitle(title != null ? title : getTitle());
        actionBar.setNavigationMode(tabs ? ActionBar.NAVIGATION_MODE_TABS : ActionBar.NAVIGATION_MODE_STANDARD);
        actionBar.setDisplayHomeAsUpEnabled(!tabs);

        updateActionBar(add, next, done, settings);
    }

    protected void updateActionBar(boolean add, boolean next, boolean done, boolean settings) {
        if (addActionMenuItem != null) {
            addActionMenuItem.setVisible(add);
        }

        if (nextActionMenuItem != null) {
            nextActionMenuItem.setVisible(next);
        }

        if (doneActionMenuItem != null) {
            doneActionMenuItem.setVisible(done);
        }

        if (settingsActionMenuItem != null) {
            settingsActionMenuItem.setVisible(settings);
        }
    }

    public void setActionBarNextEnabled(boolean isEnabled) {
        if (nextActionMenuItem != null) {
            nextActionMenuItem.setEnabled(isEnabled);
        }
    }

    public void setActionBarDoneEnabled(boolean isEnabled) {
        if (doneActionMenuItem != null) {
            doneActionMenuItem.setEnabled(isEnabled);
        }
    }

    public void togglePower(SampleAppActivity.Type type, String itemID) {
        // determines the action to take, based on the type
        switch (type) {
        case LAMP:
            LampDataModel lampModel = systemManager.getLampCollectionManager().getModel(itemID);
            if (lampModel != null) {
                // raise brightness to 25% if needed
                if (!lampModel.state.getOnOff() && lampModel.state.getBrightness() == 0) {
                    setBrightness(type, itemID, 25);
                }

                Log.d(SampleAppActivity.TAG, "Toggle power for " + itemID);

                AllJoynManager.lampManager.transitionLampStateOnOffField(lampModel.id, !lampModel.state.getOnOff());
            }
            break;

        case GROUP:
            GroupDataModel groupModel = systemManager.getGroupCollectionManager().getModel(itemID);
            if (groupModel != null) {
                // raise brightness to 25% if needed
                if (!groupModel.state.getOnOff() && groupModel.state.getBrightness() == 0) {
                    setBrightness(type, itemID, 25);
                }

                Log.d(SampleAppActivity.TAG, "Toggle power for " + itemID);

                // Group fields cannot be read back directly, so set it here
                groupModel.state.setOnOff(!groupModel.state.getOnOff());

                AllJoynManager.groupManager.transitionLampGroupStateOnOffField(groupModel.id, groupModel.state.getOnOff());
            }
            break;

        case SCENE:
        case ELEMENT:

            break;

        }
    }

    private boolean allowFieldChange() {
        boolean allow = false;
        long currentTimeMillis = Calendar.getInstance().getTimeInMillis();

        if (currentTimeMillis - lastFieldChangeMillis > FIELD_CHANGE_HOLDOFF) {
            lastFieldChangeMillis = currentTimeMillis;
            allow = true;
        }

        return allow;
    }

    public void setBrightness(SampleAppActivity.Type type, String itemID, int viewBrightness) {
        long modelBrightness = ColorStateConverter.convertBrightnessViewToModel(viewBrightness);

        Log.d(SampleAppActivity.TAG, "Set brightness for " + itemID + " to " + viewBrightness + "(" + modelBrightness + ")");

        // determines the action to take, based on the type
        if (allowFieldChange()) {
            switch (type) {
                case LAMP:
                    LampDataModel lampModel = systemManager.getLampCollectionManager().getModel(itemID);
                    if (lampModel != null) {
                        AllJoynManager.lampManager.transitionLampStateBrightnessField(itemID, modelBrightness, FIELD_TRANSITION_DURATION);

                        if (viewBrightness == 0) {
                            AllJoynManager.lampManager.transitionLampStateOnOffField(lampModel.id, false);
                        } else {
                            if (ColorStateConverter.convertBrightnessModelToView(lampModel.state.getBrightness()) == 0 && lampModel.state.getOnOff() == false) {
                                AllJoynManager.lampManager.transitionLampStateOnOffField(lampModel.id, true);
                            }
                        }
                    }
                    break;

                case GROUP:
                    GroupDataModel groupModel = systemManager.getGroupCollectionManager().getModel(itemID);
                    if (groupModel != null) {
                        AllJoynManager.groupManager.transitionLampGroupStateBrightnessField(itemID, modelBrightness, FIELD_TRANSITION_DURATION);

                        if (viewBrightness == 0) {
                            AllJoynManager.groupManager.transitionLampGroupStateOnOffField(groupModel.id, false);
                        } else {
                            if (ColorStateConverter.convertBrightnessModelToView(groupModel.state.getBrightness()) == 0 && groupModel.state.getOnOff() == false) {
                                AllJoynManager.groupManager.transitionLampGroupStateOnOffField(groupModel.id, true);
                            }
                        }

                        // Group fields cannot be read back directly, so set it here
                        groupModel.state.setBrightness(modelBrightness);
                    }
                    break;

                case SCENE:
                case ELEMENT:
                    break;

            }
        }
    }

    public void setHue(SampleAppActivity.Type type, String itemID, int viewHue) {
        long modelHue = ColorStateConverter.convertHueViewToModel(viewHue);

        Log.d(SampleAppActivity.TAG, "Set hue for " + itemID + " to " + viewHue + "(" + modelHue + ")");

        // determines the action to take, based on the type
        if (allowFieldChange()) {
            switch (type) {
            case LAMP:
                LampDataModel lampModel = systemManager.getLampCollectionManager().getModel(itemID);
                if (lampModel != null) {
                    AllJoynManager.lampManager.transitionLampStateHueField(itemID, modelHue, FIELD_TRANSITION_DURATION);
                }
                break;

            case GROUP:
                GroupDataModel groupModel = systemManager.getGroupCollectionManager().getModel(itemID);
                if (groupModel != null) {
                    // Group fields cannot be read back directly, so set it here
                    groupModel.state.setHue(modelHue);

                    AllJoynManager.groupManager.transitionLampGroupStateHueField(itemID, modelHue, FIELD_TRANSITION_DURATION);
                }
                break;

            case SCENE:
            case ELEMENT:
                break;

            }
        }
    }

    public void setSaturation(SampleAppActivity.Type type, String itemID, int viewSaturation) {
        long modelSaturation = ColorStateConverter.convertSaturationViewToModel(viewSaturation);

        Log.d(SampleAppActivity.TAG, "Set saturation for " + itemID + " to " + viewSaturation + "(" + modelSaturation + ")");

        // determines the action to take, based on the type
        if (allowFieldChange()) {
            switch (type) {
            case LAMP:
                LampDataModel lampModel = systemManager.getLampCollectionManager().getModel(itemID);
                if (lampModel != null) {
                    AllJoynManager.lampManager.transitionLampStateSaturationField(itemID, modelSaturation, FIELD_TRANSITION_DURATION);
                }
                break;

            case GROUP:
                GroupDataModel groupModel = systemManager.getGroupCollectionManager().getModel(itemID);
                if (groupModel != null) {
                    // Group fields cannot be read back directly, so set it here
                    groupModel.state.setSaturation(modelSaturation);

                    AllJoynManager.groupManager.transitionLampGroupStateSaturationField(itemID, modelSaturation, FIELD_TRANSITION_DURATION);
                }
                break;

            case SCENE:
            case ELEMENT:
                break;

            }
        }
    }

    public void setColorTemp(SampleAppActivity.Type type, String itemID, int viewColorTemp) {
        long modelColorTemp = ColorStateConverter.convertColorTempViewToModel(viewColorTemp);

        Log.d(SampleAppActivity.TAG, "Set color temp for " + itemID + " to " + viewColorTemp + "(" + modelColorTemp + ")");

        // determines the action to take, based on the type
        if (allowFieldChange()) {
            switch(type) {
            case LAMP:
                LampDataModel lampModel = systemManager.getLampCollectionManager().getModel(itemID);
                if (lampModel != null) {
                    AllJoynManager.lampManager.transitionLampStateColorTempField(itemID, modelColorTemp, FIELD_TRANSITION_DURATION);
                }
                break;

            case GROUP:
                GroupDataModel groupModel = systemManager.getGroupCollectionManager().getModel(itemID);
                if (groupModel != null) {
                    // Group fields cannot be read back directly, so set it here
                    groupModel.state.setColorTemp(modelColorTemp);

                    AllJoynManager.groupManager.transitionLampGroupStateColorTempField(itemID, modelColorTemp, FIELD_TRANSITION_DURATION);
                }
                break;

            case SCENE:
            case ELEMENT:
                break;
            }
        }
    }

    public void createLostConnectionErrorDialog(String name) {
        pageFrameParent.clearBackStack();
        showPositiveErrorDialog(R.string.error_connection_lost_dialog_text, String.format(getString(R.string.error_connection_lost_dialog_text), name));
    }

    public void setTabTitles() {
        Log.d(SampleAppActivity.TAG, "setTabTitles()");
        ActionBar actionBar = getActionBar();
        for (int i = 0; i < actionBar.getTabCount(); i++) {
            actionBar.getTabAt(i).setText(getPageTitle(i));
        }
    }

    public CharSequence getPageTitle(int index) {
        Locale locale = Locale.ENGLISH;
        CharSequence title;

        if (index == 0) {
            LampCollectionManager lampCollection = systemManager != null ? systemManager.getLampCollectionManager() : null;
            title = getString(R.string.title_tab_lamps, lampCollection != null ? lampCollection.size() : 0).toUpperCase(locale);
        } else if (index == 1) {
            GroupCollectionManager groupCollection = systemManager != null ? systemManager.getGroupCollectionManager() : null;
            title = getString(R.string.title_tab_groups, groupCollection != null ? groupCollection.size() : 0).toUpperCase(locale);
        } else if (index == 2) {
            SceneCollectionManager sceneCollection = systemManager != null ? systemManager.getSceneCollectionManagerV1() : null;
            MasterSceneCollectionManager masterCollection = systemManager != null ? systemManager.getMasterSceneCollectionManager() : null;
            title = getString(R.string.title_tab_scenes, (sceneCollection != null ? sceneCollection.size() : 0) + (masterCollection != null ? masterCollection.size() : 0)).toUpperCase(locale);
        } else {
            title = null;
        }

        return title;
    }

    public void showToast(int resId){

        toast = Toast.makeText(this, resId, Toast.LENGTH_LONG);
        toast.show();
    }

    public void showToast(String text){

        toast = Toast.makeText(this, text, Toast.LENGTH_LONG);
        toast.show();
    }

    public Toast getToast(){
        return toast;
    }

    @Override
    public void onLampInitialized(final Lamp lamp) {
        // used; intentionally left blank
    }

    @Override
    public void onLampChanged(final Lamp lamp) {
        final LampDataModel lampModel = lamp.getLampDataModel();

        Log.d(SampleAppActivity.TAG, "onLampChanged() " + lampModel.id);

        handler.post(new Runnable() {
            @Override
            public void run() {
                Fragment lampsPageFragment = getSupportFragmentManager().findFragmentByTag(LampsPageFragment.TAG);

                if (lampsPageFragment != null) {
                    LampsTableFragment tableFragment = (LampsTableFragment)lampsPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE);

                    if (tableFragment != null) {
                        tableFragment.addElement(lampModel.id);
                    }

                    LampInfoFragment infoFragment = (LampInfoFragment)lampsPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_INFO);

                    if (infoFragment != null) {
                        infoFragment.updateInfoFields(lampModel);
                    }

                    LampDetailsFragment detailsFragment = (LampDetailsFragment)lampsPageFragment.getChildFragmentManager().findFragmentByTag(LampsPageFragment.CHILD_TAG_DETAILS);

                    if (detailsFragment != null) {
                        detailsFragment.updateDetailFields(lampModel);
                    }
                }

                systemManager.groupManagerCB.postUpdateDependentLampGroups(lampModel.id);

                refreshScene(null);
            }
        });
    }

    @Override
    public void onLampRemoved(final Lamp lamp) {
        final String lampID = lamp.getLampDataModel().id;

        Log.d(SampleAppActivity.TAG, "onLampRemoved() " + lampID);

        handler.post(new Runnable() {
            @Override
            public void run() {
                Fragment pageFragment = getSupportFragmentManager().findFragmentByTag(LampsPageFragment.TAG);

                if (pageFragment != null) {
                    LampsTableFragment tableFragment = (LampsTableFragment) pageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE);

                    if (tableFragment != null) {
                        tableFragment.removeElement(lampID);

                        if (systemManager.getLampCollectionManager().size() == 0) {
                            tableFragment.updateLoading();
                        }
                    }
                }
            }
        });
    }

    @Override
    public void onLampError(final LightingItemErrorEvent error) {
        Log.d(SampleAppActivity.TAG, "onLampError()");

        handler.post(new Runnable() {
            @Override
            public void run() {
                showErrorResponseCode(error.responseCode, error.name);
            }
        });
    }

    @Override
    public void onGroupInitialized(final TrackingID trackingID, Group group) {
        // used; intentionally left blank
    }

    @Override
    public void onGroupChanged(Group group) {
        GroupDataModel groupModel = group.getGroupDataModel();

        Log.d(SampleAppActivity.TAG, "onGroupChanged() " + groupModel.id);

        Fragment pageFragment = getSupportFragmentManager().findFragmentByTag(GroupsPageFragment.TAG);

        if (pageFragment != null) {
            GroupsTableFragment tableFragment = (GroupsTableFragment)pageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE);

            if (tableFragment != null) {
                tableFragment.addElement(groupModel.id);

                if (isSwipeable()) {
                    resetActionBar();
                }
            }

            GroupInfoFragment infoFragment = (GroupInfoFragment)pageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_INFO);

            if (infoFragment != null) {
                infoFragment.updateInfoFields(groupModel);
            }
        }
    }

    @Override
    public void onGroupRemoved(Group group) {
        String groupID = group.getGroupDataModel().id;

        Log.d(SampleAppActivity.TAG, "onGroupRemoved() " + groupID);

        Fragment pageFragment = getSupportFragmentManager().findFragmentByTag(GroupsPageFragment.TAG);
        FragmentManager childManager = pageFragment != null ? pageFragment.getChildFragmentManager() : null;
        GroupsTableFragment tableFragment = childManager != null ? (GroupsTableFragment)childManager.findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE) : null;
        GroupInfoFragment infoFragment = childManager != null ? (GroupInfoFragment)childManager.findFragmentByTag(PageFrameParentFragment.CHILD_TAG_INFO) : null;

        if (tableFragment != null) {
            tableFragment.removeElement(groupID);

            if (isSwipeable()) {
                resetActionBar();
            }
        }

        if ((infoFragment != null) && (infoFragment.key.equals(groupID))) {
            createLostConnectionErrorDialog(group.getName());
        }
    }

    @Override
    public void onGroupError(final LightingItemErrorEvent error) {
        Log.d(SampleAppActivity.TAG, "onGroupError()");

        handler.post(new Runnable() {
            @Override
            public void run() {
                showErrorResponseCode(error.responseCode, error.name);
            }
        });
    }

    @Override
    public void onPresetInitialized(final TrackingID trackingID, Preset preset) {
        // used; intentionally left blank
    }

    @Override
    public void onPresetChanged(Preset preset) {
        String presetID = preset.getPresetDataModel().id;

        Log.d(SampleAppActivity.TAG, "onPresetChanged() " + presetID);

        updatePresetFragment(LampsPageFragment.TAG);
        updatePresetFragment(GroupsPageFragment.TAG);
        updatePresetFragment(ScenesPageFragment.TAG);

        updateInfoFragmentPresetFields(LampsPageFragment.TAG, PageFrameParentFragment.CHILD_TAG_INFO);
        updateInfoFragmentPresetFields(GroupsPageFragment.TAG, PageFrameParentFragment.CHILD_TAG_INFO);
        updateInfoFragmentPresetFields(ScenesPageFragment.TAG, ScenesPageFragment.CHILD_TAG_CONSTANT_EFFECT);
        updateInfoFragmentPresetFields(ScenesPageFragment.TAG, ScenesPageFragment.CHILD_TAG_TRANSITION_EFFECT);
        updateInfoFragmentPresetFields(ScenesPageFragment.TAG, ScenesPageFragment.CHILD_TAG_PULSE_EFFECT);
    }

    @Override
    public void onPresetRemoved(Preset preset) {
        String presetID = preset.getPresetDataModel().id;

        Log.d(SampleAppActivity.TAG, "onPresetRemoved() " + presetID);

        removePreset(LampsPageFragment.TAG, presetID);
        removePreset(GroupsPageFragment.TAG, presetID);
        removePreset(ScenesPageFragment.TAG, presetID);
    }

    @Override
    public void onPresetError(final LightingItemErrorEvent error) {
        Log.d(SampleAppActivity.TAG, "onPresetError()");

        handler.post(new Runnable() {
            @Override
            public void run() {
                showErrorResponseCode(error.responseCode, error.name);
            }
        });
    }

    private void updatePresetFragment(String pageFragmentTag) {
        Fragment pageFragment = getSupportFragmentManager().findFragmentByTag(pageFragmentTag);

        if (pageFragment != null) {
            FragmentManager childManager = pageFragment.getChildFragmentManager();
            DimmableItemPresetsFragment presetFragment = (DimmableItemPresetsFragment)childManager.findFragmentByTag(PageFrameParentFragment.CHILD_TAG_PRESETS);

            updatePresetFragment(presetFragment);
        }
    }

    private void updatePresetFragment(DimmableItemPresetsFragment presetFragment) {
        if (presetFragment != null) {
            presetFragment.onUpdateView();
        }
    }


    private void updateInfoFragmentPresetFields(String pageFragmentTag, String infoFragmentTag) {
        Fragment pageFragment = getSupportFragmentManager().findFragmentByTag(pageFragmentTag);

        if (pageFragment != null) {
            updateinfoFragmentPresetFields((DimmableItemInfoFragment)pageFragment.getChildFragmentManager().findFragmentByTag(infoFragmentTag));
        }
    }

    private void updateinfoFragmentPresetFields(DimmableItemInfoFragment infoFragment) {
        if (infoFragment != null) {
            infoFragment.updatePresetFields();
        }
    }

    private void removePreset(String pageFragmentTag, String presetID) {
        Fragment pageFragment = getSupportFragmentManager().findFragmentByTag(pageFragmentTag);

        if (pageFragment != null) {
            FragmentManager childManager = pageFragment.getChildFragmentManager();
            DimmableItemPresetsFragment presetFragment = (DimmableItemPresetsFragment)childManager.findFragmentByTag(PageFrameParentFragment.CHILD_TAG_PRESETS);

            removePreset(presetFragment, presetID);
        }
    }

    private void removePreset(DimmableItemPresetsFragment presetFragment, String presetID) {
        if (presetFragment != null) {
            presetFragment.removeElement(presetID);
        }
    }

    @Override
    public void onSceneInitialized(final TrackingID trackingID, Scene scene) {
        // used; intentionally left blank
    }

    @Override
    public void onSceneChanged(Scene scene) {
        if (scene instanceof SceneV1) {
            String sceneID = ((SceneV1)scene).getSceneDataModel().id;

            Log.d(SampleAppActivity.TAG, "onSceneChanged() " + sceneID);

            refreshScene(sceneID);
        }
    }

    @Override
    public void onSceneRemoved(Scene scene) {
        if (scene instanceof SceneV1) {
            SceneDataModel sceneModel = ((SceneV1)scene).getSceneDataModel();
            String sceneID = sceneModel.id;

            Log.d(SampleAppActivity.TAG, "onSceneRemoved() " + sceneID);

            Fragment pageFragment = getSupportFragmentManager().findFragmentByTag(ScenesPageFragment.TAG);
            FragmentManager childManager = pageFragment != null ? pageFragment.getChildFragmentManager() : null;
            ScenesTableFragment tableFragment = childManager != null ? (ScenesTableFragment)childManager.findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE) : null;
            BasicSceneInfoFragment infoFragment = childManager != null ? (BasicSceneInfoFragment)childManager.findFragmentByTag(PageFrameParentFragment.CHILD_TAG_INFO) : null;

            if (tableFragment != null) {
                tableFragment.removeElement(sceneID);

                if (isSwipeable()) {
                    resetActionBar();
                }
            }

            if ((infoFragment != null) && (infoFragment.key.equals(sceneID))) {
                createLostConnectionErrorDialog(sceneModel.getName());
            }
        }
    }

    @Override
    public void onSceneError(final LightingItemErrorEvent error) {
        Log.d(SampleAppActivity.TAG, "onSceneError()");

        handler.post(new Runnable() {
            @Override
            public void run() {
                showErrorResponseCode(error.responseCode, error.name);
            }
        });
    }

    private void refreshScene(String sceneID) {
        ScenesPageFragment scenesPageFragment = (ScenesPageFragment)getSupportFragmentManager().findFragmentByTag(ScenesPageFragment.TAG);

        if (scenesPageFragment != null) {
            ScenesTableFragment basicSceneTableFragment = (ScenesTableFragment)scenesPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE);

            if (basicSceneTableFragment != null && sceneID != null) {
                basicSceneTableFragment.addElement(sceneID);

                if (isSwipeable()) {
                    resetActionBar();
                }
            }

            if (!scenesPageFragment.isMasterMode()) {
                BasicSceneInfoFragment basicSceneInfoFragment = (BasicSceneInfoFragment)scenesPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_INFO);

                if (basicSceneInfoFragment != null) {
                    basicSceneInfoFragment.updateInfoFields();
                }
            }
        }
    }

    @Override
    public void onMasterSceneInitialized(final TrackingID trackingID, MasterScene masterScener) {
        // used; intentionally left blank
    }

    @Override
    public void onMasterSceneChanged(MasterScene masterScene) {
        String masterSceneID = masterScene.getMasterSceneDataModel().id;

        Log.d(SampleAppActivity.TAG, "onMasterSceneChanged() " + masterSceneID);

        ScenesPageFragment scenesPageFragment = (ScenesPageFragment)getSupportFragmentManager().findFragmentByTag(ScenesPageFragment.TAG);

        if (scenesPageFragment != null) {
            ScenesTableFragment scenesTableFragment = (ScenesTableFragment)scenesPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE);

            if (scenesTableFragment != null) {
                scenesTableFragment.addElement(masterSceneID);

                if (isSwipeable()) {
                    resetActionBar();
                }
            }

            if (scenesPageFragment.isMasterMode()) {
                MasterSceneInfoFragment masterSceneInfoFragment = (MasterSceneInfoFragment)scenesPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_INFO);

                if (masterSceneInfoFragment != null) {
                    masterSceneInfoFragment.updateInfoFields();
                }
            }
        }
    }

    @Override
    public void onMasterSceneRemoved(MasterScene masterScene) {
        MasterSceneDataModel masterSceneModel = masterScene.getMasterSceneDataModel();
        String masterSceneID = masterSceneModel.id;

        Log.d(SampleAppActivity.TAG, "onMasterSceneRemoved() " + masterSceneID);

        Fragment pageFragment = getSupportFragmentManager().findFragmentByTag(ScenesPageFragment.TAG);
        FragmentManager childManager = pageFragment != null ? pageFragment.getChildFragmentManager() : null;
        ScenesTableFragment tableFragment = childManager != null ? (ScenesTableFragment)childManager.findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE) : null;
        MasterSceneInfoFragment infoFragment = childManager != null ? (MasterSceneInfoFragment)childManager.findFragmentByTag(PageFrameParentFragment.CHILD_TAG_INFO) : null;

        if (tableFragment != null) {
            tableFragment.removeElement(masterSceneID);

            if (isSwipeable()) {
                resetActionBar();
            }
        }

        if ((infoFragment != null) && (infoFragment.key.equals(masterSceneID))) {
            createLostConnectionErrorDialog(masterSceneModel.getName());
        }
    }

    @Override
    public void onMasterSceneError(final LightingItemErrorEvent error) {
        Log.d(SampleAppActivity.TAG, "onMasterSceneError()");

        handler.post(new Runnable() {
            @Override
            public void run() {
                showErrorResponseCode(error.responseCode, error.name);
            }
        });
    }

    @Override
    public void onLeaderModelChange(ControllerDataModel leadModel) {
        postUpdateControllerDisplay();
    }

    @Override
    public void onControllerErrors(final ControllerErrorEvent errorEvent) {
        handler.post(new Runnable() {
            @Override
            public void run() {
                for (ErrorCode ec : errorEvent.errorCodes) {
                    if (!ec.equals(ErrorCode.NONE)) {
                        showErrorResponseCode(ec, errorEvent.name);
                    }
                }
            }
        });
    }

    protected void postUpdateControllerDisplay() {
        postInForeground(new Runnable() {
            @Override
            public void run() {
                FragmentManager fragmentManager = getSupportFragmentManager();
                PageFrameParentFragment lampsPageFragment = (PageFrameParentFragment)fragmentManager.findFragmentByTag(LampsPageFragment.TAG);
                PageFrameParentFragment groupsPageFragment = (PageFrameParentFragment)fragmentManager.findFragmentByTag(GroupsPageFragment.TAG);
                PageFrameParentFragment scenesPageFragment = (PageFrameParentFragment)fragmentManager.findFragmentByTag(ScenesPageFragment.TAG);
                Fragment settingsFragment = null;

                if (lampsPageFragment != null) {
                    ScrollableTableFragment tableFragment = (ScrollableTableFragment) lampsPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE);

                    if (!AllJoynManager.controllerConnected) {
                        lampsPageFragment.clearBackStack();
                    }

                    if (tableFragment != null) {
                        tableFragment.updateLoading();
                    }

                    if (settingsFragment == null) {
                        settingsFragment = lampsPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_SETTINGS);
                    }
                }

                if (groupsPageFragment != null) {
                    ScrollableTableFragment tableFragment = (ScrollableTableFragment) groupsPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE);

                    if (!AllJoynManager.controllerConnected) {
                        groupsPageFragment.clearBackStack();
                    }

                    if (tableFragment != null) {
                        tableFragment.updateLoading();
                    }

                    if (settingsFragment == null) {
                        settingsFragment = groupsPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_SETTINGS);
                    }
                }

                if (scenesPageFragment != null) {
                    ScrollableTableFragment tableFragment = (ScrollableTableFragment) scenesPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_TABLE);

                    if (!AllJoynManager.controllerConnected) {
                        scenesPageFragment.clearBackStack();
                    }

                    if (tableFragment != null) {
                        tableFragment.updateLoading();
                    }

                    if (settingsFragment == null) {
                        settingsFragment = scenesPageFragment.getChildFragmentManager().findFragmentByTag(PageFrameParentFragment.CHILD_TAG_SETTINGS);
                    }
                }

                if (settingsFragment != null) {
                    ((SettingsFragment)settingsFragment).onUpdateView();
                }
            }
        });
    }

    @Override
    public void onTransitionEffectInitialized(final TrackingID trackingID, TransitionEffect effect) {
        // used; intentionally left blank
    }

    @Override
    public void onTransitionEffectChanged(TransitionEffect effect) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onTransitionEffectError(LightingItemErrorEvent error) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onTransitionEffectRemoved(TransitionEffect effect) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onPulseEffectInitialized(final TrackingID trackingID, PulseEffect effect) {
        // used; intentionally left blank
    }

    @Override
    public void onPulseEffectChanged(PulseEffect effect) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onPulseEffectError(LightingItemErrorEvent error) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onPulseEffectRemoved(PulseEffect effect) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onSceneElementInitialized(final TrackingID trackingID, SceneElement element) {
        // used; intentionally left blank
    }

    @Override
    public void onSceneElementChanged(SceneElement element) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onSceneElementError(LightingItemErrorEvent error) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onSceneElementRemoved(SceneElement element) {
        // TODO Auto-generated method stub

    }
}
