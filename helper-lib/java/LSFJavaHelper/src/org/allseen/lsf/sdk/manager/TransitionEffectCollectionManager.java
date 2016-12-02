/*
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 */
package org.allseen.lsf.sdk.manager;

import java.util.Collection;
import java.util.Iterator;

import org.allseen.lsf.sdk.TrackingID;
import org.allseen.lsf.sdk.factory.TransitionEffectFactory;
import org.allseen.lsf.sdk.listener.TransitionEffectCollectionListener;
import org.allseen.lsf.sdk.model.LightingItemFilter;
import org.allseen.lsf.sdk.model.TransitionEffectDataModelV2;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class TransitionEffectCollectionManager<TRANSITIONEFFECT, ERROR> extends LightingItemCollectionManager<TRANSITIONEFFECT, TransitionEffectCollectionListener<? super TRANSITIONEFFECT, ? super ERROR>, TransitionEffectDataModelV2, ERROR> {

    private final TransitionEffectFactory<TRANSITIONEFFECT, ERROR> factory;

    public TransitionEffectCollectionManager(LightingSystemManager<?, ?, ?, TRANSITIONEFFECT, ?, ?, ?, ?, ?, ?, ?> manager, TransitionEffectFactory<TRANSITIONEFFECT, ERROR> factory) {
        super(manager, factory);

        this.factory = factory;
    }

    public TRANSITIONEFFECT addTransitionEffect(String transitionEffectID) {
        return addTransitionEffect(transitionEffectID, factory.createTransitionEffect(transitionEffectID));
    }

    public TRANSITIONEFFECT addTransitionEffect(String transitionEffectID, TRANSITIONEFFECT transistionEffect) {
        return itemAdapters.put(transitionEffectID, transistionEffect);
    }

    public TRANSITIONEFFECT getTransistionEffect(String transitionEffectID) {
        return getAdapter(transitionEffectID);
    }

    public TRANSITIONEFFECT[] getTransitionEffects() {
        return getAdapters().toArray(factory.createTransitionEffects(size()));
    }

    public TRANSITIONEFFECT[] getTransitionEffects(LightingItemFilter<TRANSITIONEFFECT> filter) {
        Collection<TRANSITIONEFFECT> filteredTransitionEffect = getTransitionEffectsCollection(filter);
        return filteredTransitionEffect.toArray(factory.createTransitionEffects(filteredTransitionEffect.size()));
    }

    public Collection<TRANSITIONEFFECT> getTransitionEffectsCollection(LightingItemFilter<TRANSITIONEFFECT> filter) {
        return getAdapters(filter);
    }

    public Iterator<TRANSITIONEFFECT> getTransitionEffectIterator() {
        return getAdapters().iterator();
    }

    public Collection<TRANSITIONEFFECT> removeTransitionEffects() {
        return removeAllAdapters();
    }

    public TRANSITIONEFFECT removeTransitionEffect(String transitionEffectId) {
        return removeAdapter(transitionEffectId);
    }

    @Override
    protected void sendInitializedEvent(TransitionEffectCollectionListener<? super TRANSITIONEFFECT, ? super ERROR> listener, TRANSITIONEFFECT transitionEffect, TrackingID trackingID) {
        listener.onTransitionEffectInitialized(trackingID, transitionEffect);
    }

    @Override
    protected void sendChangedEvent(TransitionEffectCollectionListener<? super TRANSITIONEFFECT, ? super ERROR> listener, TRANSITIONEFFECT transitionEffect) {
        listener.onTransitionEffectChanged(transitionEffect);
    }

    @Override
    protected void sendRemovedEvent(TransitionEffectCollectionListener<? super TRANSITIONEFFECT, ? super ERROR> listener, TRANSITIONEFFECT transitionEffect) {
        listener.onTransitionEffectRemoved(transitionEffect);
    }

    @Override
    protected void sendErrorEvent(TransitionEffectCollectionListener<? super TRANSITIONEFFECT, ? super ERROR> listener, ERROR error) {
        listener.onTransitionEffectError(error);
    }

    @Override
    public TransitionEffectDataModelV2 getModel(String transitionEffectID) {
        return getModel(getAdapter(transitionEffectID));
    }

    @Override
    public TransitionEffectDataModelV2 getModel(TRANSITIONEFFECT transitionEffect) {
        return transitionEffect != null ? factory.findTransitionEffectDataModel(transitionEffect) : null;
    }
}