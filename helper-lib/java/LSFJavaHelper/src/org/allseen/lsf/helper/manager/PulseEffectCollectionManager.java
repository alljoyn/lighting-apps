/*
 * Copyright AllSeen Alliance. All rights reserved.
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
package org.allseen.lsf.helper.manager;

import java.util.Collection;
import java.util.Iterator;

import org.allseen.lsf.TrackingID;
import org.allseen.lsf.helper.facade.PulseEffect;
import org.allseen.lsf.helper.listener.LightingItemErrorEvent;
import org.allseen.lsf.helper.listener.PulseEffectListener;
import org.allseen.lsf.helper.model.LightingItemFilter;
import org.allseen.lsf.helper.model.PulseEffectDataModelV2;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class PulseEffectCollectionManager extends LightingItemCollectionManager<PulseEffect, PulseEffectListener, PulseEffectDataModelV2> {

    public PulseEffectCollectionManager(LightingSystemManager director) {
        super(director);
    }

    public PulseEffect addPulseEffect(String pulseEffectId) {
        return addPulseEffect(pulseEffectId, new PulseEffect(pulseEffectId));
    }

    public PulseEffect addPulseEffect(String pulseEffectId, PulseEffect pulseEffect) {
        return itemAdapters.put(pulseEffectId, pulseEffect);
    }

    public PulseEffect getPulseEffect(String pulseEffectId) {
        return getAdapter(pulseEffectId);
    }

    public PulseEffect[] getPulseEffects() {
        return getAdapters().toArray(new PulseEffect[size()]);
    }

    public PulseEffect[] getPulseEffects(LightingItemFilter<PulseEffect> filter) {
        Collection<PulseEffect> filteredPulseEffects = getAdapters(filter);
        return filteredPulseEffects.toArray(new PulseEffect[filteredPulseEffects.size()]);
    }

    public Iterator<PulseEffect> getPulseEffectIterator() {
        return getAdapters().iterator();
    }

    public Collection<PulseEffect> removePulseEffect() {
        return removeAllAdapters();
    }

    public PulseEffect removePulseEffect(String pulseEffectId) {
        return removeAdapter(pulseEffectId);
    }

    @Override
    protected void sendInitializedEvent(PulseEffectListener listener, PulseEffect pulseEffect, TrackingID trackingID) {
        listener.onPulseEffectInitialized(trackingID, pulseEffect);
    }

    @Override
    protected void sendChangedEvent(PulseEffectListener listener, PulseEffect pulseEffect) {
        listener.onPulseEffectChanged(pulseEffect);
    }

    @Override
    protected void sendRemovedEvent(PulseEffectListener listener, PulseEffect pulseEffect) {
        listener.onPulseEffectRemoved(pulseEffect);
    }

    @Override
    protected void sendErrorEvent(PulseEffectListener listener, LightingItemErrorEvent errorEvent) {
        listener.onPulseEffectError(errorEvent);
    }

    @Override
    public PulseEffectDataModelV2 getModel(String pulseEffectID) {
        PulseEffect pulseEffect = getAdapter(pulseEffectID);

        return pulseEffect != null ? pulseEffect.getPulseEffectDataModel() : null;
    }
}
