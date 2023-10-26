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
# Disclaimer of Warranties.
# A. YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT, TO THE EXTENT PERMITTED BY
#    APPLICABLE LAW, USE OF THIS SHELL SCRIPT AND ANY SERVICES PERFORMED
#    BY OR ACCESSED THROUGH THIS SHELL SCRIPT IS AT YOUR SOLE RISK AND
#    THAT THE ENTIRE RISK AS TO SATISFACTORY QUALITY, PERFORMANCE, ACCURACY AND
#    EFFORT IS WITH YOU.
#
# B. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THIS SHELL SCRIPT
#    AND SERVICES ARE PROVIDED "AS IS" AND "AS AVAILABLE", WITH ALL FAULTS AND
#    WITHOUT WARRANTY OF ANY KIND, AND THE AUTHOR OF THIS SHELL SCRIPT'S LICENSORS
#    (COLLECTIVELY REFERRED TO AS "THE AUTHOR" FOR THE PURPOSES OF THIS DISCLAIMER)
#    HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH RESPECT TO THIS SHELL SCRIPT
#    SOFTWARE AND SERVICES, EITHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
#    NOT LIMITED TO, THE IMPLIED WARRANTIES AND/OR CONDITIONS OF
#    MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE,
#    ACCURACY, QUIET ENJOYMENT, AND NON-INFRINGEMENT OF THIRD PARTY RIGHTS.
#
# C. THE AUTHOR DOES NOT WARRANT AGAINST INTERFERENCE WITH YOUR ENJOYMENT OF THE
#    THE AUTHOR's SOFTWARE AND SERVICES, THAT THE FUNCTIONS CONTAINED IN, OR
#    SERVICES PERFORMED OR PROVIDED BY, THIS SHELL SCRIPT WILL MEET YOUR
#    REQUIREMENTS, THAT THE OPERATION OF THIS SHELL SCRIPT OR SERVICES WILL
#    BE UNINTERRUPTED OR ERROR-FREE, THAT ANY SERVICES WILL CONTINUE TO BE MADE
#    AVAILABLE, THAT THIS SHELL SCRIPT OR SERVICES WILL BE COMPATIBLE OR
#    WORK WITH ANY THIRD PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES,
#    OR THAT DEFECTS IN THIS SHELL SCRIPT OR SERVICES WILL BE CORRECTED.
#    INSTALLATION OF THIS THE AUTHOR SOFTWARE MAY AFFECT THE USABILITY OF THIRD
#    PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES.
#
# D. YOU FURTHER ACKNOWLEDGE THAT THIS SHELL SCRIPT AND SERVICES ARE NOT
#    INTENDED OR SUITABLE FOR USE IN SITUATIONS OR ENVIRONMENTS WHERE THE FAILURE
#    OR TIME DELAYS OF, OR ERRORS OR INACCURACIES IN, THE CONTENT, DATA OR
#    INFORMATION PROVIDED BY THIS SHELL SCRIPT OR SERVICES COULD LEAD TO
#    DEATH, PERSONAL INJURY, OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE,
#    INCLUDING WITHOUT LIMITATION THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
#    NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, LIFE SUPPORT OR
#    WEAPONS SYSTEMS.
#
# E. NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY THE AUTHOR
#    SHALL CREATE A WARRANTY. SHOULD THIS SHELL SCRIPT OR SERVICES PROVE DEFECTIVE,
#    YOU ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
#
#    Limitation of Liability.
# F. TO THE EXTENT NOT PROHIBITED BY APPLICABLE LAW, IN NO EVENT SHALL THE AUTHOR
#    BE LIABLE FOR PERSONAL INJURY, OR ANY INCIDENTAL, SPECIAL, INDIRECT OR
#    CONSEQUENTIAL DAMAGES WHATSOEVER, INCLUDING, WITHOUT LIMITATION, DAMAGES
#    FOR LOSS OF PROFITS, CORRUPTION OR LOSS OF DATA, FAILURE TO TRANSMIT OR
#    RECEIVE ANY DATA OR INFORMATION, BUSINESS INTERRUPTION OR ANY OTHER
#    COMMERCIAL DAMAGES OR LOSSES, ARISING OUT OF OR RELATED TO YOUR USE OR
#    INABILITY TO USE THIS SHELL SCRIPT OR SERVICES OR ANY THIRD PARTY
#    SOFTWARE OR APPLICATIONS IN CONJUNCTION WITH THIS SHELL SCRIPT OR
#    SERVICES, HOWEVER CAUSED, REGARDLESS OF THE THEORY OF LIABILITY (CONTRACT,
#    TORT OR OTHERWISE) AND EVEN IF THE AUTHOR HAS BEEN ADVISED OF THE
#    POSSIBILITY OF SUCH DAMAGES. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION
#    OR LIMITATION OF LIABILITY FOR PERSONAL INJURY, OR OF INCIDENTAL OR
#    CONSEQUENTIAL DAMAGES, SO THIS LIMITATION MAY NOT APPLY TO YOU. In no event
#    shall THE AUTHOR's total liability to you for all damages (other than as may
#    be required by applicable law in cases involving personal injury) exceed
#    the amount of five dollars ($5.00). The foregoing limitations will apply
#    even if the above stated remedy fails of its essential purpose.
################################################################################
PATH=${PATH:-"/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"} ;

