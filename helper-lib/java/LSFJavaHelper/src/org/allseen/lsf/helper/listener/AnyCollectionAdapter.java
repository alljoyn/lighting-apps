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
package org.allseen.lsf.helper.listener;

import org.allseen.lsf.TrackingID;
import org.allseen.lsf.helper.facade.Group;
import org.allseen.lsf.helper.facade.Lamp;
import org.allseen.lsf.helper.facade.LightingItem;
import org.allseen.lsf.helper.facade.MasterScene;
import org.allseen.lsf.helper.facade.Preset;
import org.allseen.lsf.helper.facade.PulseEffect;
import org.allseen.lsf.helper.facade.Scene;
import org.allseen.lsf.helper.facade.SceneElement;
import org.allseen.lsf.helper.facade.TransitionEffect;

public class AnyCollectionAdapter extends AllCollectionAdapter {

    public void onAnyInitialized(TrackingID trackingId, LightingItem item)      { }
    public void onAnyChanged(LightingItem item)                                 { }
    public void onAnyRemoved(LightingItem item)                                 { }
    public void onAnyError(LightingItemErrorEvent error)                        { }

    @Override
    public void onLampInitialized(Lamp lamp) {
        onAnyInitialized(null, lamp);
    }

    @Override
    public void onLampChanged(Lamp lamp) {
        onAnyChanged(lamp);
    }

    @Override
    public void onLampRemoved(Lamp lamp) {
        onAnyRemoved(lamp);
    }

    @Override
    public void onLampError(LightingItemErrorEvent error) {
        onAnyError(error);
    }

    @Override
    public void onGroupInitialized(TrackingID trackingId, Group group) {
        onAnyInitialized(trackingId, group);
    }

    @Override
    public void onGroupChanged(Group group) {
        onAnyChanged(group);
    }

    @Override
    public void onGroupRemoved(Group group) {
        onAnyRemoved(group);
    }

    @Override
    public void onGroupError(LightingItemErrorEvent error) {
        onAnyError(error);
    }

    @Override
    public void onPresetInitialized(TrackingID trackingId, Preset preset) {
        onAnyInitialized(trackingId, preset);
    }

    @Override
    public void onPresetChanged(Preset preset) {
        onAnyChanged(preset);
    }

    @Override
    public void onPresetRemoved(Preset preset) {
        onAnyRemoved(preset);
    }

    @Override
    public void onPresetError(LightingItemErrorEvent error) {
        onAnyError(error);
    }

    @Override
    public void onTransitionEffectInitialized(TrackingID trackingId, TransitionEffect effect) {
        onAnyInitialized(trackingId, effect);
    }

    @Override
    public void onTransitionEffectChanged(TransitionEffect effect) {
        onAnyChanged(effect);
    }

    @Override
    public void onTransitionEffectRemoved(TransitionEffect effect) {
        onAnyRemoved(effect);
    }

    @Override
    public void onTransitionEffectError(LightingItemErrorEvent error) {
        onAnyError(error);
    }

    @Override
    public void onPulseEffectInitialized(TrackingID trackingId, PulseEffect effect) {
        onAnyInitialized(trackingId, effect);
    }

    @Override
    public void onPulseEffectChanged(PulseEffect effect) {
        onAnyChanged(effect);
    }

    @Override
    public void onPulseEffectRemoved(PulseEffect effect) {
        onAnyRemoved(effect);
    }

    @Override
    public void onPulseEffectError(LightingItemErrorEvent error) {
        onAnyError(error);
    }

    @Override
    public void onSceneElementInitialized(TrackingID trackingId, SceneElement element) {
        onAnyInitialized(trackingId, element);
    }

    @Override
    public void onSceneElementChanged(SceneElement element) {
        onAnyChanged(element);
    }

    @Override
    public void onSceneElementRemoved(SceneElement element) {
        onAnyRemoved(element);
    }

    @Override
    public void onSceneElementError(LightingItemErrorEvent error) {
        onAnyError(error);
    }

    @Override
    public void onSceneInitialized(TrackingID trackingId, Scene scene) {
        onAnyInitialized(trackingId, scene);
    }

    @Override
    public void onSceneChanged(Scene scene) {
        onAnyChanged(scene);
    }

    @Override
    public void onSceneRemoved(Scene scene) {
        onAnyRemoved(scene);
    }

    @Override
    public void onSceneError(LightingItemErrorEvent error) {
        onAnyError(error);
    }

    @Override
    public void onMasterSceneInitialized(TrackingID trackingId, MasterScene masterScene) {
        onAnyInitialized(trackingId, masterScene);
    }

    @Override
    public void onMasterSceneChanged(MasterScene masterScene) {
        onAnyChanged(masterScene);
    }

    @Override
    public void onMasterSceneRemoved(MasterScene masterScene) {
        onAnyRemoved(masterScene);
    }

    @Override
    public void onMasterSceneError(LightingItemErrorEvent error) {
        onAnyError(error);
    }
}
