#!/bin/bash

# Replace DOS line endings with UNIX line endings.
for FILE in $(find src/ -not -type d -exec file "{}" ";" | grep CRLF | cut -f 1 -d ":"); do
    dos2unix ${FILE}
done

# Show all files that contain tab characters.
for FILE in $(find src/ -not -type d); do

    # Grep for tab characters.
    #echo $FILE
    NUM_TABS=$(grep -c -P '\t' ${FILE})
    if [ "${NUM_TABS}" != "0" ]; then
       echo ${FILE}: ${NUM_TABS}
    fi
done

# Remove executable flag from source files.
for FILE in $(find src/ -executable -type f); do
    echo ${FILE} had executable flag set. Removing...
    chmod -x ${FILE}
done