# TODO:
# use FUSE_BUILD_SCRIPT_PHASES
# use BUILD_COMPONENTS
# use BUILD_VARIANTS
# use BUILT_PRODUCTS_DIR for destination and handle symlinks
# use DEPLOYMENT_LOCATION too
# use DEPLOYMENT_POSTPROCESSING to choose cp vs install
# use DERIVED_FILE_DIR for some temp buffer files
# check PROJECT_TEMP_DIR for temp buffers cache
# use DSTROOT as root
# use ENABLE_TESTABILITY
# use VALIDATE_PRODUCT
# use ENABLE_APP_SANDBOX and ENABLE_USER_SCRIPT_SANDBOXING for venv
# use RUN_CLANG_STATIC_ANALYZER for build phase
# use RUN_DOCUMENTATION_COMPILER to build docs for build phase
# use SCAN_ALL_SOURCE_FILES_FOR_INCLUDES to find python imports and bash commands
# use SCRIPTS_FOLDER_PATH for PATH to scripts
# check SDKROOT and first ADDITIONAL_SDKS before the rest of the shell ENV
# check SHARED_FRAMEWORKS_FOLDER_PATH for python.famework before SYSTEM_FRAMEWORK_SEARCH_PATHS
# check CLANG_ANALYZER_DEADCODE_DEADSTORES and find set only issue
# check CLANG_ANALYZER_MEMORY_MANAGEMENT for declare/export in bash without unset attempts
# check also CLANG_ANALYZER_OBJC_UNUSED_IVARS for if-statement vars
# check CLANG_ANALYZER_SECURITY_INSECUREAPI_MKSTEMP for temp paths
# use CLANG_ENABLE_CODE_COVERAGE
# idea: can python handle CLANG_MIGRATOR_ANNOTATIONS?
# use CLANG_STATIC_ANALYZER_MODE and CLANG_STATIC_ANALYZER_MODE_ON_ANALYZE_ACTION
# use CLANG_WARN_COMPLETION_HANDLER_MISUSE to check for variables of _ used in loops and used then unset
# use CLANG_WARN_DOCUMENTATION_COMMENTS to find and warn about fixme like comments
# use CLANG_WARN_IMPLICIT_FALLTHROUGH to check case with no *) case
# use CLANG_WARN_UNREACHABLE_CODE to check for code after an "exit" in same scope
# use COMPILER_INDEX_STORE_ENABLE
# use CONFIGURATION
# use CONFIGURATION_BUILD_DIR ?
# use CONFIGURATION_TEMP_DIR
# use COPYING_PRESERVES_HFS_DATA
# use COPY_PHASE_STRIP to remove comments from copy

# use CURRENT_PROJECT_VERSION after checking VERSIONING_SYSTEM
# use CURRENT_VARIANT
# use DEAD_CODE_STRIPPING and check RETAIN_RAW_BINARIES
# use STRIP_INSTALLED_PRODUCT for install
# use EXCLUDED_RECURSIVE_SEARCH_PATH_SUBDIRECTORIES and EXCLUDED_SOURCE_FILE_NAMES
# check EXECUTABLES_FOLDER_PATH
# use INSTALL_DIR unless SKIP_INSTALL to install

# use STRIP_STYLE
# use VERBOSE_PBXCP

# use SYMBOL_GRAPH_EXTRACTOR_MODULE_NAME

# use TARGET_BUILD_DIR for ONLY build phase in place of BUILT_PRODUCTS_DIR
# use TARGET_TEMP_DIR for TEMP created and removed

