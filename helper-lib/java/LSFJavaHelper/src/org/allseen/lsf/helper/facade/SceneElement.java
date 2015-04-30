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

import org.allseen.lsf.helper.manager.AllJoynManager;
import org.allseen.lsf.helper.model.LightingItemDataModel;
import org.allseen.lsf.helper.model.LightingItemUtil;
import org.allseen.lsf.helper.model.SceneElementDataModel;

public class SceneElement extends LightingItem {

    private SceneElementDataModel sceneElementModel;

    public SceneElement(String sceneElementId) {
        this(sceneElementId, null);
    }

    public SceneElement(String sceneElementId, String sceneElementName) {
        super();

        sceneElementModel = new SceneElementDataModel(sceneElementId, sceneElementName);
    }

    public void apply() {
        AllJoynManager.sceneElementManager.applySceneElement(sceneElementModel.id);
    }

    public void modify(Effect effect, GroupMember[] members) {
        AllJoynManager.sceneElementManager.updateSceneElement(sceneElementModel.id, LightingItemUtil.createSceneElement(effect.getId(), members));
    }

    public void add(GroupMember member) {
        Set<String> lamps = new HashSet<String>(sceneElementModel.getLamps());
        Set<String> groups = new HashSet<String>(sceneElementModel.getGroups());

        if (member instanceof Lamp) {
            lamps.add(member.getId());
        } else if (member instanceof Group) {
            groups.add(member.getId());
        }

        AllJoynManager.sceneElementManager.updateSceneElement(sceneElementModel.id, LightingItemUtil.createSceneElement(
                sceneElementModel.getEffectId(), lamps.toArray(new String[lamps.size()]), groups.toArray(new String[groups.size()])));
    }

    public void remove(GroupMember member) {
        Set<String> lamps = new HashSet<String>(sceneElementModel.getLamps());
        Set<String> groups = new HashSet<String>(sceneElementModel.getGroups());

        boolean didRemove = lamps.remove(member.getId()) || groups.remove(member.getId());

        if (didRemove) {
            AllJoynManager.sceneElementManager.updateSceneElement(sceneElementModel.id, LightingItemUtil.createSceneElement(
                    sceneElementModel.getEffectId(), lamps.toArray(new String[lamps.size()]), groups.toArray(new String[groups.size()])));
        }
    }

    @Override
    public void rename(String sceneElementName) {
       AllJoynManager.sceneElementManager.setSceneElementName(sceneElementModel.id, sceneElementName, LightingDirector.get().getDefaultLanguage());
    }

    public void delete() {
       AllJoynManager.sceneElementManager.deleteSceneElement(sceneElementModel.id);
    }

    public SceneElementDataModel getSceneElementDataModel() {
        return sceneElementModel;
    }

    @Override
    protected LightingItemDataModel getItemDataModel() {
        return getSceneElementDataModel();
    }
}
