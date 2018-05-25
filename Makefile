all: bottom_half.stl top_half.stl

%.stl: %.scad
	openscad $< -o $@

clean:
	rm *.stl