# use SRCROOT
# use IS_MACCATALYST
# use OBJROOT for staging


# use COPYING_PRESERVES_HFS_DATA for .DS_Store
# use REMOVE_GIT_FROM_RESOURCES
# use REMOVE_HG_FROM_RESOURCES
# use REMOVE_CVS_FROM_RESOURCES
# use REMOVE_SVN_FROM_RESOURCES

# use SUPPORTS_TEXT_BASED_API ? and TAPI_VERIFY_MODE

# use REZ_COLLECTOR_DIR and REZ_OBJECTS_DIR with Rez?

# see SCRIPTS_FOLDER_PATH

test -x "$(command -v rm)" || exit 126 ;
test -x "$(command -v find)" || exit 126 ;
test -x "$(command -v tar)" || exit 126 ;
test -x "$(command -v dirname)" || exit 126 ;
test -x "$(command -v xargs)" || exit 126 ;
test -x "$(command -v cut)" || exit 126 ;
test -x "$(command -v xcrun)" || exit 126 ;
test -x "$(command -v ditto)" || exit 126 ;
test -x "$(command -v xxd)" || exit 126 ;
test -x "$(command -v xattr)" || exit 126 ;

export LANG=en_US.${STRINGS_FILE_OUTPUT_ENCODING:-"UTF-8"} ;
# shellcheck disable=SC2155,SC2046
export __CF_USER_TEXT_ENCODING=$( printf "%s" $( printf "%s\n" "${__CF_USER_TEXT_ENCODING:-0x0}" | cut -d : -f 1 ):0x08000100:0x0 )
# shellcheck disable=SC2086
export SHELL="${SHELL:-$(xcrun --sdk ${SDKROOT:-macosx} --find bash)}" ;
export RECURSION_COPY_CMD="${RECURSION_COPY_CMD:-${0}}" ;
# shellcheck disable=SC2086
export SCRIPTS_FOLDER_PATH="${SCRIPTS_FOLDER_PATH:-$(dirname ${0})}" ;
# shellcheck disable=SC2086
export MKDIR="${MKDIR:-$(xcrun --sdk ${SDKROOT:-macosx} --find mkdir)}" ;
# shellcheck disable=SC2086
export DITTO="${DITTO:-$(xcrun --sdk ${SDKROOT:-macosx} --find ditto)}" ;
#EXIT_CODE=0

# shellcheck disable=SC2086
test -x "${SCRIPTS_FOLDER_PATH}/serialized" || exit 126 ;
# shellcheck disable=SC2086,SC1091
source "${SCRIPTS_FOLDER_PATH}/serialized" || exit 40 ;

function fn_echo_if_verbose() {
	if [[ ${VERBOSE_PBXCP} == *NO ]] ; then
		: ;
	else
		local _TMP_MSG="${1}";
		{ printf "%s" "${_TMP_MSG}" ;} && : ;
		unset _TMP_MSG 2>/dev/null || : ;
	fi ;
}

function fn_echo_NewLine_if_verbose() {
	if [[ ${VERBOSE_PBXCP} == *NO ]] ; then
		: ;
	else
		{ printf "\n";} && : ;
	fi ;
}

export -f fn_echo_if_verbose ;
export -f fn_echo_NewLine_if_verbose ;

if [[ ${FUSE_BUILD_SCRIPT_PHASES} == *YES ]] ; then
	# TODO: add diognostic message here
	if [[ ( -n ${ACTION} ) ]] ; then
		: ;
	elif [[ ${ACTION} == *lean ]] ; then
		fn_echo_if_verbose "${FUNCNAME:-$0}:${BASH_LINENO:-0}: warning: Nothing to clean!" ; fn_echo_NewLine_if_verbose ;
		exit 0 ;
	else
		printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: warning: failed to validate a build environment. ( Unsupported structure )" >&2 ;
		exit 40 ;
	fi ;
fi ;

if [[ ${VERBOSE_PBXCP} == *NO ]] ; then
	: ;
else
	export VERBOSE_PBXCP='YES';
	if [[ ( ${SHLVL:-1} -lt 2 ) ]] ; then printf "%s: note: Verbose copy mode.\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}" ; fi ;
fi ;

function fn_echo_to() {
	#local arrow_right_hex="0xe287a2" ;
	local arrow_right_hex="0xe29e9c" ;
	{ fn_echo_if_verbose "$arrow_right_hex" | xxd -rp 2>/dev/null ;} && : ;
}

