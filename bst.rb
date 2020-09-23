require_relative 'node'

class BST

  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def to_s(node = @root, prefix = '', is_left = true)
    return "root node is nil" if node.nil?

    to_s(node.r_tree, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.r_tree
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    to_s(node.l_tree, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.l_tree
  end

  def insert(number, tree=root)
    return puts 'Value already exists in tree' if tree.value == number

    if number > tree.value
      if tree.r_tree.nil?
        tree.r_tree = Node.new(nil, number, nil)
        number
      else
        insert(number, tree.r_tree)
      end
    elsif number < tree.value
      if tree.l_tree.nil?
        tree.l_tree = Node.new(nil, number, nil)
        return number
      else
        insert(number, tree.l_tree)
      end
    end
  end

  def delete(number, tree=root)
    #TWO CHILDREN NOT YET IMPLEMENTED
    if number > tree.value
      if tree.r_tree.value == number
        set_new_values_right(tree)
        number
      else
        delete(number, tree.r_tree)
      end
    elsif number < tree.value
      if tree.l_tree.value == number
        set_new_values_left(tree)
      else
        delete(number, tree.l_tree)
        number
      end
    end
  end

  def find(value, tree = root)
    return puts 'Value is not in tree' if tree.nil?

    if value == tree.value
      tree
    elsif value > tree.value
      find(value, tree.r_tree)
    else
      find(value, tree.l_tree)
    end
  end

  def level_order(tree = root, queue = [tree], arr_val = [])
    until queue == []
      cur_node = queue.pop
      arr_val.push(cur_node.value)
      queue.unshift(cur_node.l_tree) unless cur_node.l_tree.nil?
      queue.unshift(cur_node.r_tree) unless cur_node.r_tree.nil?
    end
    return arr_val
  end

  private

  def build_tree(array)
    return puts 'Did not enter an array' if array.nil? || !array.instance_of?(Array)

    Node.new(nil, array[0], nil) if array.length == 1
    array.sort!
    binary_search(array.uniq)
  end

  def binary_search(array, min = 0, max = array.length - 1, mid = (min + max)/2)
    min > max ? nil : Node.new(binary_search(array, min, mid - 1), array[mid], binary_search(array, mid + 1, max))
  end

  def set_new_values_right(tree)
    type = type_of_node(tree.r_tree) 
    if type.zero? 
      tree.r_tree = nil
    elsif type == 1
      tree.r_tree = tree.r_tree.r_tree
    elsif type == 2
      tree.r_tree = tree.r_tree.l_tree
    end
  end

  def set_new_values_left(tree)
    type = type_of_node(tree.l_tree) 
    if type.zero? 
      tree.l_tree = nil
    elsif type == 1
      tree.l_tree = tree.l_tree.r_tree
    elsif type == 2
      tree.r_tree = tree.l_tree.l_tree
    end
  end

  def type_of_node(tree)
    return 0 if tree.node_leaf?
    return 1 if tree.l_tree.nil? && !tree.r_tree.nil?
    return 2 if !tree.l_tree.nil? && tree.r_tree.nil?
    #return 3 if two_child(tree)
  end

end


tree = BST.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.to_s
arr = tree.level_order
puts ""
p arr



#p node
#tree2 = BST.new([1,2,3,4,5])
#tree2.to_s




