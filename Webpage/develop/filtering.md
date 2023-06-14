# Data filtering

Each person works on its own personal folder, which contains a dataset. As a reminder, these are the personal folders

| Name | Sample folder |
|---|---|
| Andersen, Albert Lund  | Gifu_ctr_1  |
| Bagger, Andreas	  | Gifu_ctr_2  |
| Hansen, Mads Würgler	  | Gifu_ctr_ 3 |
| Milo, Lasse	  | Gifu_ctr_4  |
| Reimick, Sebastian Haunstrup  | Gifu_R7A_1  |
| Hemmingsen, Jonas Klejs  | Gifu_R7A_2  |
| Skovmøller, Emma Hvitfeldt  | Gifu_R7A_3  |
| Sørensen, Emma Frasez  | Gifu_R7A_4  |
|Agersnap, Simon Nørregaard | HAR1_ctr_1 |
| Schmidt, Alina | HAR1_ctr_2 |
|Henriksen, Frederik Oskar | HAR1_ctr_3  |
|Lundby, Josephine Marie | HAR1_ctr_4 |
|Nørholm, Anne | HAR1_R7A_1 |
|Odgaard, Louise Nyrup | HAR1_R7A_2 |
|Sørensen, Sara Sejer | HAR1_R7A_3 |
|Lønskov, Jonas | HAR1_R7A_4 |
|Niklassen, Jacob Hansen | Gifu_ctr_1_bis |
|Øllgaard, Ann Mai Brøndum Holm | Gifu_ctr_2_bis |
|Overgaard, Morten Øgelund | Gifu_R7A_1_bis |
|Sørensen, Elisabeth Asta | Gifu_R7A_2_bis |
|Rey, Isabel | HAR1_ctr_1_bis |

## Instructions

1. Open a new session of jupyterlab in the same way as in [the tutorial session](./tutorial.md)

2. Find your way to your personal folder, which is inside `426401/Students_analysis`

3. Start filtering your data using the notebook `filtering.ipynb`. This is a copy of the first part of the tutorial, so be careful about small changes you have to made (e.g. condition name, thresholds). For the **condition name** created in the metadata at the beginning of the tutorial, here we use one of `Gifu_Control`, `Gifu_Infected`, `HAR1_Control`, `HAR1_Infected` (depending on the dataset you have assigned), so that it is easy to integrated all datasets at the end.
4. When you are done and you saved your data at the end (keep the filename `filtered.h5Seurat`), write when you are done at [this google docs](https://docs.google.com/spreadsheets/d/1Ln6Qomy8GAWNi0YH6l604AEZQd0uPUH9xEm1HPGRISg/edit?usp=sharing) under the sheet `Filtering`, so we all know when we are ready to proceed to data integration.