export -f fn_echo_to ;

function fn_echo_copy_did() {
	local MSG_SRC="${1}";
	local MSG_DST="${2}";
	{ fn_echo_if_verbose "${MSG_SRC} " && \
	fn_echo_to && \
	fn_echo_if_verbose " ${MSG_DST}" && \
	fn_echo_NewLine_if_verbose ;} && : ;
	unset MSG_SRC 2>/dev/null || : ;
	unset MSG_DST 2>/dev/null || : ;
}

function fn_placeholder_ensureDir() {
	local CP_X_DIR_PATH=${1};
	# shellcheck disable=SC2046
	{ { test -n "${CP_X_DIR_PATH:-}" || false; } && \
	{ test -d "${CP_X_DIR_PATH:-}" || test -h "${CP_X_DIR_PATH:-}" || \
	test -L "${CP_X_DIR_PATH:-}" ;} ;} || \
	{ test -x "${MKDIR}" && ( fn_placeholder_ensureDir $(dirname "${CP_X_DIR_PATH:-}") && \
	("${MKDIR}" -m 775 "${CP_X_DIR_PATH:-}" 2>/dev/null && \
	xattr -w com.apple.xcode.CreatedByBuildSystem true "${CP_X_DIR_PATH:-}" )) && \
	test -d "${CP_X_DIR_PATH:-}" ;} || false ;
	return $?
}

export -f fn_placeholder_ensureDir ;

#function fn_taint_in_for_copy() {
#	local CP_TEMP_PATH_STUB="${1: -128}${2::128}" ;
#	local CP_TEMP_PATH_SUBI="${CP_TEMP_PATH_STUB///}" ;
#	local PACE__="[^[:alnum:]]" ;
#	local CP_TEMP_PATH_SUBO="${CP_TEMP_PATH_SUBI//$PACE__}" ;
#	unset PACE__ 2>/dev/null || : ;
#	unset CP_TEMP_PATH_SUBI 2>/dev/null || : ;
#	unset CP_TEMP_PATH_STUB 2>/dev/null || : ;
#	printf "%s" "${CP_TEMP_PATH_SUBO}" ;
#	unset CP_TEMP_PATH_SUBO 2>/dev/null || : ;
#}
#
#export -f fn_taint_in_for_copy ;
export -f fn_echo_copy_did ;


function fn_copy_file_via_tar() {
	local CP_TFILE_SOURCE_PATH="${1}" ;
	if [[ ( -f "${CP_TFILE_SOURCE_PATH}" ) ]] ; then
		local CP_TFILE_DEST_PATH="${2}" ;
		# shellcheck disable=SC2155,SC2046
		# local CP_TEMP_PATH="${PROJECT_TEMP_DIR:-${CONFIGURATION_TEMP_DIR:-/tmp/}}"$(fn_taint_in_for_copy "${1}" "${2}" ) ;
		if [[ ! ( -d "${CP_TFILE_DEST_PATH}" ) ]] ; then
			# shellcheck disable=SC2046
			tar -xf <(tar -cf - -C $(dirname "${CP_TFILE_SOURCE_PATH}") --xattrs --mac-metadata $(basename "${CP_TFILE_SOURCE_PATH}") 2>/dev/null) -C $(dirname "${CP_TFILE_DEST_PATH}") --safe-writes --xattrs --mac-metadata $(basename "${CP_TFILE_SOURCE_PATH}") && :
		else
			tar -xf <(tar -cf - -C $(dirname "${CP_TFILE_SOURCE_PATH}") --xattrs --mac-metadata $(basename "${CP_TFILE_SOURCE_PATH}") 2>/dev/null) -C "${CP_TFILE_DEST_PATH}" --safe-writes --xattrs --mac-metadata $(basename "${CP_TFILE_SOURCE_PATH}") && :
		fi ;
		if [[ ${COMPILER_INDEX_STORE_ENABLE:-NO} != *NO ]] ; then wait ; fi ;
		# rm -f "${CP_TEMP_PATH}" 2>/dev/null || : ;
		fn_echo_copy_did "${CP_TFILE_SOURCE_PATH}" "${CP_TFILE_DEST_PATH}" ;
		unset CP_TFILE_DEST_PATH 2>/dev/null || : ;
		# unset CP_TEMP_PATH  2>/dev/null || : ;
	fi ;
	unset CP_TFILE_SOURCE_PATH 2>/dev/null || : ;
}

