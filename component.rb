# -*- coding: utf-8 -*-
#'''
#It describes the functions of converting components
#
#GPLv2
#'''
#15.08.2011 introduce scaling factor km, which will be multiplied coordinates as when converting the image is too spreads
# campaign profitable really use 10 because it is the inductance transferred 1: 1 in the case if you use another square km of inductances in qucs
# slomaetsya in kiCAD

def resistor(x)
  km=10
  kistr="$Comp\n"
  kistr << 'L '+ 'R' +' '+x[1]+"\n"
  kistr << "U 1 1 4E44605E\n" # What is the time stamp and how to generit while trying to put the same ... nobody complains
  kistr << 'P '+x[3]+'0 '+x[4]+"0\n" #simply add zeros ... yet
  kistr << 'F 0 "'+x[1]+'" V '+str(int(x[3])*km+80)+' '+str(int(x[4])*km)+" 50  0000 C CNN\n"
  kistr << 'F 1 '+x[9]+' '+x[10]+' V '+str(int(x[3])*km)+' '+str(int(x[4])*km)+" 50  0000 C CNN\n"
  kistr << "\t1    "+str(int(x[3])*km)+' '+str(int(x[4])*km)+"\n"
  if x[8]=='1'
    kistr << "\t"+"1    0    0    -1   \n" #is the rotations and reflections
  elsif x[8]=='2'
      kistr << "\t"+"0    -1   -1   0   \n" #is the rotations and reflections
  elsif x[8]=='3'
      kistr << "\t"+"-1   0    0    1   \n" #is the rotations and reflections
  else
    kistr << "\t"+"0    1    1    0   \n" #is the rotations and reflections
  end
  kistr << "$EndComp\n"
end

def capsicator(x)
  km=10
  kistr="$Comp\n"
  kistr << 'L '
  if x[14]=='"neutral"'
    kistr << 'C' +' '+x[1]+"\n"
  else
    kistr << 'CP1' +' '+x[1]+"\n"
    
    kistr << "U 1 1 4E44605E\n" # What is the time stamp and how to generit while trying to put the same ... nobody complains
    kistr << 'P '+x[3]+'0 '+x[4]+"0\n" #easy way * 10
    kistr << 'F 0 "'+x[1]+'" V '+str(int(x[3])*km+50)+' '+str(int(x[4])*km+100)+" 50  0000 C CNN\n"
    kistr << 'F 1 '+x[9]+' '+x[10]+' V '+str(int(x[3])*km+50)+' '+str(int(x[4])*km-100)+" 50  0000 C CNN\n"
    kistr << "\t1    "+str(int(x[3])*km)+' '+str(int(x[4])*km)+"\n"
    if x[8]=='1'
      kistr << "\t"+"1    0    0    1   \n" #is the rotations and reflections
    elsif x[8]=='2'
      kistr << "\t"+"0    1   -1   0   \n" #is the rotations and reflections
    elsif x[8]=='3'
      kistr << "\t"+"-1   0    0    -1   \n" #is the rotations and reflections
    else 
      kistr << "\t"+"0    -1    1    0   \n" #is the rotations and reflections
    end
  end
  kistr << "$EndComp\n"
end

def inductance(x)
  km=10
  kistr="$Comp\n"
  kistr << 'L '+ 'INDUCTOR' +' '+x[1]+"\n"
  kistr << "U 1 1 4E44605E\n" #What is the time stamp and how to generit while trying to put the same ... nobody complains
  kistr << 'P '+x[3]+'0 '+x[4]+"0\n" #simply add zeros ... yet
  kistr << 'F 0 "'+x[1]+'" V '+str(int(x[3])*km-50)+' '+str(int(x[4])*km)+" 40  0000 C CNN\n"
  kistr << 'F 1 '+x[9]+' '+x[10]+' V '+str(int(x[3])*km+100)+' '+str(int(x[4])*km)+" 40  0000 C CNN\n"
  kistr << "\t1    "+str(int(x[3])*km)+' '+str(int(x[4])*km)+"\n"
  if x[8]=='1'
    kistr << "\t"+"1    0    0    -1   \n" #is the rotations and reflections
  elsif x[8]=='2'
    kistr << "\t"+"0    -1   -1   0   \n" #is the rotations and reflections
  elsif x[8]=='3'
    kistr << "\t"+"-1   0    0    1   \n" #is the rotations and reflections
  else 
    kistr << "\t"+"0    1    1    0   \n" #is the rotations and reflections
  end
  kistr << "$EndComp\n"
end


