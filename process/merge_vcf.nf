process merge_vcf {
  publishDir "${params.runinfo}/merge_vcf/", mode: 'copy', pattern: ".command.log", saveAs: {filename -> "${lineage}_merge_vcf.log"}
  publishDir "${params.databases}/build_reference/vcf/merged_vcf/", mode: 'copy', pattern: "${lineage}_merged.*"

  input:
  val lineage

  output:
  path "${lineage}_merged.vcf.gz"
  path "${lineage}_merged.frq"
  val lineage, emit: lineage
  path ".command.log"

  script:
  """
  #!/bin/bash
  ##############################################
  # Source: https://github.com/baymlab/wastewater_analysis
  #############################################
  echo "--------------------\nMerge vcf file for lineage ${lineage}\n--------------------"

  sample_count=\$(ls ${projectDir}/${params.databases}/build_reference/vcf/${lineage}_*_merged.vcf.gz | wc -l)

  if [[ \$sample_count -eq 1 ]]; then
    cp ${projectDir}/${params.databases}/build_reference/vcf/${lineage}_*_merged.vcf.gz ${lineage}_merged.vcf.gz
  elif [[ \$sample_count -gt 1 ]]; then
    for file in ${projectDir}/${params.databases}/build_reference/vcf/${lineage}_*_merged.vcf.gz; do
      bcftools index -f \$file
    done
    bcftools merge -o ${lineage}_merged.vcf.gz -O z ${projectDir}/${params.databases}/build_reference/vcf/${lineage}_*_merged.vcf.gz
  fi
  # TODO: site-pi information needed?
  vcftools --gzvcf ${lineage}_merged.vcf.gz --out ${lineage}_merged --site-pi
  vcftools --gzvcf ${lineage}_merged.vcf.gz --out ${lineage}_merged --freq

  rm ${projectDir}/${params.databases}/build_reference/vcf/${lineage}_*_merged.vcf.gz*
  """

}
