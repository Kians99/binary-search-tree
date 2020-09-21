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

  def delete(number)
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
end


tree = BST.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.to_s
puts ''
tree.to_s
#tree2 = BST.new([1,2,3,4,5])
#tree2.to_s




