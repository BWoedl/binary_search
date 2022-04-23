require_relative 'node'

class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = array.sort.uniq!
    @root = build_tree(@array)
  end

  def build_tree(array)
    return if array.nil? || array.empty?

    mid = array.length / 2
    root = Node.new(array[mid])
    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[(mid + 1)..array.length])
    root
  end

  def find(root_node, value)
    return root_node if root_node.nil? || root_node.data == value
    return find(root_node.right, value) if root_node.data < value
    return find(root_node.left, value) if root_node.data > value
  end

  def insert(root_node, value)
    return root_node if root_node.nil? || root_node.data == value

    if root_node.data > value
      root_node.left.nil? ? root_node.left = Node.new(value) : insert(root_node.left, value)
    elsif root_node.data < value
      root_node.right.nil? ? root_node.right = Node.new(value) : insert(root_node.right, value)
    end
  end

  def delete(root_node, value)
    return root_node if root_node.nil?

    if root_node.data > value
      root_node.left = delete(root_node.left, value)
    elsif root_node.data < value
      root_node.right = delete(root_node.right, value)
    else
      if root_node.left.nil?
        return root_node.right
      elsif root_node.right.nil?
        return root_node.left
      end

      root_node.data = min_value(root_node.right)
      root_node.right = delete(root_node.right, root_node.data)
    end
    root_node
  end

  def min_value(root_node)
    min = root_node.data
    until root_node.left.nil?
      min = root_node.left.data
      root_node = root_node.left
    end
    min
  end

  def level_order(root_node = root, queue = [])
    queue << root_node.left unless root_node.left.nil?
    queue << root_node.right unless root_node.right.nil?
    return if queue.empty?

    level_order(queue.shift, queue)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

p tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# p two_tree = Tree.new([1, 7, 3])
# p tree.root
# p tree.search(tree.root, 3)
# p tree.search(tree.root, 6)
# p tree.search(tree.root, 4)
# tree.insert(tree.root, 6)
# tree.insert(tree.root, 5)
# # # p tree.root
# # p tree.find(tree.root, 7)
# # p "new line"
# tree.pretty_print
# # tree.delete(tree.root, 9)
# tree.delete(tree.root, 67)
# p "new line"
# p tree.find(tree.root, 7)
tree.level_order
tree.pretty_print
# two_tree.pretty_print
#  { |root_node| print "#{root_node.data} | " }
