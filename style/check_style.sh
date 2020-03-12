#!/bin/bash
exit_code=0

tab_lines=$(style/files.sh | xargs awk '/\t/' | wc -l)
if [ "${tab_lines}" -ne 0 ]; then
  echo "Found ${tab_lines} lines with tabs"
  exit_code=1
fi

bad_whitespace_lines=$(style/files.sh | xargs egrep " +$" | wc -l)
if [ "${bad_whitespace_lines}" -ne 0 ]; then
  echo "Found ${bad_whitespace_lines} lines with trailing whitespace"
  exit_code=2
fi

lineid_lines=$(style/files.sh | xargs grep 'LineId' | wc -l)
if [ "${lineid_lines}" -ne 0 ]; then
  echo "Found ${lineid_lines} lines with same-file debug line ids (fix your twincat config)"
  exit_code=3
fi

exit $exit_code
