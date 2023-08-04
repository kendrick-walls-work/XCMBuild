#! /bin/bash

# logic 101

#  usage:
#	$0 $SRCROOT [build|test|clean|archive]
#

export LANG=en_US.${STRINGS_FILE_OUTPUT_ENCODING:-"UTF-8"}
export __CF_USER_TEXT_ENCODING=$( echo $( echo ${__CF_USER_TEXT_ENCODING:-0x0} | cut -d : -f 1 ):0x08000100:0x0 )
export PROJECT_DIR="${PROJECT_DIR:-${SRCROOT:-$(pwd)}}"
if [[ ( -d .git ) ]] ; then export PRODUCT_NAME=${PRODUCT_NAME:-$(basename `git rev-parse --show-toplevel 2>/dev/null`)} ; fi
export REF_PWD="${PROJECT_DIR:-${SRCROOT:-$(pwd)}}"/"${PRODUCT_NAME}"
EXIT_CODE=0
cd $REF_PWD || ( echo "$0:${LINENO:-0}: warning: failed to recognize build environment." >&2 && EXIT_CODE=1 ) ;
test -d ./.git || ( echo "$0:${LINENO:-0}: error: failed to validate repository status. This tool only works with git repos using a makefile for actions." >&2 && exit 126 ) ;
if [[ ( -r "./codecov_env" ) ]] ; then
	source ./codecov_env 2>/dev/null || true ;
fi ;
cd $OLDPWD 2>/dev/null || true ;
# be sure to have $(xcode-select -p)/usr/bin added to dev-user's PATH
export CI_TEST_PROJECT_DIR=${CI_TEST_PROJECT_DIR:-${BUILT_PRODUCTS_DIR:-${TMPDIR:-$(getconf TMPDIR)}/${PRODUCT_NAME}.tmp}}
export ACTION=${ACTION:-"build"}
TASK=${2:-${ACTION}}
# SYMROOT=$(xcodebuild -showBuildSettings -project "${PROJECT_DIR}"/"${PROJECT_NAME}.xcodeproj" | grep -F "SYMROOT" | cut -d\= -f 2- | cut -d\  -f2-)
umask 0027
printf "\n${ACTION} target ${TARGET_NAME:-unknown} of project ${PROJECT_NAME:-unknown} with configuration ${CONFIGURATION:-default}\n" || EXIT_CODE=1
printf "\nExternalBuildToolExecution ${TASK} (in target '${TARGET_NAME:-unknown}' from project '${PROJECT_NAME:-unknown}')\n"
echo "Start ${TASK}"
if [[ ( $(pwd | grep -Fic "${CI_TEST_PROJECT_DIR}" ) -le 0 ) ]] ; then
	mkdir ${CI_TEST_PROJECT_DIR} 2>/dev/null || test -d ${SYMROOT} || EXIT_CODE=3
	cd ${CI_TEST_PROJECT_DIR} 2>/dev/null || cd ${SYMROOT} 2>/dev/null || EXIT_CODE=2
	if [[ ( $(echo "${ACTION}" | grep -Fic "clean" ) -ge 1 ) ]] ; then EXIT_CODE=0 ; fi
fi
if [[ ( $(pwd | fgrep -ic "${1}" ) -le 0 ) ]] ; then
	cd ${1} 2>/dev/null || cd ./${PRODUCT_NAME} 2>/dev/null || true
fi
if [[ ( $(echo "${ACTION}" | grep -Fic "copy" ) -gt 0 ) ]] ; then
	echo "$0:${LINENO:-0}: note: will use working directory: " $(pwd) || EXIT_CODE=4
	echo "Start PBXCp" || EXIT_CODE=1
	echo "Make copy for ${TASK}" || EXIT_CODE=4
	${CP:-cp} -vfpR ${REF_PWD} ${CI_TEST_PROJECT_DIR:-/tmp/${PRODUCT_NAME:-demo}} 2>/dev/null || EXIT_CODE=2
	printf "End PBXCp\n\n" || EXIT_CODE=1
	cd ${CI_TEST_PROJECT_DIR:-/tmp/${PRODUCT_NAME:-demo}} || EXIT_CODE=3
	source ./codecov_env 2>/dev/null || true ;
else
	echo "Pre-${TASK} ( make -j 1 -f Makefile clean )" ;
	if [[ ( -f ./Makefile ) ]] || [[ ( -f "${1:-/tmp/${PRODUCT_NAME:-demo}}/Makefile" )]] ; then
		make -f ${1:-/tmp/${PRODUCT_NAME:-demo}}/Makefile clean 2>/dev/null >> /dev/null || EXIT_CODE=2
	fi
fi
wait ;
if [[ ( $(echo "${ACTION}" | grep -Fic "clean" ) -lt 1 ) ]] ; then
	if [[ ( $(echo "${TASK}" | grep -Fic "test" ) -gt 0 ) ]] ; then
		if [[ ( -f ./Makefile ) ]] ; then
			echo "Unit Testing ( make -j 1 -f Makefile test )" ;
			(make -j 1 -f ${1:-/tmp/${PRODUCT_NAME:-demo}}/Makefile test || exit 2 ; wait ; ) || EXIT_CODE=2
			wait ;
		fi
		# make test-style || EXIT_CODE=2
		wait ;
		if [[ ( -f ./Makefile ) ]] ; then
			make -j1 clean || EXIT_CODE=2
		fi
	elif [[ ( $(echo "${TASK}" | grep -Fic "purge" ) -ge 1 ) ]] ; then
		echo "Start CLEAN" || EXIT_CODE=1
		if [[ ( -d ${CI_TEST_PROJECT_DIR:-/tmp}/${PRODUCT_NAME:-demo} ) ]] ; then
			rm -vdR ${CI_TEST_PROJECT_DIR:-/tmp}/${PRODUCT_NAME:-demo} || true 2>/dev/null || EXIT_CODE=2
		fi
		printf "End CLEAN\n\n" || EXIT_CODE=1
	else
		echo "$0:${LINENO:-0}: note: Tool not configured for ${TASK}" || EXIT_CODE=126
	fi
elif [[ ( $(echo "${TASK}" | grep -Fic "clean" ) -ge 1 ) ]] ; then
	if [[ ( -f ./Makefile ) ]] ; then
		make -j1 clean || EXIT_CODE=2
	else
		echo "$0:${LINENO:-0}: warning: Nothing to clean!"
	fi
fi
wait ;
echo "End ${TASK}" && echo "" && echo "" || EXIT_CODE=1 ;
exit ${EXIT_CODE:-255}
