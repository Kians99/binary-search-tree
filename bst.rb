require_relative 'node'

class BST


  attr_accessor :root

  def initialize
    @root = nil
  end

  def build_tree(array)
    return if array.nil? || !array.instance_of?(Array)
    return root = Node.new(nil,array[0],nil) if array.length == 1
    array.sort!
    uniq_arr = array.uniq
    return binary_search(array)
  end

  def to_s(node = @root, prefix = '', is_left = true)
    pretty_print(node.r_tree, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.r_tree
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.l_tree, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.l_tree
  end

  private

  def binary_search(array, min = 0, max = array.length - 1, mid = (min + max)/2)
    if min > max
      nil
    else
      Node.new(binary_search(array, min, mid-1),array[mid],binary_search(array,mid+1,max))
    end
  end

end


array = [1,2,3,4,5,6]
tree = BST.new
tree.build_tree(array)
tree.to_s