function fn_copy_file_via_ditto() {
	local CP_FILE_SOURCE_PATH="${1}" ;
	if [[ ( -f "${CP_FILE_SOURCE_PATH}" ) ]] ; then
		local CP_FILE_DEST_PATH="${2}" ;
		if [[ ! ( -d "${CP_FILE_DEST_PATH}" ) ]] ; then
			# shellcheck disable=SC2046
			ditto --nocache --extattr --acl --rsrc "${CP_FILE_SOURCE_PATH}" "${CP_FILE_DEST_PATH}" && :
		else
			# shellcheck disable=SC2046
			ditto --nocache --extattr --acl --rsrc "${CP_FILE_SOURCE_PATH}" "${CP_FILE_DEST_PATH%%/}/"$(basename "${CP_FILE_SOURCE_PATH}") && :
		fi ;
		if [[ ${COMPILER_INDEX_STORE_ENABLE:-NO} != *NO ]] ; then wait ; fi ;
		fn_echo_copy_did "${CP_FILE_SOURCE_PATH}" "${CP_FILE_DEST_PATH}" ;
		unset CP_FILE_DEST_PATH 2>/dev/null || : ;
	fi ;
	unset CP_FILE_SOURCE_PATH 2>/dev/null || : ;
}

function fn_copy_folder_via_tar() {
	local CP_FOLDER_SOURCE_PATH="${1}" ;
	if [[ ( -f "${CP_FOLDER_SOURCE_PATH}" ) ]] ; then
		local CP_FOLDER_DEST_PATH="${2}" ;
		# shellcheck disable=SC2155
		local CP_WRK_DIR_IN=$( dirname "${CP_FOLDER_SOURCE_PATH}" ) ;
		# shellcheck disable=SC2155
		local CP_WRK_DIR_OUT=$( dirname "${CP_FOLDER_DEST_PATH}" ) ;
		# shellcheck disable=SC2155
		local CP_FOLDER_SOURCE_NAME=$(basename "${CP_FOLDER_SOURCE_PATH}") ;
		tar -xf <(tar -cf - -C "${CP_WRK_DIR_IN}" --xattrs --mac-metadata "${CP_FOLDER_SOURCE_NAME}" 2>/dev/null) -C "${CP_WRK_DIR_OUT}" --safe-writes --xattrs --mac-metadata "${CP_FOLDER_SOURCE_NAME}" && :
		if [[ ${COMPILER_INDEX_STORE_ENABLE:-NO} != *NO ]] ; then wait ; fi ;
		fn_echo_copy_did "${CP_FOLDER_SOURCE_PATH}" "${CP_FOLDER_DEST_PATH}" ;
		unset CP_FOLDER_DEST_PATH 2>/dev/null || : ;
		unset CP_WRK_DIR_IN 2>/dev/null || : ;
		unset CP_WRK_DIR_OUT 2>/dev/null || : ;
		unset CP_FOLDER_SOURCE_NAME 2>/dev/null || : ;
	fi ;
	unset CP_FOLDER_SOURCE_PATH 2>/dev/null || : ;
}

function fn_copy_folder_via_ditto() {
	local CP_DIR_SOURCE_PATH="${1}" ;
	if [[ ( -d "${CP_DIR_SOURCE_PATH}" ) ]] ; then
		local CP_DIR_DEST_PATH="${2}" ;
		# shellcheck disable=SC2046
		ditto --nocache --extattr --acl --rsrc "${CP_DIR_SOURCE_PATH}" "${CP_DIR_DEST_PATH}" && : ;
		if [[ ${COMPILER_INDEX_STORE_ENABLE:-NO} != *NO ]] ; then wait ; fi ;
		fn_echo_copy_did "${CP_DIR_SOURCE_PATH}" "${CP_DIR_DEST_PATH}" ;
		unset CP_DIR_DEST_PATH 2>/dev/null || : ;
	fi ;
	unset CP_DIR_SOURCE_PATH 2>/dev/null || : ;
}

export -f fn_copy_file_via_tar ;
export -f fn_copy_file_via_ditto ;

