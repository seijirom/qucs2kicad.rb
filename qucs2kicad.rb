# -*- coding: utf-8 -*- !/usr/bin/python -*- coding: utf-8 -*- """
#This tool convert qucs .sch files to kicad .sch files
#
#Options
#-t	--target: Output directory, default input dir= output dir
#-h	--help	: Show this help

#python version
#Version 0.0.1alpha
#Original Author: Khoteev Serguei
#ruby version
#Author:Seijiro Moriyama
#GPLv2
#"""
require 'component.rb'
require 'shifl_wire.rb'

print "Target -", file_path= ARGV[0], "\n"
print "Output directory -", start_path = ARGV[1], "\n"

qu = File.open(file_path,'r')

qucs_output_file_path=start_path+'/'+File.basename(file_path.sub('.ssh',''))+'_kicad.sch'
print "Output file -", qucs_output_file_path, "\n"
ki=File.open(qucs_output_file_path,'w')

wire_file=start_path+'/'+File.basename(file_path)[0..-4]+'_wires'
wr=File.open(wire_file,'w')
#Let's go!
ki.write("EESchema Schematic File Version 2  date Вск 07 Авг 2011 00:36:35\nLIBS:power\nLIBS:device\nLIBS:transistors\nLIBS:conn\nLIBS:linear\nLIBS:regul\nLIBS:74xx\nLIBS:cmos4000\nLIBS:adc-dac\nLIBS:memory\nLIBS:xilinx\nLIBS:special\nLIBS:microcontrollers\nLIBS:dsp\nLIBS:microchip\nLIBS:analog_switches\nLIBS:motorola\nLIBS:texas\nLIBS:intel\nLIBS:audio\nLIBS:interface\nLIBS:digital-audio\nLIBS:philips\nLIBS:display\nLIBS:cypress\nLIBS:siliconi\nLIBS:opto\nLIBS:atmel\nLIBS:contrib\nLIBS:valves\nEELAYER 43  0\nEELAYER END\n\$Descr A4 11700 8267\nencoding utf-8\nSheet 1 1\nTitle ""\nDate \"9 aug 2011\"\nRev ""\nComp ""\nComment1 ""\nComment2 ""\nComment3 ""\nComment4 ""\n\$EndDescr\n")	# it's not yet understand

#15.08.2011 QUCS file structure is different from the order of appearance kiCAD connections wires in qucs they follow after components in kicad up is required buffer
#15.08.2011 Yes like everything is read in reverse order (kiCAD changed the order of wire and component), will introduce a buffer to store all the wire and further
#reduce their number after the conversion.

def int s
  s.to_i
end

def str i
  i.to_s
end

