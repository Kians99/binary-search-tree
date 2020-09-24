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
    arr_val
  end

  def level_order_recurs(queue = [root], arr_val = [])
    return arr_val if queue == []

    cur_node = queue.pop
    arr_val.push(cur_node.value)
    queue.unshift(cur_node.l_tree) unless cur_node.l_tree.nil?
    queue.unshift(cur_node.r_tree) unless cur_node.r_tree.nil?
    level_order_recurs(queue, arr_val)
  end

  def inorder(tree = root, arr_values = [])
    return arr_values if tree.nil?

    inorder(tree.l_tree, arr_values)
    arr_values.push(tree.value)
    inorder(tree.r_tree, arr_values)
  end

  def preorder(tree = root, arr_values = [])
    return arr_values if tree.nil?

    arr_values.push(tree.value)
    preorder(tree.l_tree, arr_values)
    preorder(tree.r_tree, arr_values)
  end

  def postorder(tree = root, arr_values = [])
    return arr_values if tree.nil?

    postorder(tree.l_tree, arr_values)
    postorder(tree.r_tree, arr_values)
    arr_values.push(tree.value)
  end

  def height(tree = root)
    return -1 if tree.nil?

    left_height = height(tree.l_tree) 
    right_height = height(tree.r_tree) 

    [left_height, right_height].max + 1
  end

  def depth(inp_node, tree = root)
    return 0 if inp_node.value == tree.value

    if inp_node.value > tree.value
      depth(inp_node, tree.r_tree) + 1
    else
      depth(inp_node, tree.l_tree) + 1
    end
  end

  def balanced?(tree = root)
    ((height(tree.l_tree) - height(tree.r_tree)).abs <= 1)
  end

  def rebalance(tree = root)
    array_of_values = self.level_order(tree)
    self.root = build_tree(array_of_values)
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
    else
      if tree.r_tree.r_tree.l_tree.nil?
        tree.r_tree.r_tree.l_tree = tree.r_tree.l_tree
        tree.r_tree = tree.r_tree.r_tree
      else
        replacement = left_most(tree.r_tree.r_tree)
        replacement.r_tree = tree.r_tree.r_tree
        replacement.l_tree = tree.r_tree.l_tree
        tree.r_tree = replacement
      end
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
    else
      if tree.l_tree.r_tree.l_tree.nil?
        tree.l_tree.r_tree.l_tree = tree.l_tree.l_tree
        tree.l_tree = tree.l_tree.r_tree
      else
        replacement = left_most(tree.l_tree.r_tree)
        replacement.r_tree = tree.l_tree.r_tree
        replacement.l_tree = tree.l_tree.l_tree
        tree.l_tree = replacement

      end
    end
  end

  def left_most(node)
    if node.l_tree.l_tree.nil?
      store_node = node.l_tree
      node.l_tree = nil
      return store_node
    else
      left_most(node.l_tree)
    end
  end

  def type_of_node(tree)
    return 0 if tree.node_leaf?
    return 1 if tree.l_tree.nil? && !tree.r_tree.nil?
    return 2 if !tree.l_tree.nil? && tree.r_tree.nil?
    return 3 if !tree.l_tree.nil? && !tree.r_tree.nil?
  end
end


bst = BST.new(Array.new(15) { rand(1..100) })
puts ''
bst.to_s
puts ''
puts 'Is tree Balanced?'
bst.balanced? ? (puts 'True') : (puts 'False')
puts ''
puts 'Level Order Traversal:'
p bst.level_order
puts ''
puts 'Preorder Traversal:'
p bst.preorder
puts ''
puts 'Postorder Traversal:'
p bst.postorder
puts ''
puts 'Inorder Traversal:'
p bst.inorder
puts ''
puts 'Unbalance Tree:'
puts ''
bst.insert(101)
bst.insert(102)
bst.insert(103)
bst.insert(104)
bst.to_s
puts ''
puts 'Is tree Balanced?'
bst.balanced? ? (puts 'True') : (puts 'False')
puts ''
puts 'Rebalance Tree:'
puts ''
bst.rebalance
bst.to_s
puts ''
puts 'Is tree Balanced?'
bst.balanced? ? (puts 'True') : (puts 'False')
puts ''
puts ''
puts 'Level Order Traversal:'
p bst.level_order
puts ''
puts 'Preorder Traversal:'
p bst.preorder
puts ''
puts 'Postorder Traversal:'
p bst.postorder
puts ''
puts 'Inorder Traversal:'
p bst.inorder
puts ''

















