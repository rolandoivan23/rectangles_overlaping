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

#TODO: puts the overlaping logic inside a module or class 
def overlap(coordinate1_rec1, coordinate2_rec1, coordinate1_rec2, coordinate2_rec2)
    rec1_X_axis = [coordinate1_rec1[0], coordinate2_rec1[0]]
    rec1_Y_axis = [coordinate1_rec1[1], coordinate2_rec1[1]]
    rec2_X_axis = [coordinate1_rec2[0], coordinate2_rec2[0]]
    rec2_Y_axis = [coordinate1_rec2[1], coordinate2_rec2[1]]

    #Getting mins and maxs of rectangle 1
    r1_X_min = rec1_X_axis.min
    r1_X_max = rec1_X_axis.max
    r1_Y_min = rec1_Y_axis.min
    r1_Y_max = rec1_Y_axis.max
    
    #Getting mins and maxs of rectangle 2
    r2_X_min = rec2_X_axis.min
    r2_X_max = rec2_X_axis.max
    r2_Y_min = rec2_Y_axis.min
    r2_Y_max = rec2_Y_axis.max

    rec1_overlap_with_rec2 = overlap_in_X?(r1_X_min, r1_X_max, coordinate1_rec2, coordinate2_rec2) && overlap_in_Y?(r1_Y_min, r1_Y_max, coordinate1_rec2, coordinate2_rec2)
    rec2_overlap_with_rec1 = overlap_in_X?(r2_X_min, r2_X_max, coordinate1_rec1, coordinate2_rec1) && overlap_in_Y?(r2_Y_min, r2_Y_max, coordinate1_rec1, coordinate2_rec1)
    
    return true if rec1_overlap_with_rec2 || rec2_overlap_with_rec1
    false
end


def overlap_in_Y?(yMin, yMax, rec2_coor1, rec2_coor2)
    return true if (rec2_coor1[1] >= yMin && rec2_coor1[1] <= yMax) || (rec2_coor2[1] >= yMin && rec2_coor2[1] <= yMax)
    false
end

def overlap_in_X?(xMin, xMax, rec2_coor1, rec2_coor2)
    return true if (rec2_coor1[0] >= xMin && rec2_coor1[0] <= xMax) || (rec2_coor2[0] >= xMin && rec2_coor2[0] <= xMax)
    false
end