ss=qu.readline()
puts "START!"
print ss
while (ss=qu.readline())!="</Paintings>\n" do
  #  print ss
  if ss=="<Components>\n"
    ss=qu.readline()
    while ss!="</Components>\n" do
      #Actions to transform
      s=ss.strip	#get rid of spaces before and after
      s=s[1..-2]
      rs=s.split	#possible errors which strays from the list numberingn
      puts rs.inspect
      if rs[0]=='R'
        #        puts "matched:#{rs.inspect}"
        letter= resistor(rs) #perform the function performs the function of converting
        ki.write(letter)
        if (rs[8]=='0') or (rs[8]=='2')
          letter="Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10+250)+' '+str(int(rs[4])*10)+' '
          letter << str(int(rs[3])*10+300)+' '+str(int(rs[4])*10)+"\n"
          letter << "Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10-250)+' '+str(int(rs[4])*10)+' '
          letter << str(int(rs[3])*10-300)+' '+str(int(rs[4])*10)+"\n"
        else
          letter="Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10)+' '+str(int(rs[4])*10+250)+' '
          letter << str(int(rs[3])*10)+' '+str(int(rs[4])*10+300)+"\n"
          letter << "Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10)+' '+str(int(rs[4])*10-250)+' '
          letter << str(int(rs[3])*10)+' '+str(int(rs[4])*10-300)+"\n"
        end
        wr.write(letter)		
        # puts letter
      elsif rs[0]=='C'
        letter= capsicator(rs)
        ki.write(letter)
        if (rs[8]=='0') or (rs[8]=='2') 
          letter="Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10+200)+' '+str(int(rs[4])*10)+' '
          letter << str(int(rs[3])*10+300)+' '+str(int(rs[4])*10)+"\n"
          letter << "Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10-200)+' '+str(int(rs[4])*10)+' '
          letter << str(int(rs[3])*10-300)+' '+str(int(rs[4])*10)+"\n"
        else
          letter="Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10)+' '+str(int(rs[4])*10+200)+' '
          letter << str(int(rs[3])*10)+' '+str(int(rs[4])*10+300)+"\n"
          letter << "Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10)+' '+str(int(rs[4])*10-200)+' '
          letter << str(int(rs[3])*10)+' '+str(int(rs[4])*10-300)+"\n"
        end
        wr.write(letter)
      elsif rs[0]=='L'
        letter= inductance(rs)
        ki.write(letter)
      elsif rs[0]=='Diode'
        letter= diode(rs)
        ki.write(letter)				
        if (rs[8]=='0') or (rs[8]=='2')
          letter="Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10+200)+' '+str(int(rs[4])*10)+' '
          letter << str(int(rs[3])*10+300)+' '+str(int(rs[4])*10)+"\n"
          letter << "Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10-200)+' '+str(int(rs[4])*10)+' '
          letter << str(int(rs[3])*10-300)+' '+str(int(rs[4])*10)+"\n"
        else
          letter="Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10)+' '+str(int(rs[4])*10+200)+' '
          letter << str(int(rs[3])*10)+' '+str(int(rs[4])*10+300)+"\n"
          letter << "Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10)+' '+str(int(rs[4])*10-200)+' '
          letter << str(int(rs[3])*10)+' '+str(int(rs[4])*10-300)+"\n"
        end
        wr.write(letter)
      elsif rs[0]=='_BJT'
        letter= transistor(rs)
        ki.write(letter)
        if (rs[8]=='1') or (rs[8]=='3') 
          letter="Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10+200)+' '+str(int(rs[4])*10)+' '
          letter << str(int(rs[3])*10+300)+' '+str(int(rs[4])*10)+"\n"
          letter << "Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10-200)+' '+str(int(rs[4])*10)+' '
          letter << str(int(rs[3])*10-300)+' '+str(int(rs[4])*10)+"\n"
        else
          letter="Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10)+' '+str(int(rs[4])*10+200)+' '
          letter << str(int(rs[3])*10)+' '+str(int(rs[4])*10+300)+"\n"
          letter << "Wire Wire Line\n"
          letter << "\t"+str(int(rs[3])*10)+' '+str(int(rs[4])*10-200)+' '
          letter << str(int(rs[3])*10)+' '+str(int(rs[4])*10-300)+"\n"
        end
        wr.write(letter)
      elsif rs[0]=='GND'
        letter= gnd(rs)
        ki.write(letter)
      end
      ss=qu.readline()
    end
    ss=qu.readline()
#    puts "SS=#{ss}"
    if ss=="<Wires>\n"
      while (ss=qu.readline())!="</Wires>\n" do
        #Actions to convert compounds
        s=ss.strip	#get rid of spaces before and after
        s=s[1..-2]			
        rs=s.split
        puts rs.inspect
        letter="Wire Wire Line\n"
        letter << "\t"+str(int(rs[0])*10)+' '+str(int(rs[1])*10)+' '+str(int(rs[2])*10)+' '+str(int(rs[3])*10)+"\n"
        wr.write(letter)				
      end
      ss=qu.readline()
    end
  end
end
#  else
print ss	#here we are going to merge the buffer!
wr.close()
wirecomp(wire_file)
wr=File.open(wire_file,'r')

while not wr.eof?and ss=wr.readline()
  ki.write(ss)
end      
ki.write('$EndSCHEMATC')
qu.close()
ki.close()


