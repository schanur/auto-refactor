#!/bin/bash

function header_file_has_include_guard() {
    local FILE=${1}
    local EXPECTED_DEFINE
    local DEFINE_OCCURANCE_CNT

    # EXPECTED_DEFINE="$(echo ${FILE} |sed -e 's/src\///g' |sed -e 's/\//__/g' | sed -r 's/([a-z]+)([A-Z][a-z]+)/\1_\l\2/g' |awk '{print toupper($0)}' |sed -e 's/\.H/\_H/g')"
    # EXPECTED_DEFINE="$(echo ${FILE} |sed -e 's/src\///g' |sed -e 's/\//__/g' | sed -e 's/\([A-Z]\)/_\1/g' |sed -e 's/___/__/g' |awk '{print toupper($0)}' |sed -e 's/\.H/\_H/g')"
    EXPECTED_DEFINE="$(echo ${FILE} |sed -e 's/src\///g' |sed -e 's/\//__/g' | sed -e 's/\([A-Z]\)/_\1/g' |sed -e 's/___/__/g' |sed -e 's/^_//g' |awk '{print toupper($0)}' |sed -e 's/\./\_/g')"
    # echo "<<${EXPECTED_DEFINE}>>"
    # exit 1
    # local EXPECTED_DEFINE="$(echo ${FILE} |sed -e 's/src\///g' |sed -e 's/\//__/g' | sed -r 's/([a-z]+)([A-Z][a-z]+)/\1_\l\2/g' |awk '{print toupper($0)}' |sed -e 's/\.H/\_H/g')"

    DEFINE_OCCURANCE_CNT="$(cat ${FILE} |grep -c ${EXPECTED_DEFINE})"
    if [ "${DEFINE_OCCURANCE_CNT}" -ne "3" ]; then
        echo "${FILE}: No include guard of name ${EXPECTED_DEFINE} found. Expected occurances: 3: Found occurances: ${DEFINE_OCCURANCE_CNT}"
    fi
}

function main() {
    local FILE
    for FILE in $(find src/ -type f -name "*.h"); do
        header_file_has_include_guard ${FILE}
    done
}

main
