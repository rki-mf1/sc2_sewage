process build_index {
  publishDir "${params.runinfo}/", mode: 'copy', pattern: ".command.log", saveAs: {filename -> "build_index.log"}
  publishDir "${params.databases}/", mode: 'copy', pattern: "sequences.kallisto.idx"

  input:
  path fasta

  output:
  path "sequences.kallisto_idx", emit: kallisto_idx
  path ".command.log"

  script:
  """
  #!/bin/bash
  echo "----------"----------\nBuild kallisto index\n-----"---------------"
  # replace blank spaces in gisaid headers with underscores since kallisto doesn't accept blanks in fasta headers
  # TODO: maybe move in build_reference_db process to compute this only once
  sed 's/ /_/g' $fasta >> mod_${fasta}

  kallisto index -i sequences.kallisto_idx mod_${fasta}
  """

}
