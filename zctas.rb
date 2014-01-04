def new_poly(id, points)
  
  p = {:id => id, :sides => []}
  p1 = false
  fp = false
  points.each do |lat, lon|
    p2 = [lat, lon]
    if (p1)
      p[:sides].push([p2, p1])
    else
      fp = p2
    end
    p1 = p2
  end
  p
end

def awk(line)
  line.gsub(/\s/m, ' ').strip.split(' ')
end

def read_polys(fn)
  polys = []
  cur_id = 0
  cur_coords = []
  File.open(fn).read.each_line do |line|
    flds = awk line
    if (flds.length == 3)
      cur_id = flds[0].to_i
      cur_coords.push([flds[1].to_f, flds[2].to_f])
    elsif (flds.length == 1 && flds[0] == "END")
      polys[cur_id] = new_poly(cur_id, cur_coords)
      cur_coords = []
    else
      cur_coords.push([flds[0].to_f, flds[1].to_f])
    end
  end
  polys.select {|i| i}
end

zctas = {}

def name_polys(fn, polys, zctas)
  lln = ""
  id = 0
  File.open(fn).read.each_line do |line|
    print "\n'"+line+"'"
    line = line.strip
    if (line.length > 0 && line != lln && line != "\"Z5\"" && line != "\"5-Digit ZCTA\"" && line[0] )
      if (line[0] != '"' && line.to_i > 0)
        id = line.to_i
        print "\nid:"+id.to_s
      elsif line[0] == '"'
        eved = eval(line)
        print "evaled "+eved.to_s
        if (eved.length == 5)
          zctas[eved] = polys[id]
        end
      end
      lln = line
    end
  end
end

def read_one(prefix, zctas) 
  l = zctas.length
  name_polys(prefix+"a.dat", read_polys(prefix+".dat"), zctas)
  zctas.length - l
end

def read_coords(domain)
  File.open("../"+domain+"/coords").read.each_line do |line|
    coords = line.strip.split(" , ").map {|s| s.to_f}
    print coords.to_s
  end
end    

read_one("z302_d00", zctas)

read_one("z304_d00")
read_one("z305_d00")

read_one("z306_d00")
read_one("z308_d00")
read_one("z309_d00")

read_one("z310_d00")
read_one("z311_d00")

read_one("z312_d00")
read_one("z313_d00")
read_one("z315_d00")

read_one("z316_d00")
read_one("z317_d00")

read_one("z318_d00")
read_one("z319_d00")
read_one("z320_d00")

read_one("z321_d00")
read_one("z322_d00")

read_one("z323_d00")
read_one("z324_d00")
read_one("z325_d00")

read_one("z326_d00")
read_one("z327_d00")

read_one("z328_d00")
read_one("z329_d00")
read_one("z330_d00")
read_one("z331_d00")
read_one("z332_d00")

read_one("z333_d00")
read_one("z334_d00")
read_one("z335_d00")

read_one("z336_d00")
read_one("z337_d00")

read_one("z338_d00")
read_one("z339_d00")
read_one("z340_d00")

read_one("z341_d00")
read_one("z342_d00")

read_one("z344_d00")
read_one("z345_d00")
read_one("z346_d00")

read_one("z347_d00")
read_one("z348_d00")

read_one("z349_d00")
read_one("z350_d00")
read_one("z351_d00")

read_one("z353_d00")
read_one("z354_d00")

read_one("z355_d00")
read_one("z356_d00")
read_one("z372_d00")

read_one("z302_d00")

read_one("z304_d00")
read_one("z305_d00")

read_one("z306_d00")
read_one("z308_d00")
read_one("z309_d00")

read_one("z310_d00")
read_one("z311_d00")

read_one("z312_d00")
read_one("z313_d00")
read_one("z315_d00")

read_one("z316_d00")
read_one("z317_d00")

read_one("z318_d00")
read_one("z319_d00")
read_one("z320_d00")

read_one("z321_d00")
read_one("z322_d00")

read_one("z323_d00")
read_one("z324_d00")
read_one("z325_d00")

read_one("z326_d00")
read_one("z327_d00")

read_one("z328_d00")
read_one("z329_d00")
read_one("z330_d00")

read_one("z331_d00")
read_one("z332_d00")

read_one("z333_d00")
read_one("z334_d00")
read_one("z335_d00")

read_one("z336_d00")
read_one("z337_d00")

read_one("z338_d00")
read_one("z339_d00")
read_one("z340_d00")

read_one("z341_d00")
read_one("z342_d00")

read_one("z344_d00")
read_one("z345_d00")
read_one("z346_d00")

read_one("z347_d00")
read_one("z348_d00")

read_one("z349_d00")
read_one("z350_d00")
read_one("z351_d00")

read_one("z353_d00")
read_one("z354_d00")

read_one("z355_d00")
read_one("z356_d00")
read_one("z372_d00")


File.open(yourfile, 'zctas.yaml') { |file| file.write(zctas.to_yaml) }

def pip(p, poly) 
  x = p[0]
  y = p[1]
  oddNodes=false;
  poly[:sides].each do |side|
    if ((side[0][1] < y && side[1][1] >=y ||
         side[1][1] < y && side[0][1] >= y) &&
        (side[0][0] <= x || side[1][0] <=x)) then
      oddNodes ^= (side[0][0] + (y-side[0][1]) / 
                   (side[1][1] - side[0][1]) * 
                   (side[1][0] - side[0][0]) < x)
    end
  end
  oddNodes
end
