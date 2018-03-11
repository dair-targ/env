#!/bin/bash

ENV_UUID="551007e297f511e593a71b4727b21972"
if [[ $EUID == 0 ]]
then
    PROFILE="/etc/profile"
    PROFILE_DIR="/etc/profile.d"
else
    PROFILE="${HOME}/.profile"
    PROFILE_DIR="${HOME}/.profile.d"
fi

if [[ ! -f "${PROFILE}" ]]
then
    echo -e "#!/bin/bash\n" > "${PROFILE}"
fi

if [[ -z $(grep "${ENV_UUID}" "${PROFILE}") ]]
then
    cat >>"${PROFILE}" <<_PROFILE

# ENV_UUID:${ENV_UUID}
for f in \$(find "${PROFILE_DIR}" -name *.sh)
do
    source "\${f}"
done
_PROFILE

    mkdir -p "${PROFILE_DIR}"
    cp scripts/*.sh "${PROFILE_DIR}"
    chmod u+x ${PROFILE_DIR}/*.sh
fi
