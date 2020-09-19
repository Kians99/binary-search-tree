class BST

  def initialize
    @root = nil
  end

  def build_tree(array)
    return if array.nil? || !array.instance_of(Array)
    array.sort!
    array.uniq!

  end

  private


end




