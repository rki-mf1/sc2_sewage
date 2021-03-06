process download_desh {
  storeDir "${params.databases}/DESH/"

  output:
  path "SARS-CoV-2-Sequenzdaten_aus_Deutschland/SARS-CoV-2-Sequenzdaten_Deutschland.csv.xz", emit: meta
  path "SARS-CoV-2-Sequenzdaten_aus_Deutschland/SARS-CoV-2-Entwicklungslinien_Deutschland.csv.xz", emit: lines
  path "SARS-CoV-2-Sequenzdaten_aus_Deutschland/SARS-CoV-2-Sequenzdaten_Deutschland.fasta.xz", emit: seq
  file ".command.log"

  script:
  """
  #!/bin/bash

  echo "--------------------Download DESH data--------------------"

  git clone https://github.com/robert-koch-institut/SARS-CoV-2-Sequenzdaten_aus_Deutschland.git
  """

}
