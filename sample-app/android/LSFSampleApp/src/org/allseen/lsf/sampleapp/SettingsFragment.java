/*
 *  *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 */
package org.allseen.lsf.sampleapp;

import org.allseen.lsf.helper.model.ControllerDataModel;

import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.TextView;

public class SettingsFragment extends PageFrameChildFragment implements OnClickListener {
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_settings, container, false);

        view.findViewById(R.id.settingsRowController).setOnClickListener(this);
        view.findViewById(R.id.settingsRowSource).setOnClickListener(this);
        view.findViewById(R.id.settingsRowTeam).setOnClickListener(this);
        view.findViewById(R.id.settingsRowNotice).setOnClickListener(this);

        String version = this.getString(R.string.version) + " ";
        try {
            version += this.getActivity().getPackageManager().getPackageInfo(getActivity().getPackageName(), 0).versionName;
        } catch (NameNotFoundException e) {
            Log.e(SampleAppActivity.TAG, "Cannot retrieve package version!!!");
        }
        ((TextView) view.findViewById(R.id.settingsTextSampleApp)).setText(version);

        onUpdateView();

        return view;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);

        ((SampleAppActivity)getActivity()).updateActionBar(R.string.action_settings, false, false, false, false, false);
    }

    public void onUpdateView() {
        ControllerDataModel leaderControllerModel = ((SampleAppActivity)getActivity()).systemManager.getControllerManager().getLeadControllerModel();
        String leaderName = ControllerDataModel.defaultName;

        if (leaderControllerModel != null && leaderControllerModel.getName() != null && !leaderControllerModel.getName().isEmpty()) {
            leaderName = leaderControllerModel.getName();
        }

        ((TextView) view.findViewById(R.id.settingsTextController)).setText(leaderName);
    }

    @Override
    public void onClick(View clickedView) {
        int clickedID = clickedView.getId();

        if (clickedID == R.id.settingsRowController) {
            //TODO implement controller name change
        } else if (clickedID == R.id.settingsRowSource) {
            onSourceClick();
        } else if (clickedID == R.id.settingsRowTeam) {
            onTeamClick();
        } else if (clickedID == R.id.settingsRowNotice) {
            onNoticeClick();
        }
    }

    protected void onNoticeClick() {
        parent.showTextChildFragment(getResources().getString(R.string.notice_text));
    }

    protected void onSourceClick() {
        parent.showTextChildFragment(getResources().getString(R.string.source_code_text));
    }

    protected void  onTeamClick() {
        parent.showTextChildFragment(getResources().getString(R.string.team_text));
    }
}