function copy_no_strip_file_src() {
	# TODO: test with all types of // doubling
	local CP_PROXY_SOURCE_PATH="${1}" ;
	if [[ ( -f "${CP_PROXY_SOURCE_PATH}" ) ]] ; then
		local CP_PROXY_DEST_PATH="${2}" ;
		if [[ ( -x "$(command -v ditto)" ) ]] ; then
			fn_copy_file_via_ditto "${CP_PROXY_SOURCE_PATH}" "${CP_PROXY_DEST_PATH}" ;
		else
			if [[ ( ${SHLVL:-1} -lt 2 ) ]] ; then printf "%s: note: Missing ditto builtin, will try tar instead.\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}" ; fi ;
			fn_copy_file_via_tar "${CP_PROXY_SOURCE_PATH}" "${CP_PROXY_DEST_PATH}" ;
		fi ;
		unset CP_PROXY_DEST_PATH 2>/dev/null || : ;
	fi ;
	unset CP_PROXY_SOURCE_PATH 2>/dev/null || : ;
}

function copy_no_strip_dir_src() {
	# TODO: test with all types of // doubling
	local CP_PROXY_SOURCE_DIR_PATH="${1}" ;
	if [[ ( -d "${CP_PROXY_SOURCE_DIR_PATH}" ) ]] ; then
		local CP_PROXY_DEST_DIR_PATH="${2}" ;
		if [[ ( -x "$(command -v ditto)" ) ]] ; then
			fn_copy_folder_via_ditto "${CP_PROXY_SOURCE_DIR_PATH}" "${CP_PROXY_DEST_DIR_PATH}" ;
		else
			if [[ ( ${SHLVL:-1} -lt 2 ) ]] ; then printf "%s: note: Missing ditto builtin, will try tar instead.\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}" ; fi ;
			fn_copy_folder_via_tar "${CP_PROXY_SOURCE_DIR_PATH}" "${CP_PROXY_DEST_DIR_PATH}" ;
		fi ;
		unset CP_PROXY_DEST_DIR_PATH 2>/dev/null || : ;
	fi ;
	unset CP_PROXY_SOURCE_DIR_PATH 2>/dev/null || : ;
}

# if [[ $COPY_PHASE_STRIP == *YES ]] ; then copy_and_strip_file_src ; else copy_no_strip_file_src ; fi

# logic:
# for all src paths in source (directory) check if directory name is in dest
# BRANCH: fn_placeholder_ensureDir
# if not in dest, lock and mkdir, if still not there, else noop, and then, always unlock
# if/once is in dest lock and recursively call self with curr_src_path dest+dirname

export -f copy_no_strip_file_src ;
export -f copy_no_strip_dir_src ;

function fast_copy_file() {
	local LOC_CP_SRC="${1}";
	local LOC_CP_DST="${2}";
	# shellcheck disable=SC2155
	local LOC_CP=$(xcrun --sdk "${SDKROOT:-macosx}" --find cp) ;
	"${LOC_CP} -f ${LOC_CP_SRC} ${LOC_CP_DST}" >/dev/null ;
	unset LOC_CP 2>/dev/null || : ;
	fn_echo_copy_did "${CP_DIR_SOURCE_PATH}" "${CP_DIR_DEST_PATH}" ;
	unset CP_DIR_SOURCE_PATH 2>/dev/null || : ;
	unset CP_DIR_DEST_PATH 2>/dev/null || : ;
}

