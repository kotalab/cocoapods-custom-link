code_sign() {
  # Use the current code_sign_identitiy
  echo "Code Signing $1 with Identity ${EXPANDED_CODE_SIGN_IDENTITY_NAME}"
  echo "/usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements $1"
  /usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements "$1"
}

if [ "$ACTION" = "install" ]; then
  echo "Copy .bcsymbolmap files to .xcarchive"
  find . -name '*.bcsymbolmap' -type f -exec mv {} "${CONFIGURATION_BUILD_DIR}" \;
fi

echo 'Copying frameworks'

if [ $SCRIPT_INPUT_FILE_LIST_COUNT -ne 0 ]; then
  for i in $(seq 0 $(expr $SCRIPT_INPUT_FILE_LIST_COUNT - 1)); do
    inputFileListVar="SCRIPT_INPUT_FILE_LIST_${i}"
    inputFileList="${!inputFileListVar}"
    cat "${inputFileList}" | while read inputFile; do
      cp -rf "$inputFile" "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/"

      for file in $(find ${inputFile} -type f -perm +111); do
        # Skip non-dynamic libraries
        if ! [[ "$(file "$file")" == *"dynamically linked shared library"* ]]; then
          continue
        fi
        if [ "${CODE_SIGNING_REQUIRED}" == "YES" ]; then
          code_sign "${file}"
        fi
      done
    done
  done
fi