SAMPLES_CONFIG = {
    "sample1": {
        "r_scripts": ["RScript_motives.R"],
        "paper": "paper.md",
        "log": "run.log",
        "results_glob": "model_outputs.txt"
    },
    "sample2": {
        "r_scripts": ["Malawi_main.R", "Malawi_interpolation.R", "Malawi_MagSus.R", "Malawi_ordination.R"],
        "paper": "paper.md",
        "log": "run.log",
        "results_glob": "data_output/*.csv"
    },
    "sample3": {
        "r_scripts": ["Flip_MainDataAnalyses.R", "Flux_MainDataAnalyses.R"],
        "paper": "paper.md",
        "log": "run.log",
        "results_glob": "*Analysis_Output.txt"
    },
    "sample4": {
        "r_scripts": ["ComF_SOM_Rcode.R", "ComF_ReproduceResults.R", "ComF_helpers.R"],
        "paper": "paper.md",
        "log": "run.log",
        "results_glob": "ComF_SOM_output.txt"
    },
    "sample5": {
        "r_scripts": ["Script.R", "AnalysesReport.Rmd", "SupplementaryMaterials.Rmd"],
        "paper": "paper.md",
        "log": "run.log",
        "results_glob": "Script_output.txt"
    }
}