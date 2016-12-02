#    #    
#    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
#    Source Project Contributors and others.
#    
#    All rights reserved. This program and the accompanying materials are
#    made available under the terms of the Apache License, Version 2.0
#    which accompanies this distribution, and is available at
#    http://www.apache.org/licenses/LICENSE-2.0

#!/bin/bash

set -e
SERVICE_FRAMEWORK_HOME=$1

if [ -d $SERVICE_FRAMEWORK_HOME ]; then
	if [ -d "$SERVICE_FRAMEWORK_HOME/standard_core_library/" ]; then
		cd $SERVICE_FRAMEWORK_HOME/standard_core_library/
		mkdir -p lighting_controller_service/inc/lsf
		ln -s `pwd`/lighting_controller_service/inc lighting_controller_service/inc/lsf/controllerservice
	else
		echo "SERVICE_FRAMEWORK_HOME directory exists but doesn't point to service_framework repo root folder"
		exit 1
	fi
else
	echo "SERVICE_FRAMEWORK_HOME directory doesn't exists"
	exit 1
fi