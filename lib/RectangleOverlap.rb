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


private

    def overlap_in_Y?(yMin, yMax, rec2_coor1, rec2_coor2)
        return true if (rec2_coor1[1] >= yMin && rec2_coor1[1] <= yMax) || (rec2_coor2[1] >= yMin && rec2_coor2[1] <= yMax)
        false
    end

    def overlap_in_X?(xMin, xMax, rec2_coor1, rec2_coor2)
        return true if (rec2_coor1[0] >= xMin && rec2_coor1[0] <= xMax) || (rec2_coor2[0] >= xMin && rec2_coor2[0] <= xMax)
        false
    end
