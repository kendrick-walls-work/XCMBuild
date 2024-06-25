#!/usr/bin/env make -f

# reactive-firewall/XCMB Extra Tools Makefile
# ..................................
# Copyright (c) 2007-2024, Mr. Walls
# ..................................
# Licensed under APACHE-2 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# ..........................................
# http://www.apache.org/licenses/LICENSE-2.0
# ..........................................
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifndef BUILD_ROOT

.PHONY: all test clean tools update_db

else

APTGET = apt-get -y --force-yes
BREW = brew


#reset time to October 13 2023 at 12:42:13 AM

RESET_TIME = $(TOUCH) -c -f -t 202310130042.13

.PHONY: all test clean tools update_db

tools: /usr/bin/unzip

server-tools: tools

/usr/bin/unzip: update_db
	$(QUIET)$(PKGMGR) install unzip ;
	$(QUIET)$(WAIT) ;

update_db::
	$(QUIET)$(APTGET) update ;
	$(QUIET)$(WAIT) ;

endif
