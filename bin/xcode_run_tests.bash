#! /bin/bash

# reactive-firewall/XCMCopy Tool
# ..................................
# Copyright (c) 2017-2023, Mr. Walls
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
#

export LANG=en_US.${STRINGS_FILE_OUTPUT_ENCODING:-"UTF-8"}
# shellcheck disable=SC2155,SC2046
export __CF_USER_TEXT_ENCODING=$(printf "%s" $(echo "${__CF_USER_TEXT_ENCODING:-0x0}" | cut -d : -f 1)":0x08000100:0x0");
export PROJECT_DIR="${PROJECT_DIR:-${SRCROOT:-$(pwd)}}"
export SHELL=${SHELL:-$(xcrun --sdk macosx --find bash)} ;
export GIT_DIR=${PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null)} ;

#cd ${LOCSYMROOT:-${1:-./}} ;
cd "${GIT_DIR}" || exit 66 ;
if [[ ! ( -d "./.git" ) ]] ; then
	echo "${FUNCNAME:-$0}:${BASH_LINENO:-0}: ERROR: in path: Please run this tool from ${GIT_DIR}" ;
	exit 66 ;
fi ;
pwd
if [[ ( -f "./Makefile" ) ]] ; then
make -j1 clean ; wait ;
make test || echo "Makefile:test: ERROR: Testing ('make test') failed." >&2 ;
wait ; make -j1 clean ;
else
	exit 126 ;
fi ;
