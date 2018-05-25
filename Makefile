all: bottom_half.stl top_half.stl

%.stl: %.scad arduino-nano-case.scad
	openscad $< -o $@

clean:
	rm *.stl
