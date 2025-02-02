reset:
	rm -rf slides
	mkdir -p
	cp lightning-slide.pdf black.pdf slides

schedule:
	./make-schedule > schedule.md
	pandoc schedule.md --pdf-engine=xelatex -o schedule.pdf
