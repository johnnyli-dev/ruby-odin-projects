def bubble_sort(sort, previous = 0)
    previous_item = 0
    new_array = sort
    sort.each_with_index do|item, position|
        if item < previous_item
            new_array[position-1], new_array[position] = new_array[position], new_array[position-1]
            bubble_sort(new_array)
        end
        previous_item = item
    end
    new_array
end

p bubble_sort([1,1,1,1,234,4,4,4,42,3,42,6,61,43,3,3])