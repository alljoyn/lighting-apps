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

import java.util.Iterator;

import org.allseen.lsf.helper.manager.AllJoynManager;
import org.allseen.lsf.helper.model.MasterSceneDataModel;
import org.allseen.lsf.helper.model.SceneDataModel;

import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.style.ImageSpan;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.TextView.BufferType;

public class ScenesTableFragment extends DetailedItemTableFragment {

    public ScenesTableFragment() {
        super();
        type = SampleAppActivity.Type.SCENE;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View root = super.onCreateView(inflater, container, savedInstanceState);
        SampleAppActivity activity = (SampleAppActivity) getActivity();

        Iterator<String> masterSceneIterator = activity.systemManager.getMasterSceneCollectionManager().getIDIterator();

        while (masterSceneIterator.hasNext()) {
            addElement(masterSceneIterator.next());
        }

        Iterator<String> sceneIterator = activity.systemManager.getSceneCollectionManagerV1().getIDIterator();

        while (sceneIterator.hasNext()) {
            addElement(sceneIterator.next());
        }

        return root;
    }

    @Override
    public void removeElement(String id) {
        super.removeElement(id);
        updateLoading();
    }

    @Override
    public void addElement(String id) {
        SampleAppActivity activity = (SampleAppActivity) getActivity();
        SceneDataModel basicSceneModel = activity.systemManager.getSceneCollectionManagerV1().getModel(id);
        MasterSceneDataModel masterSceneModel = activity.systemManager.getMasterSceneCollectionManager().getModel(id);

        if (basicSceneModel != null) {
            String details = Util.createMemberNamesString(activity, basicSceneModel, ", ");
            insertDetailedItemRow(getActivity(), basicSceneModel.id, basicSceneModel.tag, basicSceneModel.getName(), details, false);
            updateLoading();
        } else if (masterSceneModel != null) {
            String details = Util.createSceneNamesString(activity, masterSceneModel.masterScene);
            insertDetailedItemRow(getActivity(), masterSceneModel.id, masterSceneModel.tag, masterSceneModel.getName(), details, true);
            updateLoading();
        }
    }

    @Override
    public void updateLoading() {
        super.updateLoading();

        if (AllJoynManager.controllerConnected && ((SampleAppActivity) getActivity()).systemManager.getSceneCollectionManagerV1().size() == 0) {
            // connected but no scenes found; display create scenes screen, hide the scroll table
            layout.findViewById(R.id.scrollLoadingView).setVisibility(View.VISIBLE);
            layout.findViewById(R.id.scrollScrollView).setVisibility(View.GONE);

            View loadingView = layout.findViewById(R.id.scrollLoadingView);

            ((TextView) loadingView.findViewById(R.id.loadingText1)).setText(getActivity().getText(R.string.no_scenes));

            // creates text with the plus icon
            TextView loadingText2 = (TextView) loadingView.findViewById(R.id.loadingText2);
            String createScenesText = getActivity().getText(R.string.create_scenes).toString();
            SpannableStringBuilder ssb = new SpannableStringBuilder(createScenesText);

            // gets the plus icon, and finds where in the text it should go
            // the icon is scaled down slightly to look less "floaty" as it is bottom aligned to the text
            Drawable plusIcon = getResources().getDrawable(R.drawable.nav_add_icon_normal);
            plusIcon.setBounds(0, 0, (int) (plusIcon.getIntrinsicWidth() * 0.8), (int) (plusIcon.getIntrinsicHeight() * 0.8));

            int plusPosition = createScenesText.indexOf('+');
            ssb.setSpan(new ImageSpan(plusIcon, ImageSpan.ALIGN_BOTTOM), plusPosition, plusPosition + 1, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            loadingText2.setText(ssb, BufferType.SPANNABLE);

            loadingView.findViewById(R.id.loadingProgressBar).setVisibility(View.GONE);
        } else {
            View loadingView = layout.findViewById(R.id.scrollLoadingView);
            loadingView.findViewById(R.id.loadingProgressBar).setVisibility(View.VISIBLE);
        }
    }
}
