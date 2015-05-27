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
package org.allseen.lsf.helper.facade;

import java.util.HashSet;
import java.util.Set;

import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.helper.manager.AllJoynManager;
import org.allseen.lsf.helper.model.LightingItemDataModel;
import org.allseen.lsf.helper.model.LightingItemUtil;
import org.allseen.lsf.helper.model.SceneElementDataModelV2;

public class SceneElement extends LightingItem {

    private SceneElementDataModelV2 sceneElementModel;

    public SceneElement(String sceneElementId) {
        this(sceneElementId, null);
    }

    public SceneElement(String sceneElementId, String sceneElementName) {
        super();

        sceneElementModel = new SceneElementDataModelV2(sceneElementId, sceneElementName);
    }

    public void apply() {
        String errorContext = "SceneElement.apply() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.sceneElementManager.applySceneElement(sceneElementModel.id));
    }

    public void modify(Effect effect, GroupMember[] members) {
        String errorContext = "SceneElement.modify() error";

        if (postInvalidArgIfNull(errorContext, effect) && postInvalidArgIfNull(errorContext, members)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.sceneElementManager.updateSceneElement(sceneElementModel.id, LightingItemUtil.createSceneElement(effect.getId(), members)));
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

    public void delete() {
        String errorContext = "SceneElement.delete() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.sceneElementManager.deleteSceneElement(sceneElementModel.id));
    }

    public SceneElementDataModelV2 getSceneElementDataModel() {
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
