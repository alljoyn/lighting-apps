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
package org.allseen.lsf.sdk;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.model.LightingItemDataModel;
import org.allseen.lsf.sdk.model.LightingItemUtil;
import org.allseen.lsf.sdk.model.SceneElementDataModel;
import org.allseen.lsf.sdk.model.SceneElementDataModelV2;

public class SceneElement extends SceneItem {
    public static void setDefaultName(String defaultName) {
        if (defaultName != null) {
            SceneElementDataModel.defaultName = defaultName;
        }
    }

    protected SceneElementDataModelV2 sceneElementModel;

    protected SceneElement(String sceneElementId) {
        this(sceneElementId, null);
    }

    protected SceneElement(String sceneElementId, String sceneElementName) {
        super();

        sceneElementModel = new SceneElementDataModelV2(sceneElementId, sceneElementName);
    }

    @Override
    public void apply() {
        String errorContext = "SceneElement.apply() error";

        postErrorIfFailure(errorContext,
            AllJoynManager.sceneElementManager.applySceneElement(sceneElementModel.id));
    }

    public void modify(Effect effect, GroupMember[] members) {
        String errorContext = "SceneElement.modify() error";

        if (postInvalidArgIfNull(errorContext, effect) && postInvalidArgIfNull(errorContext, members)) {
            postErrorIfFailure(errorContext,
                AllJoynManager.sceneElementManager.updateSceneElement(sceneElementModel.id, LightingItemUtil.createSceneElement(effect.getId(), GroupMember.createLampGroup(members))));
        }
    }

    public void add(GroupMember member) {
        String errorContext = "SceneElement.add() error";

        if (postInvalidArgIfNull(errorContext, member)) {
            Set<String> lamps = new HashSet<String>(sceneElementModel.getLamps());
            Set<String> groups = new HashSet<String>(sceneElementModel.getGroups());

            if (member instanceof Lamp) {
                lamps.add(member.getId());
            } else if (member instanceof Group) {
                groups.add(member.getId());
            }

            postErrorIfFailure(errorContext,
                    AllJoynManager.sceneElementManager.updateSceneElement(sceneElementModel.id, LightingItemUtil.createSceneElement(
                            sceneElementModel.getEffectId(), lamps.toArray(new String[lamps.size()]), groups.toArray(new String[groups.size()]))));

        }
    }

    public void remove(GroupMember member) {
        String errorContext = "SceneElement.remove() error";

        if (postInvalidArgIfNull(errorContext, member)) {
            Set<String> lamps = new HashSet<String>(sceneElementModel.getLamps());
            Set<String> groups = new HashSet<String>(sceneElementModel.getGroups());

            boolean didRemove = lamps.remove(member.getId()) || groups.remove(member.getId());

            if (didRemove) {
                postErrorIfFailure(errorContext,
                    AllJoynManager.sceneElementManager.updateSceneElement(sceneElementModel.id, LightingItemUtil.createSceneElement(
                            sceneElementModel.getEffectId(), lamps.toArray(new String[lamps.size()]), groups.toArray(new String[groups.size()]))));
            }
        }
    }

    @Override
    public void rename(String sceneElementName) {
        String errorContext = "SceneElement.rename() error";

        if (postInvalidArgIfNull(errorContext, sceneElementName)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.sceneElementManager.setSceneElementName(sceneElementModel.id, sceneElementName, LightingDirector.get().getDefaultLanguage()));
        }
    }

    @Override
    public void delete() {
        String errorContext = "SceneElement.delete() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.sceneElementManager.deleteSceneElement(sceneElementModel.id));
    }

    public Effect getEffect() {
        return LightingDirector.get().getEffect(sceneElementModel.getEffectId());
    }

    public Lamp[] getLamps() {
        return LightingDirector.get().getLamps(sceneElementModel.getLamps());
    }

    public Group[] getGroups() {
        return LightingDirector.get().getGroups(sceneElementModel.getGroups());
    }

    public String getEffectID() {
        return sceneElementModel.getEffectId();
    }

    public Collection<String> getLampIDs() {
        return sceneElementModel.getLamps();
    }

    public Collection<String> getGroupIDs() {
        return sceneElementModel.getGroups();
    }

    @Override
    public boolean hasComponent(LightingItem item) {
        String errorContext = "SceneElement.hasComponent() error";
        return postInvalidArgIfNull(errorContext, item) ? hasEffect(item.getId()) || hasLamp(item.getId()) || hasGroup(item.getId()) : false;
    }

    public boolean hasEffect(Effect effect) {
        String errorContext = "SceneElement.hasEffect() error";
        return postInvalidArgIfNull(errorContext, effect) ? hasEffect(effect.getId()) : false;
    }

    public boolean hasLamp(Lamp lamp) {
        String errorContext = "Group.hasLamp() error";
        return postInvalidArgIfNull(errorContext, lamp) ? hasLamp(lamp.getId()) : false;
    }

    public boolean hasGroup(Group group) {
        String errorContext = "SceneElement.hasGroup() error";
        return postInvalidArgIfNull(errorContext, group) ? hasGroup(group.getId()) : false;
    }

    protected boolean hasEffect(String effectID) {
        return sceneElementModel.containsEffect(effectID);
    }

    protected boolean hasLamp(String lampID) {
        return sceneElementModel.containsLamp(lampID);
    }

    protected boolean hasGroup(String groupID) {
        return sceneElementModel.containsGroup(groupID);
    }

    @Override
    protected Collection<LightingItem> getDependentCollection() {
        LightingDirector director = LightingDirector.get();
        Collection<LightingItem> dependents = new ArrayList<LightingItem>();

        dependents.addAll(director.getSceneCollectionManagerV2().getScenesCollection(new LightingItemHasComponentFilter<SceneV2>(SceneElement.this)));

        return dependents;
    }

    protected SceneElementDataModelV2 getSceneElementDataModel() {
        return sceneElementModel;
    }

    @Override
    protected LightingItemDataModel getItemDataModel() {
        return getSceneElementDataModel();
    }

    @Override
    protected void postError(final String name, final ResponseCode status) {
        LightingDirector.get().getLightingSystemManager().getQueue().post(new Runnable() {
            @Override
            public void run() {
                LightingDirector.get().getSceneElementCollectionManager().sendErrorEvent(name, status, getId());
            }
        });
    }
}