function fast_copy_dir() {
	if [[ ( ${#} -ge 2 ) ]] ; then
		local _TMP_DST="${2}"
		fn_placeholder_ensureDir "${_TMP_DST}" ;
		unset _TMP_DST 2>/dev/null || : ;
	fi ;
}

export -f fast_copy_file ;
export -f fast_copy_dir ;

function copy_dir() {
	local CP_SRCDIR_PATH="${1}" ;
	local CP_DSTDIR_PATH="${2}" ;
	if [[ ${COPY_PHASE_STRIP:-NO} != *YES ]] ; then
		copy_no_strip_dir_src "${CP_SRCDIR_PATH}" "${CP_DSTDIR_PATH}" ;
	else
		fast_copy_dir "${CP_SRCDIR_PATH}" "${CP_DSTDIR_PATH}" ;
	fi;
	unset CP_SRCDIR_PATH 2>/dev/null || : ;
	unset CP_DSTDIR_PATH 2>/dev/null || : ;
}

export -f copy_dir ;

function copy() {
	local CP_SOURCE_PATH="${1}" ;
	local CP_DEST_PATH="${2}" ;
	if [[ ( -e ${CP_SOURCE_PATH} ) ]] ; then
		wait ;
		if [[ ( -f ${CP_SOURCE_PATH} ) ]] || [[ ( -d ${CP_SOURCE_PATH} ) ]] ; then
			if [[ ( -d ${CP_SOURCE_PATH}) ]] ; then
				copy_dir "${CP_SOURCE_PATH}" "${CP_DEST_PATH}" ;
				# shellcheck disable=SC2038
				find "${CP_SOURCE_PATH}" -depth 1 -type d -exec basename '{}' ';' 2>/dev/null | xargs -L1 -I{} "${RECURSION_COPY_CMD}" "${CP_SOURCE_PATH%%/}"/"{}" "${CP_DEST_PATH%%'{}'}/{}" ;
				# shellcheck disable=SC2038
				{ find "${CP_SOURCE_PATH}" -depth 1 -type f -exec basename '{}' ';' 2>/dev/null | xargs -L1 -I{} "${RECURSION_COPY_CMD}" "${CP_SOURCE_PATH%%/}"/"{}" "${CP_DEST_PATH%%/}/{}" 2>/dev/null && : ;} & \
				( fn_echo_copy_did "${CP_SOURCE_PATH}" "${CP_DEST_PATH}" ) && : ;
			else
			# TODO: exclude bad files
				if [[ ${COPY_PHASE_STRIP:-NO} != *YES ]] ; then
					copy_no_strip_file_src "${CP_SOURCE_PATH}" "${CP_DEST_PATH}" ;
				else
					fast_copy_file "${CP_SOURCE_PATH}" "${CP_DEST_PATH}" ;
				fi;
				##echo "${FUNCNAME:-$0}:${BASH_LINENO:-0}: MODE NOT IMPLEMENTED YET" >&2 ;
			fi ;
		else
			# TODO: resolve link across base paths
			# shellcheck disable=SC2155,SC2046
			printf "${RED}Link${NC} %s " "${CP_SOURCE_PATH}" && \
			fn_echo_to && \
			printf " %s" "${CP_DEST_PATH}" && \
			printf " ( %s )\n" $(readlink "${CP_SOURCE_PATH}") && : ;
		fi ;
	else
		( fn_echo_if_verbose "${CP_SOURCE_PATH} is Missing!" && \
		fn_echo_NewLine_if_verbose ) >&2 ; wait ;
	fi ;
	unset CP_SOURCE_PATH 2>/dev/null || : ;
	unset CP_DEST_PATH 2>/dev/null || : ;
	true ;
}


#if if [[ ${COPY_PHASE_STRIP} == *NO ]] ; then
#	: ;
#else
#	copypng
#fi ;
#for INDEX in 0..${SCRIPT_INPUT_FILE_COUNT} ; do echo "\$SCRIPT_INPUT_FILE_${INDEX}" ; done
#for FILE_ITEM in $(for INDEX in $(seq 0 ${SCRIPT_INPUT_FILE_COUNT}) ; do printf "\$SCRIPT_INPUT_FILE_${INDEX}" ; done ); do
#	eval echo "file_item = ${FILE_ITEM}" ;
#done

export -f copy ;

if [[ $0 == *clonefile.bash ]] ; then
	#shellcheck disable=SC2078
	if [[ safetyCheckSerialized ]] ; then
		if [[ ( ${#} -lt 2 ) ]] ; then
			if [[ ( ${#} -ge 1 ) ]] && [[ ( -e "${1}" ) ]] && [[ ( "${1}" -ef "${SCRIPT_INPUT_FILE_0}" ) ]] ; then
				if [[ -n "${SCRIPT_OUTPUT_FILE_0}" ]] ; then
					exec "${RECURSION_COPY_CMD} ${SCRIPT_INPUT_FILE_0} ${SCRIPT_OUTPUT_FILE_0}" ;
				fi ;
				if [[ ${VERBOSE_PBXCP} == *YES ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Invalid internal State! (Unexpected)" >&2 ; exit 41; fi ;
			elif [[ ( ${#} -ge 1 ) ]] && [[ ! ( -e "${1}" ) ]] && [[ ( -e "${SCRIPT_INPUT_FILE_0}" ) ]] ; then
				if [[ -z ${SCRIPT_OUTPUT_FILE_0} ]] ; then
					export -x SCRIPT_OUTPUT_FILE_0="${1}";
					export SCRIPT_OUTPUT_FILE_COUNT=1 ;
					exec "${RECURSION_COPY_CMD} ${SCRIPT_INPUT_FILE_0} ${1}" ;
				fi ;
				if [[ ${VERBOSE_PBXCP} == *YES ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Invalid internal State! (Unexpected)" >&2 ; exit 45; fi ;
			elif [[ ( ${#} -lt 1 ) ]] && [[ ( -e "${SCRIPT_INPUT_FILE_0}" ) ]] ; then
				if [[ -n "${SCRIPT_OUTPUT_FILE_0}" ]] ; then
					exec "${RECURSION_COPY_CMD} ${SCRIPT_INPUT_FILE_0} ${SCRIPT_OUTPUT_FILE_0}" ;
				fi ;
				if [[ ${VERBOSE_PBXCP} == *YES ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Invalid internal State! (Unexpected)" >&2 ; exit 44; fi ;
			#elif [[ ( ${#} -ge 1 ) ]] && [[ !( -e "${1}" ) ]] ; then also [[ !( -e "${SCRIPT_INPUT_FILE_0}" ) ]] therefore fallthrough (is missing src OR is missing Dest OR is missing both)
			elif [[ ( ${#} -lt 1 ) ]] ; then
				# reduces to
				if [[ ${VERBOSE_PBXCP} == *YES ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Invalid internal State! (Ambiguous)" >&2 ; exit 43; fi ;
			fi;
			if [[ ${VERBOSE_PBXCP} == *YES ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Invalid internal State! (BUG)" >&2 ; exit 43; fi ;
		elif [[ ( ${#} -gt 2 ) ]] ; then
			fn_echo_if_verbose "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Not implemented yet" ;
			fn_echo_NewLine_if_verbose ;
			# need to filter args and then just exec "${0} ${SCRIPT_INPUT_FILE_0} ${SCRIPT_OUTPUT_FILE_0}" ;
			exit 2 ;
		fi ;
		# Else SHOULD be all good if NOT sandboxed
	fi ;
	{ copy "${@}" && true ;} || false ;
	if [[ ${COMPILER_INDEX_STORE_ENABLE:-NO} != *NO ]] ; then
		wait ; sync ;
	fi ;
fi ;

unset RECURSION_COPY_CMD 2>/dev/null || : ;

exit 0 ;

##################

#printf "\n${ACTION} target ${TARGET_NAME:-unknown} of project ${PROJECT_NAME:-unknown} with configuration ${CONFIGURATION:-default}\n" || EXIT_CODE=1
#printf "\nExternalBuildToolExecution ${TASK} (in target '${TARGET_NAME:-unknown}' from project '${PROJECT_NAME:-unknown}')\n"
#echo "Start ${TASK}"
#
#if [[ ( $(echo "${TASK}" | ${GREP} -Fic "copy" ) -gt 0 ) ]] && [[ ( $(echo "${ACTION}" | ${GREP} -Fic "clean" ) -lt 1 ) ]] ; then
#	echo "Start XCMBCopy" || EXIT_CODE=1
#	if [[ ( -d ${REF_PWD} ) ]] && [[ ( -d ${TARGET_BUILD_DIR:-/tmp} ) ]] ; then
#		echo "Make copy for ${TASK}" || EXIT_CODE=4 ;
#	else
#		echo "CreateBuildDirectory ${TARGET_BUILD_DIR:-/tmp}" && \
#		echo "cd ${PROJECT_DIR:-/tmp}" && \
#		echo "builtin-create-build-directory ${TARGET_BUILD_DIR:-/tmp}" && \
#		mkdir -p ${TARGET_BUILD_DIR:-/tmp} 2>/dev/null || test -d ${TARGET_BUILD_DIR:-/tmp} || EXIT_CODE=3 ;
#		xattr -w com.apple.xcode.CreatedByBuildSystem true ${TARGET_BUILD_DIR:-/tmp} ; wait ;
#		echo "Make copy for ${TASK}" || EXIT_CODE=4
#	fi
#	#EXCLUDED_SOURCE_FILE_NAMES
#	${CP:-cp} -vfpR ${REF_PWD} ${TARGET_BUILD_DIR:-/tmp}/${PRODUCT_NAME:-demo} 2>/dev/null || EXIT_CODE=2
#	xattr -w com.apple.xcode.CreatedByBuildSystem true ${TARGET_BUILD_DIR:-/tmp}/${PRODUCT_NAME:-demo} || EXIT_CODE=2
#	printf "End XCMBCopy\n\n" || EXIT_CODE=1
#fi;
#echo "End ${TASK}" && echo "" && echo "" || EXIT_CODE=1 ;
#exit ${EXIT_CODE:-255}
