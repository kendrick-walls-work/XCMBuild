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


# use COPYING_PRESERVES_HFS_DATA fo .DS_Store
# use REMOVE_GIT_FROM_RESOURCES
# use REMOVE_HG_FROM_RESOURCES
# use REMOVE_CVS_FROM_RESOURCES
# use REMOVE_SVN_FROM_RESOURCES

# use SUPPORTS_TEXT_BASED_API ? and TAPI_VERIFY_MODE

# use REZ_COLLECTOR_DIR and REZ_OBJECTS_DIR with Rez?

export LANG=en_US.${STRINGS_FILE_OUTPUT_ENCODING:-"UTF-8"} ;
# shellcheck disable=SC2155,SC2046
export __CF_USER_TEXT_ENCODING=$( printf "%s" $( printf "%s" "${__CF_USER_TEXT_ENCODING:-0x0}" | cut -d : -f 1 ):0x08000100:0x0 )
export SHELL=${SHELL:-$(xcrun --sdk macosx --find bash)} ;
export RECURSION_COPY_CMD="${RECURSION_COPY_CMD:-${0}}" ;
export SCRIPTS_FOLDER_PATH="${SCRIPTS_FOLDER_PATH:-$(dirname ${0})}" ;
#EXIT_CODE=0

function fn_echo_if_verbose() {
	if [[ ${VERBOSE_PBXCP} == *NO ]] ; then
		: ;
	else
		local _TMP_MSG="${1}";
		{ printf "%s" "${_TMP_MSG}" ;} && : ;
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

# see SCRIPTS_FOLDER_PATH

test -x "$(command -v rm)" || exit 126 ;
test -x "$(command -v find)" || exit 126 ;
test -x "$(command -v unlink)" || exit 126 ;
test -x "$(command -v dirname)" || exit 126 ;
# shellcheck disable=SC2086
test -x "${SCRIPTS_FOLDER_PATH}/serialized" || exit 126 ;
# shellcheck disable=SC2086,SC1091
source "${SCRIPTS_FOLDER_PATH}/serialized" || exit 40 ;

function fn_echo_to() {
	local arrow_right_hex="0xe287a2" ;
	{ fn_echo_if_verbose "$arrow_right_hex" | xxd -rp 2>/dev/null ;} && : ;
}

export -f fn_echo_to ;

function fn_echo_copy_did() {
	{ fn_echo_if_verbose "${1} " && \
	fn_echo_to && \
	fn_echo_if_verbose " ${2}" && \
	fn_echo_NewLine_if_verbose ;} && : ;
}

function fn_placeholder_ensureDir() {
	local CP_X_DIR_PATH=${1};
	# shellcheck disable=SC2046
	{ { test -n "${CP_X_DIR_PATH:-}" || false; } && \
	{ test -d "${CP_X_DIR_PATH:-}" || test -h "${CP_X_DIR_PATH:-}" || \
	test -L "${CP_X_DIR_PATH:-}" ;} ;} || \
	{ ( fn_placeholder_ensureDir $(dirname "${CP_X_DIR_PATH:-}") && \
	(mkdir -m 775 "${CP_X_DIR_PATH:-}" 2>/dev/null && \
	xattr -w com.apple.xcode.CreatedByBuildSystem true "${CP_X_DIR_PATH:-}" )) && \
	test -d "${CP_X_DIR_PATH:-}" ;} || false ;
	return $?
}

export -f fn_placeholder_ensureDir ;

function fn_taint_in_for_copy() {
	local CP_TEMP_PATH_STUB="${1: -128}${2::128}" ;
	local CP_TEMP_PATH_SUBI="${CP_TEMP_PATH_STUB///}" ;
	local PACE__="[^[:alnum:]]" ;
	local CP_TEMP_PATH_SUBO="${CP_TEMP_PATH_SUBI//$PACE__}" ;
	unset PACE__ 2>/dev/null || : ;
	unset CP_TEMP_PATH_SUBI 2>/dev/null || : ;
	unset CP_TEMP_PATH_STUB 2>/dev/null || : ;
	printf "%s" "${CP_TEMP_PATH_SUBO}" ;
	unset CP_TEMP_PATH_SUBO 2>/dev/null || : ;
}

export -f fn_taint_in_for_copy ;
export -f fn_echo_copy_did ;

function copy_no_strip_file_src() {
	# TODO: test with all types of // doubling
	local CP_FILE_SOURCE_PATH="${1}" ;
	if [[ ( -f "${CP_FILE_SOURCE_PATH}" ) ]] ; then
		local CP_FILE_DEST_PATH="${2}" ;
		# shellcheck disable=SC2155,SC2046
		local CP_TEMP_PATH="${PROJECT_TEMP_DIR:-${CONFIGURATION_TEMP_DIR:-/tmp/}}"$(fn_taint_in_for_copy "${1}" "${2}" ) ;
		if [[ ! ( -d "${CP_FILE_DEST_PATH}" ) ]] ; then
			# shellcheck disable=SC2046
			tar -cf "${CP_TEMP_PATH}" -C $(dirname "${CP_FILE_SOURCE_PATH}") --xattrs --mac-metadata $(basename "${CP_FILE_SOURCE_PATH}") && \
			tar -xf "${CP_TEMP_PATH}" -C $(dirname "${CP_FILE_DEST_PATH}") --safe-writes --xattrs --mac-metadata $(basename "${CP_FILE_SOURCE_PATH}")
			wait ;
			rm -f "${CP_TEMP_PATH}" 2>/dev/null || : ;
			fn_echo_copy_did "${CP_FILE_SOURCE_PATH}" "${CP_FILE_DEST_PATH}" ;
		else
			printf "%s -X (BROKEN)\n" "${CP_FILE_SOURCE_PATH}"
			##echo "${FUNCNAME:-$0}:${BASH_LINENO:-0}: MODE NOT IMPLEMENTED YET" >&2 ;
		fi ;
		unset CP_FILE_DEST_PATH 2>/dev/null || : ;
		unset CP_TEMP_PATH  2>/dev/null || : ;
	fi ;
	unset CP_FILE_SOURCE_PATH 2>/dev/null || : ;
}

# if [[ $COPY_PHASE_STRIP == *YES ]] ; then copy_and_strip_file_src ; else copy_no_strip_file_src ; fi

# logic:
# for all src paths in source (directory) check if directory name is in dest
# BRANCH: fn_placeholder_ensureDir
# if not in dest, lock and mkdir, if still not there, else noop, and then, always unlock
# if/once is in dest lock and recursivly call self with curr_src_path dest+dirname

export -f copy_no_strip_file_src ;

function copy() {
	local CP_SOURCE_PATH="${1}" ;
	local CP_DEST_PATH="${2}" ;
	if [[ ( -e ${CP_SOURCE_PATH} ) ]] ; then
		wait ;
		if [[ ( -f ${CP_SOURCE_PATH} ) ]] || [[ ( -d ${CP_SOURCE_PATH} ) ]] ; then
			if [[ ( -d ${CP_SOURCE_PATH}) ]] ; then
				fn_placeholder_ensureDir "${CP_DEST_PATH}" ;
				# shellcheck disable=SC2038
				find "${CP_SOURCE_PATH}" -depth 1 -type d -exec basename '{}' ';' 2>/dev/null | xargs -L1 -I{} "${RECURSION_COPY_CMD}" "${CP_SOURCE_PATH%%/}"/"{}" "${CP_DEST_PATH%%'{}'}/{}" ;
				# shellcheck disable=SC2038
				{ find "${CP_SOURCE_PATH}" -depth 1 -type f -exec basename '{}' ';' 2>/dev/null | xargs -L1 -I{} "${RECURSION_COPY_CMD}" "${CP_SOURCE_PATH%%/}"/"{}" "${CP_DEST_PATH%%/}/{}" 2>/dev/null ;} & \
				fn_echo_copy_did "${CP_SOURCE_PATH}" "${CP_DEST_PATH}" && : ;
			else
			# TODO: exclude bad files
				copy_no_strip_file_src "${CP_SOURCE_PATH}" "${CP_DEST_PATH}" ;
				##echo "${FUNCNAME:-$0}:${BASH_LINENO:-0}: MODE NOT IMPLEMENTED YET" >&2 ;
			fi ;
		else
			# TODO: resolve link accross base paths
			# shellcheck disable=SC2155,SC2046
			printf "Link %s " "${CP_SOURCE_PATH}" && \
			fn_echo_to && \
			printf " %s" "${CP_DEST_PATH}" && \
			printf " ( %s )\n" $(readlink "${CP_SOURCE_PATH}") && : ;
		fi
	fi
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

if [[ $0 == *copyfile.bash ]] ; then
	#shellcheck disable=SC2078
	if [[ safetyCheckSerialized ]] ; then
		if [[ ( ${#} -lt 2 ) ]] ; then
			if [[ ( ${#} -ge 1 ) ]] && [[ ( -e "${1}" ) ]] && [[ ( "${1}" -ef "${SCRIPT_INPUT_FILE_0}" ) ]] ; then
				if [[ -n "${SCRIPT_OUTPUT_FILE_0}" ]] ; then
					exec "${0} ${SCRIPT_INPUT_FILE_0} ${SCRIPT_OUTPUT_FILE_0}" ;
				fi ;
				if [[ ${VERBOSE_PBXCP} == *YES ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Invalid internal State! (Unexpected)" >&2 ; exit 41; fi ;
			elif [[ ( ${#} -ge 1 ) ]] && [[ ! ( -e "${1}" ) ]] && [[ ( -e "${SCRIPT_INPUT_FILE_0}" ) ]] ; then
				if [[ -z ${SCRIPT_OUTPUT_FILE_0} ]] ; then
					export -x SCRIPT_OUTPUT_FILE_0="${1}";
					export SCRIPT_OUTPUT_FILE_COUNT=1 ;
					exec "${0} ${SCRIPT_INPUT_FILE_0} ${1}" ;
				fi ;
				if [[ ${VERBOSE_PBXCP} == *YES ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Invalid internal State! (Unexpected)" >&2 ; exit 45; fi ;
			elif [[ ( ${#} -lt 1 ) ]] && [[ ( -e "${SCRIPT_INPUT_FILE_0}" ) ]] ; then
				if [[ -n "${SCRIPT_OUTPUT_FILE_0}" ]] ; then
					exec "${0} ${SCRIPT_INPUT_FILE_0} ${SCRIPT_OUTPUT_FILE_0}" ;
				fi ;
				if [[ ${VERBOSE_PBXCP} == *YES ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Invalid internal State! (Unexpected)" >&2 ; exit 44; fi ;
			#elif [[ ( ${#} -ge 1 ) ]] && [[ !( -e "${1}" ) ]] ; then also [[ !( -e "${SCRIPT_INPUT_FILE_0}" ) ]] therfore fallthrough (is missing src OR is missing Dest OR is missing both)
			elif [[ ( ${#} -lt 1 ) ]] ; then
				# reduces to
				if [[ ${VERBOSE_PBXCP} == *YES ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Invalid internal State! (Ambiguous)" >&2 ; exit 43; fi ;
			fi;
			if [[ ${VERBOSE_PBXCP} == *YES ]] ; then printf "%s\n" "${FUNCNAME:-$0}:${BASH_LINENO:-0}: error: Invalid internal State! (BUG)" >&2 ; exit 43; fi ;
		elif [[ ( ${#} -gt 2 ) ]] ; then
			fn_echo_if_verbose "Not implemented yet"; fn_echo_NewLine_if_verbose ;
			# need to filter args and then just exec "${0} ${SCRIPT_INPUT_FILE_0} ${SCRIPT_OUTPUT_FILE_0}" ;
			exit 2 ;
		fi ;
		# Else SHOULD be all good if NOT sandboxed
	fi ;
	{ copy "${@}" && true; } || false ;
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
