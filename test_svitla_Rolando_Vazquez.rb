load 'lib/RectangleOverlap.rb'

class Coordinate
    attr_accessor :x, :y

    def initialize x = 0 , y = 0
        throw "Invalid coordinates point" if !x.is_a?(Integer) || !y.is_a?(Integer)
        @x, @y = x, y
    end

    def get_points
        [x, y]
    end
end

class Rectangle
    attr_accessor :point_one, :point_two

    def initialize point_one, point_two
        validate_point point_one
        validate_point point_two
        @point_one, @point_two = Coordinate.new(*point_one), Coordinate.new(*point_two)
    end

    def get_points()
        [point_one.get_points, point_two.get_points]
    end

    def overlap_with_rec other_rec
        throw "Expected a Rectangle instance" unless other_rec.is_a?(Rectangle)
        overlap *(self.get_points + other_rec.get_points)
    end

    private

        def validate_point(point)
            throw "Expected to recive an array with 2 elements" if !point.is_a?(Array) || !point.size == 2            
        end

    
end

#Potenial usage. For instance in an app for interior design to check if a selected area is overlaping with other area already selected
building_section1 = Rectangle.new [10,10],  [20,5]
building_section2 = Rectangle.new [5,8],    [21,4]
building_section1.overlap_with_rec building_section2

rec1 = Rectangle.new [1,5],    [8,1]
rec2 = Rectangle.new [8,9],    [15,5]
rec3 = Rectangle.new [3,12],   [13,6]
rec4 = Rectangle.new [4,11],   [12,7]
rec5 = Rectangle.new [5,9],    [12,5]
rec6 = Rectangle.new [9,15],   [15,10]

alias :p :puts

p rec1.overlap_with_rec rec2
p rec1.overlap_with_rec rec4
p rec6.overlap_with_rec rec3

#Sets of rectangles points to test diferent overlaping scenarios
scenario1 = Rectangle.new([5,15], [9,4]).get_points + Rectangle.new([7,11],[17,6]).get_points
scenario2 = Rectangle.new([7,11], [17,6]).get_points + Rectangle.new([5,15],[9,4]).get_points
scenario3 = Rectangle.new([1,9],  [7,4]).get_points + Rectangle.new([12,16],[17,6]).get_points
scenario4 = Rectangle.new([12,16],[17,6]).get_points + Rectangle.new([1,9],[7,4]).get_points
scenario5 = Rectangle.new([1,5],[8,1]).get_points + Rectangle.new([8,9],[15,5]).get_points
scenario6 = Rectangle.new([8,9],[15,5]).get_points + Rectangle.new([1,5],[8,1]).get_points
scenario7 = Rectangle.new([3,12],[13,6]).get_points + Rectangle.new([4,11],[12,7]).get_points
scenario8 = Rectangle.new([4,11],[12,7]).get_points + Rectangle.new([3,12],[13,6]).get_points
scenario9 = Rectangle.new([5,9],[12,5]).get_points + Rectangle.new([9,15],[15,10]).get_points
scenario10 = Rectangle.new([9,15],[15,10]).get_points + Rectangle.new([5,9],[12,5]).get_points
scenario11= Rectangle.new([10,10],[20,5]).get_points + Rectangle.new([5,8],[21,4]).get_points
scenario12 = Rectangle.new([5,8],[21,4]).get_points + Rectangle.new([10,10],[20,5]).get_points

if overlap(*scenario1) == true &&
    overlap(*scenario2) == true && 
    overlap(*scenario3) == false && 
    overlap(*scenario4) == false && 
    overlap(*scenario5) == true && 
    overlap(*scenario6) == true && 
    overlap(*scenario7) == true && 
    overlap(*scenario8) == true && 
    overlap(*scenario9) == false && 
    overlap(*scenario10) == false &&
    overlap(*scenario11) == true && 
    overlap(*scenario12) == true
      puts "\nCorrect" 
    else
      puts "\nIncorrect"
    end