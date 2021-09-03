rule fastq_prepare_SE:
    input:  in_filename = lambda wildcards: FTP.remote(expand("ntc.ics.muni.cz/upload/snakemake/bcl2fastq/{run_name}/{sample}_S{sample_index}_R1_001.fastq.gz",run_name = config["run_name"]\
                    ,sample = wildcards.sample\
                    ,sample_index = sample_tab.loc[(sample_tab["sample_name"] == wildcards.sample) & (sample_tab.library == wildcards.library)].index[0])[0])
    output: fastq = FTP.remote("ntc.ics.muni.cz/upload/snakemake/bcl2fastq/{library}/raw_fastq/{sample}.fastq.gz"),
    params: umi = lambda wildcards: config["libraries"][wildcards.library]["UMI"],
            run_name = config["run_name"],
    threads:  1
    log:    FTP.remote("ntc.ics.muni.cz/upload/snakemake/bcl2fastq/{library}/sample_logs/{sample}/fastq_prepare_SE.log")
    conda:  "../wrappers/fastq_prepare_SE/env.yaml"
    script: "../wrappers/fastq_prepare_SE/script.py"

rule fastq_prepare_PE:
    input:  in_filename = lambda wildcards: FTP.remote(expand("ntc.ics.muni.cz/upload/snakemake/bcl2fastq/{run_name}/{sample}_S{sample_index}_R1_001.fastq.gz",run_name = config["run_name"]\
                    ,sample = wildcards.sample\
                    ,sample_index = sample_tab.loc[(sample_tab["sample_name"] == wildcards.sample) & (sample_tab.library == wildcards.library)].index[0])[0])
    output: 
            R1 = FTP.remote("ntc.ics.muni.cz/upload/snakemake/bcl2fastq/{library}/raw_fastq/{sample}_R1.fastq.gz"),
            R2 = FTP.remote("ntc.ics.muni.cz/upload/snakemake/bcl2fastq/{library}/raw_fastq/{sample}_R2.fastq.gz"),
    params: umi = lambda wildcards: config["libraries"][wildcards.library]["UMI"],
            run_name = config["run_name"],
    threads:  1
    log:    FTP.remote("ntc.ics.muni.cz/upload/snakemake/bcl2fastq/{library}/sample_logs/{sample}/fastq_prepare_PE.log")
    conda:  "../wrappers/fastq_prepare_PE/env.yaml"
    script: "../wrappers/fastq_prepare_PE/script.py"
