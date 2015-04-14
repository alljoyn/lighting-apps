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
import org.allseen.lsf.helper.model.LampCapabilities;
import org.allseen.lsf.helper.model.LampDataModel;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class LampsTableFragment extends DimmableItemTableFragment {

    public LampsTableFragment() {
        super();
        type = SampleAppActivity.Type.LAMP;
    }

    @Override
    protected int getInfoButtonImageID() {
        return R.drawable.light_status_icon;
    }

    @Override
    protected Fragment getInfoFragment() {
        return new LampInfoFragment();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View root = super.onCreateView(inflater, container, savedInstanceState);
        Iterator<String> i = ((SampleAppActivity) getActivity()).systemManager.getLampCollectionManager().getIDIterator();

        while(i.hasNext()) {
            addElement(i.next());
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
        LampDataModel lampModel = ((SampleAppActivity) getActivity()).systemManager.getLampCollectionManager().getModel(id);
        if (lampModel != null) {
            insertDimmableItemRow(
                getActivity(),
                lampModel.id,
                lampModel.tag,
                lampModel.state.getOnOff(),
                lampModel.uniformity.power,
                lampModel.getName(),
                lampModel.state.getBrightness(),
                true,
                ViewColor.calculate(lampModel.state, lampModel.getCapability(), lampModel.getDetails()),
                lampModel.getCapability().dimmable >= LampCapabilities.SOME);
            updateLoading();
        }
    }

    @Override
    public void updateLoading() {
        super.updateLoading();

        boolean hasLamps = ((SampleAppActivity) getActivity()).systemManager.getLampCollectionManager().size() > 0;

        if (AllJoynManager.controllerConnected && !hasLamps) {
            // connected but no lamps found; display loading lamps screen, hide the scroll table
            layout.findViewById(R.id.scrollLoadingView).setVisibility(View.VISIBLE);
            layout.findViewById(R.id.scrollScrollView).setVisibility(View.GONE);

            View loadingView = layout.findViewById(R.id.scrollLoadingView);

            ((TextView) loadingView.findViewById(R.id.loadingText1)).setText(getActivity().getText(R.string.no_lamps));
            ((TextView) loadingView.findViewById(R.id.loadingText2)).setText(getActivity().getText(R.string.loading_lamps));

        }
    }
}
