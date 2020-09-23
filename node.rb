class Node

  include Comparable

  attr_accessor :l_tree, :value, :r_tree

  def initialize(l_tree, value, r_tree)
    @l_tree = l_tree
    @value = value
    @r_tree = r_tree
  end

  def <=>(other_node)
    self.value <=> other_node.value
  end

  def node_leaf?
    l_tree.nil? && r_tree.nil?
  end
end
