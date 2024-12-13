.PHONY: clean

all: report/count_report.html report/count_report_files

# Count the words
results/isles.dat: scripts/wordcount.py data/isles.txt 
	python3 scripts/wordcount.py \
    	--input_file=data/isles.txt \
    	--output_file=results/isles.dat

results/abyss.dat: scripts/wordcount.py data/abyss.txt
	python3 scripts/wordcount.py \
	    --input_file=data/abyss.txt \
	    --output_file=results/abyss.dat

results/last.dat: scripts/wordcount.py data/last.txt
	python3 scripts/wordcount.py \
	    --input_file=data/last.txt \
	    --output_file=results/last.dat

results/sierra.dat: scripts/wordcount.py data/sierra.txt
	python3 scripts/wordcount.py \
	    --input_file=data/sierra.txt \
	    --output_file=results/sierra.dat

# make the plots
results/figure/isles.png: scripts/plotcount.py results/isles.dat
	python3 scripts/plotcount.py \
	    --input_file=results/isles.dat \
	    --output_file=results/figure/isles.png

results/figure/abyss.png: scripts/plotcount.py results/abyss.dat
	python3 scripts/plotcount.py \
	    --input_file=results/abyss.dat \
	    --output_file=results/figure/abyss.png

results/figure/last.png: scripts/plotcount.py results/last.dat
	python3 scripts/plotcount.py \
	    --input_file=results/last.dat \
	    --output_file=results/figure/last.png

results/figure/sierra.png: scripts/plotcount.py results/sierra.dat
	python3 scripts/plotcount.py \
	    --input_file=results/sierra.dat \
	    --output_file=results/figure/sierra.png

report/count_report.html report/count_report_files: results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
	quarto render report/count_report.qmd

clean:
	rm -f results/isles.dat \
		results/abyss.dat \
		results/last.dat \
		results/sierra.dat
	rm -f results/figure/isles.png \
		results/figure/abyss.png \
		results/figure/last.png \
		results/figure/sierra.png	
	rm -rf report/count_report.html \
		report/count_report_files