def diode(x)
  km=10
  kistr="$Comp\n"
  kistr << 'L '
  if x[-2]=='"Zener"'
    kistr << 'DIODE' +' '+x[1]+"\n"
  elsif x[-2]=='"Schottky"'
    kistr << 'DIODESCH' +' '+x[1]+"\n"
    #	elif x[-2]=='"Varactor"':
    #		kistr << 'VARICAP' +' '+x[1]+'\n'
  else
    kistr << 'DIODE' +' '+x[1]+"\n"
  end
  kistr << "U 1 1 4E44605E\n" #What is the time stamp and how to generit while trying to put the same ... nobody complains
  kistr << 'P '+x[3]+'0 '+x[4]+"0\n" #simply add zeros ... yet
  kistr << 'F 0 "'+x[1]+'" H '+str(int(x[3])*km)+' '+str(int(x[4])*km+100)+" 40  0000 C CNN\n" 
  kistr << 'F 1 '+x[-2]+' H '+str(int(x[3])*km)+' '+str(int(x[4])*km-100)+" 40  0000 C CNN\n" #here is nothing to write
  kistr << "\t1    "+str(int(x[3])*km)+' '+str(int(x[4])*km)+"\n"
  if x[8]=='1'
    kistr << "\t"+"0    1    1    0   \n" #is the rotations and reflections
  elsif x[8]=='2'
    kistr << "\t"+"1    0    0    -1   \n" #is the rotations and reflections
  elsif x[8]=='3'
    kistr << "\t"+"0    -1   -1   0   \n" #is the rotations and reflections
  else
    kistr << "\t"+"-1   0    0    1   \n" #is the rotations and reflections
  end
  kistr << "$EndComp\n"
end

def transistor(x)
  km=10
  kistr="$Comp\n"
  kistr << 'L '
  if x[9]=='"npn"'
    kistr << 'NPN' +' '+'Q'+x[1][1..0]+"\n"
  else
    kistr << 'PNP' +' '+'Q'+x[1][1..0]+"\n"
    if x[8]=='0'
      x0=str(int(x[3])*km-100)
      y0=str(int(x[4])*km)
    elsif x[8]=='1'
      x0=str(int(x[3])*km)
      y0=str(int(x[4])*km+100)
    elsif x[8]=='2'
      x0=str(int(x[3])*km+100)
      y0=str(int(x[4])*km)
    else
      x0=str(int(x[3])*km)
      y0=str(int(x[4])*km-100)
    end
    kistr << "U 1 1 4E44605E\n" #What is the time stamp and how to generit while trying to put the same ... nobody complains
    kistr << 'P '+x[3]+'0 '+x[4]+"0\n" #simply add zeros ... yet
    kistr << 'F 0 "'+'Q'+x[1][1..0]+'" H '+x0+' '+str(int(y0)-150)+" 50  0000 R CNN\n" 
    kistr << 'F 1 '+x[9]+' H '+x0+' '+str(int(y0)+150)+" 50  0000 R CNN\n" 
    kistr << "\t1    "+x0+' '+y0+"\n"
    if x[8]=='1'
      kistr << "\t"+"0    -1    -1    0   \n" #is the rotations and reflections
    elsif x[8]=='2'
      kistr << "\t"+"-1    0    0    1   \n" #is the rotations and reflections
    elsif x[8]=='3'
      kistr << "\t"+"0    1   1   0   \n" #is the rotations and reflections
    else 
      kistr << "\t"+"1   0    0    -1   \n" #is the rotations and reflections
    end
  end
  kistr << "$EndComp\n"
end

def gnd(x)
  km=10
  kistr="$Comp\n"
  kistr << 'L '+ 'GND' +' '+'PWR?'+"\n"
  kistr << "U 1 1 4E44605E\n" #What is the time stamp and how to generit while trying to put the same ... nobody complains
  kistr << 'P '+x[3]+'0 '+x[4]+"0\n" #simply add zeros ... yes
  kistr << 'F 0 "'+'"#PWR?"'+' H '+str(int(x[3])*km)+' '+str(int(x[4])*km)+" 30  0000 C CNN\n"
  kistr << 'F 1 '+'"GND"'+' H '+str(int(x[3])*km)+' '+str(int(x[4])*km-70)+" 30  0000 C CNN\n"
  kistr << "\t1    "+str(int(x[3])*km)+' '+str(int(x[4])*km)+"\n"
  if x[8]=='1'
      kistr << "\t"+"0    -1    -1    0   \n" #is the rotations and reflections
  elsif x[8]=='2'
    kistr << "\t"+"-1    0    0    1   \n" #is the rotations and reflections
  elsif x[8]=='3'
    kistr << "\t"+"0    1   1   0   \n" #is the rotations and reflections
  else 
    kistr << "\t"+"1   0    0    -1   \n" #is the rotations and reflections
  end
  kistr << "$EndComp\n"
end
    
