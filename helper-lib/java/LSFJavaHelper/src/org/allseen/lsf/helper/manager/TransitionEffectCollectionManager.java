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

import org.allseen.lsf.helper.facade.TransitionEffect;
import org.allseen.lsf.helper.listener.LightingItemErrorEvent;
import org.allseen.lsf.helper.listener.TransitionEffectListener;
import org.allseen.lsf.helper.model.TransitionEffectDataModel;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class TransitionEffectCollectionManager extends LightingItemCollectionManager<TransitionEffect, TransitionEffectListener, TransitionEffectDataModel> {

    public TransitionEffectCollectionManager(LightingSystemManager director) {
        super(director);
    }

    public TransitionEffect addTransitionEffect(String transitionEffectId) {
        return addTransitionEffect(transitionEffectId, new TransitionEffect(transitionEffectId));
    }

    public TransitionEffect addTransitionEffect(String transitionEffectId, TransitionEffect transistionEffect) {
        return itemAdapters.put(transitionEffectId, transistionEffect);
    }

    public TransitionEffect getTransistionEffect(String transitionEffectId) {
        return getAdapter(transitionEffectId);
    }

    public TransitionEffect[] getTransitionEffects() {
        return getAdapters().toArray(new TransitionEffect[size()]);
    }

    public Iterator<TransitionEffect> getTransitionEffectIterator() {
        return getAdapters().iterator();
    }

    public Collection<TransitionEffect> removeTransitionEffects() {
        return removeAllAdapters();
    }

    public TransitionEffect removeTransitionEffect(String transitionEffectId) {
        return removeAdapter(transitionEffectId);
    }

    @Override
    protected void sendChangedEvent(TransitionEffectListener listener, TransitionEffect transitionEffect) {
        listener.onTransitionEffectChanged(transitionEffect);
    }

    @Override
    protected void sendRemovedEvent(TransitionEffectListener listener, TransitionEffect transitionEffect) {
        listener.onTransitionEffectRemoved(transitionEffect);
    }

    @Override
    protected void sendErrorEvent(TransitionEffectListener listener, LightingItemErrorEvent errorEvent) {
        listener.onTransitionEffectError(errorEvent);
    }

    @Override
    public TransitionEffectDataModel getModel(String transitionEffectID) {
        TransitionEffect transitionEffect = getAdapter(transitionEffectID);

        return transitionEffect != null ? transitionEffect.getTransitionEffectDataModel() : null;
    }
}
