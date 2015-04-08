/*
 * Copyright (c) 2014, AllSeen Alliance. All rights reserved.
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

import org.allseen.lsf.helper.facade.Group;
import org.allseen.lsf.helper.facade.Lamp;
import org.allseen.lsf.helper.facade.MasterScene;
import org.allseen.lsf.helper.facade.Preset;
import org.allseen.lsf.helper.facade.PulseEffect;
import org.allseen.lsf.helper.facade.Scene;
import org.allseen.lsf.helper.facade.SceneElement;
import org.allseen.lsf.helper.facade.TransitionEffect;
import org.allseen.lsf.helper.model.ControllerDataModel;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class AllCollectionAdapter implements AllCollectionListener {

    @Override
    public void onLampChanged(Lamp lamp)                                { }

    @Override
    public void onLampRemoved(Lamp lamp)                                { }

    @Override
    public void onLampError(LightingItemErrorEvent error)               { }

    @Override
    public void onGroupChanged(Group group)                             { }

    @Override
    public void onGroupRemoved(Group group)                             { }

    @Override
    public void onGroupError(LightingItemErrorEvent error)              { }

    @Override
    public void onPresetChanged(Preset preset)                          { }

    @Override
    public void onPresetRemoved(Preset preset)                          { }

    @Override
    public void onPresetError(LightingItemErrorEvent error)             { }

    @Override
    public void onTransitionEffectChanged(TransitionEffect effect)      { }

    @Override
    public void onTransitionEffectRemoved(TransitionEffect effect)      { }

    @Override
    public void onTransitionEffectError(LightingItemErrorEvent error)   { }

    @Override
    public void onPulseEffectChanged(PulseEffect effect)                { }

    @Override
    public void onPulseEffectRemoved(PulseEffect effect)                { }

    @Override
    public void onPulseEffectError(LightingItemErrorEvent error)        { }

    @Override
    public void onSceneElementChanged(SceneElement element)             { }

    @Override
    public void onSceneElementRemoved(SceneElement element)             { }

    @Override
    public void onSceneElementError(LightingItemErrorEvent error)       { }

    @Override
    public void onSceneChanged(Scene scene)                             { }

    @Override
    public void onSceneRemoved(Scene scene)                             { }

    @Override
    public void onSceneError(LightingItemErrorEvent error)              { }

    @Override
    public void onMasterSceneChanged(MasterScene masterScene)           { }

    @Override
    public void onMasterSceneRemoved(MasterScene masterScene)           { }

    @Override
    public void onMasterSceneError(LightingItemErrorEvent error)        { }

    @Override
    public void onLeaderModelChange(ControllerDataModel leadModel)      { }

    @Override
    public void onControllerErrors(ControllerErrorEvent errorEvent)     { }
}
