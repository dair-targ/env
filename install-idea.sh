#!/bin/bash
set -e -o pipefail

DOWNLOADS="${HOME}/Downloads"
APPLICATIONS="${HOME}/Documents/Applications"

if [[ -z $1 ]]
then
  IDEA_ARCHIVE="${DOWNLOADS}/"$(ls -c1 "${DOWNLOADS}" | head -n 1)
else
  IDEA_ARCHIVE="${1}"
fi
echo "${IDEA_ARCHIVE}"

mkdir -p "${APPLICATIONS}"
cp "${IDEA_ARCHIVE}" "${APPLICATIONS}"
cd "${APPLICATIONS}"

echo "Extracting..."
tar xvfz "${APPLICATIONS}"/$(basename "${IDEA_ARCHIVE}") 1>/dev/null 2>&1

IDEA_DIR=${APPLICATIONS}/$(ls -c1 "${APPLICATIONS}" | head -n 1)
echo "Refresing link: idea -> ${IDEA_DIR}"
rm ${APPLICATIONS}/idea
ln ${IDEA_DIR} -s ${APPLICATIONS}/idea
ls -l ${APPLICATIONS}/idea
echo "Done!"

