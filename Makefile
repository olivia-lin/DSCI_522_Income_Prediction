# Makefile
# Mani Kohli, Olivia Lin  Nov 28th 2018

# This Makefile script run scripts in our project separately
# can render plots, tables and final report from the codes (final report will be in the doc folder)
# use clean to reset our project to the stage before running all scripts

# example usage:
#

# render the report and all other outputs
all: doc/final_report.md

# run script_01_load_tidy_data.R and output tidy data
data/tidy_data_viz.csv data/tidy_data_ml.csv: src/script_01_load_tidy_data.R https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data
Rscript src/script_01_load_tidy_data.R https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data data/tidy_data_viz.csv data/tidy_data_ml.csv

# run script_02_visualizations.R and output two figures
results/data_viz_01.png results/data_viz_02.png results/data_viz_03.png: src/script_02_visualizations.R data/tidy_data_viz.csv
Rscript src/script_02_visualizations.R data/tidy_data_viz.csv results/data_viz_01.png results/data_viz_02.png results/data_viz_03.png

# run script_03_machine_learning.py and output summary tables for machine learning
results/depth_summary.csv results/feature_summary.csv: src/script_03_machine_learning.py data/tidy_data_ml.csv
python src/script_03_machine_learning.py data/tidy_data_ml.csv results/depth_summary.csv results/feature_summary.csv

# run script_04_create_summary_graph.R and output summary plots from summary tables
results/depth_graph.png results/feature_graph.png: src/script_04_create_summary_graph.R results/depth_summary.csv results/feature_summary.csv
Rscript src/script_04_create_summary_graph.R results/depth_summary.csv results/feature_summary.csv results/depth_graph.png results/feature_graph.png

# render md type of the report
doc/final_report.md : src/script_01_load_tidy_data.R data/tidy_data_viz.csv data/tidy_data_ml.csv src/script_02_visualizations.R results/data_viz_01.png results/data_viz_02.png results/data_ src/script_03_machine_learning.pyviz_0 results/depth_summary.csv results/feature_summary.csv3.png  src/script_04_create_summary_graph.R results/depth_graph.png results/feature_graph.png
	Rscript -e "rmarkdown::render('doc/final_report.Rmd', output_format = 'github_document')"
