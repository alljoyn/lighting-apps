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

import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.MasterScene;
import org.allseen.lsf.sdk.Scene;
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

        for (MasterScene masterScene : LightingDirector.get().getMasterScenes()) {
            addMasterScene(activity, masterScene);
        }

        for (Scene basicScene : LightingDirector.get().getScenes()) {
            addBasicScene(activity, basicScene);
        }

        return root;
    }

    @Override
    public void removeElement(String id) {
        super.removeElement(id);
        updateLoading();
    }

    public void addMasterScene(SampleAppActivity activity, MasterScene masterScene) {
        addItem(masterScene, Util.createSceneNamesString(activity, masterScene), R.drawable.master_scene_set_icon);
        updateLoading();
    }

    public void addBasicScene(SampleAppActivity activity, Scene basicScene) {
        addItem(basicScene, activity.basicSceneV1Module.createMemberNamesString(activity, basicScene, ", "), R.drawable.scene_set_icon);
        updateLoading();
    }

    @Override
    public void updateLoading() {
        super.updateLoading();

        LightingDirector director = LightingDirector.get();
        int sceneItemCount = director.getSceneCount() + director.getSceneElementCount();

        if (((SampleAppActivity) getActivity()).isControllerConnected() && sceneItemCount == 0) {
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
