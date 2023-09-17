require 'date'
class Heartland
  def solution(s)
    #array to store photos and photo number
    photos = Array[]

    #string to return final answer
    sorted_photos = ""

    #append input with new line for parsing purposes
    s = s + "\n"

    #loop through string to generate array of objects with {location, date_time, file_type}
    while s.include?("\n")
      new_line_index = s.index("\n")
      photo = s[0..new_line_index]
      location = photo[photo.index(" ")+1..photo.index(",", photo.index(" "))-1]
      date_time = DateTime.parse(photo[photo.index(" ", photo.index(" ")+1)+1..-2])
      file_type = photo[photo.index(".")..photo.index(",")-1]
      photos.push({locations: location, date_times: date_time, file_types: file_type})
      s = s[new_line_index+1..-1]
    end

    #find which number each photo should be
    photos.each { |element|
      location = element[:locations]
      place = 1
      count = 1
      photos.each { |element2|
        location2 = element2[:locations]
        if location2==location
          #compare date/times
          count+=1
          if element[:date_times] > element2[:date_times]
            place+=1
          end
        end
      }
      if count >= 10 && place < 10
        sorted_photos+=element[:locations] + "0" + place.to_s + element[:file_types] + "\n"
      else
        sorted_photos+=element[:locations] + place.to_s + element[:file_types] + "\n"
      end
    }
    #return answer without ending new_line
    sorted_photos[0..-2]
  end
end

heartland_instance = Heartland.new
input =
  "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"

expected_result =
  "Krakow02.jpg
London1.png
Krakow01.png
Florianopolis2.jpg
Florianopolis1.jpg
London2.jpg
Florianopolis3.png
Krakow03.jpg
Krakow09.png
Krakow07.jpg
Krakow06.jpg
Krakow08.jpg
Krakow04.png
Krakow05.png
Krakow10.jpg"


result = heartland_instance.solution(input)
puts result

if result == expected_result
  puts "\nTest Case Passed"
end
