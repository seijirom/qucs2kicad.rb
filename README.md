# qucs2kicad.rb
Ruby version of Valber's qucs2kicad (in Python)

## How is it converted?

1. converted Russian comments to English using Google translator
2. manually translated Python codes to Ruby codes
   note: py2rb was not so useful because if elif clauses were not converted correctly
3. added some comments where I could understand what Valber-san did
4. tested with testdata/ to confirm that it creates almost same output with the original

## Converted codes
  - qucs2kicad.rb : main program
  - component.rb : creates resistor, capacitor, inductance, diode, transistor and gnd
    note: mosfets and other components are not included
  - shifl_wire.rb : wire compressor

## Conversion note
  - Python's slice (:) caused headache on me and spent several hours to
    convert aa[:a] correctly when a is 0. First I translated it to aa[0..a-1].
    But, when a=0, aa[0..-1] is a whole array, Python's a[:0] is aa[0..0] which is [].  
  - py2rb was not so useful for this Python code
  - I prefer Ruby syntax to Python

## Usage
    in the directory where input data resides,
      ruby qucs2kicad.rb input_file.sch .
    input_file.sch_kicad.sch will be created
    I know that this part should be revised when I have spare time. 
