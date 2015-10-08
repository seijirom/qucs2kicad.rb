# -*- coding: utf-8 -*-
##!/usr/bin/python
# -*- coding: UTF-8 -*-
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.

#Function to reduce the number of conductors when converting file formats

def shifl (wire,n,wirs)
#  puts "shifl called w/ wire=#{wire.inspect}, n=#{n.inspect}, wirs=#{wirs.inspect}"
  #out=[]
  chng=0
  pnt=wire[n]
  rang=0
  conn=0
  #~ print "########################################"
  #~ print "wire"
  #~ print wire
  #~ print "point"
  #~ print wire(n)
  #~ print "wires"
  #~ print wirs
  for j in wirs do
    if (pnt==j[0]) or (pnt==j[1])
      #~ rang=rang+1
      if (j[0][0]==wire[1][0] and j[0][0]==wire[0][0] and j[1][0]==wire[0][0] and j[1][0]==wire[1][0]) or (j[0][1]==wire[1][1] and j[0][1]==wire[0][1] and j[1][1]==wire[0][1] and j[1][1]==wire[1][1])and (chng==0)
        if wire[1]==j[1]
          wire=[wire[0],j[0]]
        elsif wire[1]==j[0]
          wire=[wire[0],j[1]]
        elsif wire[0]==j[1]
          wire=[wire[1],j[0]]
        elsif wire[0]==j[0]
          wire=[wire[1],j[1]]
        end
#        puts "** wirs=#{wirs.inspect}, j=#{j.inspect}"
        wirs.delete(j)
        chng=1
      end
    end
  end
  #out.push(chng)
  #out.push(wire)
  #out.push(wirs)
  #out
  [chng, wire, wirs]
end

# 271.9 MB 79.7
# take the first conductor of the first point to watch the rest of the conductors using the counter matches
# If there is no match or we --UGOL situation, then we do not do anything in the case --PRYAMOY produce modification
# Explorer and counts the remaining conductors if tee or chetvernik dobavlyaetsya record connection ~
# further if the union was made to start with a new conductor of the combined points
# if there were no other organizations that check point of the conductor.

def len s
  s.length
end

def wirecomp(address_file_wire)
  wirefile=address_file_wire
  outfile=address_file_wire
  f=File.open(wirefile,'r')
  aa=[]
  while not f.eof? and ss=f.readline()
#    puts ss.inspect
    s=ss.strip
    coord=s.split
    if coord!=['Wire', 'Wire', 'Line']
      aa.push([coord[0..2-1],coord[2..-1]])
    end
  end
  f.close()
  print "###############################################################\n"
  pts=[]
  cc=[]
  for i in aa
    cc.push(i[0])
    cc.push(i[1])
  end
  for i in cc
    a=cc.count(i)
    if a>2
      pts.push(i) # count the number of nodes
    end
#    for j in range(a)
    for j in 0..a-1
      cc.delete(i)
    end
  end
#  puts "aa=#{aa.inspect}"
  a=0
  while a < len(aa)-1
    ind=0
    i=aa[a] # i is wire
    while(ind!=2)
      # p=i[ind] # not used
      #        ost=aa[:a]
      if a==0 # note: aa[:a] in python is not aa[0..a-1] in ruby when a==0 
        ost=[]
      else
        ost=aa[0..a-1]
      end
      #      cc=shifl(i,ind,aa[(a+1)..-1]) # note this cc is different from the above cc 
      #      if cc[0]==0
      #        ind=ind+1
      #      i=cc[1]
      #      ost.push(cc[1])
      #      end
      #      ost=ost+cc[2]
      chng, wire, wirs = shifl(i,ind,aa[(a+1)..-1])
      if chng == 0
        ind = ind + 1
      end
      i=wire
      ost.push wire
      ost = ost + wirs
      aa=ost
#      puts "> a=#{a} ind=#{ind} aa=#{aa.inspect}"
    end
    a=a+1
  end
    
  #this piece writes the converted information
  out=File.open(outfile,'w')
  print "Number wires ",len(aa)," Node number " ,len(pts), "\n" 
  for i in aa
    out.write("Wire Wire Line\n")
    # str="\t"+i[0][0]+" "+i[0][1]+" "+i[1][0]+" "+i[1][1]+"\n"
    str="\t#{i[0][0]} #{i[0][1]} #{i[1][0]} #{i[1][1]}\n"
    out.write(str)
  end
  for i in pts
    # str="Connection ~ "+i[0]+" "+i[1]+"\n"
    str="Connection ~ #{i[0]} #{i[1]}\n"
    out.write(str)
  end
  out.close()
  
  print "######################################################"
  puts aa.inspect
end
