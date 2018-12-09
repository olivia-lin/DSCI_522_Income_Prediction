# Makefile
# Mani Kohli, Olivia Lin  Nov 28th 2018

# This Makefile generates a report for the analysis of the strongest predictors for determining
# to determine a salary greater than $50,000.
# This MakeFile runs 4 individual scripts to render data and visuals to be included for the final
# report. In addition, this file can also be used to reset (clean) our project to the time before
# all scripts were run.

# example usage:
# make clean
# make all

# render the report and all other outputs
all: doc/final_report.md

# clean data: run script_01_load_tidy_data.R and output tidy data
data/tidy_data_viz.csv data/tidy_data_ml.csv : $(https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data) src/script_01_load_tidy_data.R
	Rscript src/script_01_load_tidy_data.R https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data data/tidy_data_viz.csv data/tidy_data_ml.csv

# create visuals: run script_02_visualizations.R and output two figures
results/data_viz_01.png results/data_viz_02.png results/data_viz_03.png results/data_viz_04.png: data/tidy_data_viz.csv src/script_02_visualizations.R
	Rscript src/script_02_visualizations.R data/tidy_data_viz.csv results/data_viz_01.png results/data_viz_02.png results/data_viz_03.png results/data_viz_04.png

# binary tree: run script_03_machine_learning.py and output summary tables for machine learning
results/depth_summary.csv results/feature_summary.csv: data/tidy_data_ml.csv src/script_03_machine_learning.py
	python src/script_03_machine_learning.py data/tidy_data_ml.csv results/depth_summary.csv results/feature_summary.csv

# create summary: run script_04_create_summary_graph.R and output summary plots from summary tables
results/depth_graph.png results/feature_graph.png : results/depth_summary.csv results/feature_summary.csv src/script_04_create_summary_graph.R
	Rscript src/script_04_create_summary_graph.R results/depth_summary.csv results/feature_summary.csv results/depth_graph.png results/feature_graph.png

# render md type of the report
doc/final_report.md : results/data_viz_01.png results/data_viz_04.png results/data_viz_02.png results/data_viz_03.png results/depth_graph.png results/feature_graph.png
    Rscript -e "rmarkdown::render('doc/final_report.Rmd')"
                    $(info Generating Report)

clean :
	rm -f data/tidy_data_viz.csv
	rm -f data/tidy_data_ml.csv
	rm -f results/data_viz_01.png
	rm -f results/data_viz_02.png
	rm -f results/data_viz_03.png
	rm -f results/data_viz_04.png
	rm -f results/depth_summary.csv
	rm -f results/feature_summary.csv
	rm -f results/depth_graph.png
	rm -f results/feature_graph.png
	rm -f results/depth_graph.png
	rm -f doc/final_report.html
	rm -f results/feature_graph.png
