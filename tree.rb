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
    node = Node.new(array[mid])
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[(mid + 1)..array.length])
    node
  end

  def find(node, value)
    return node if node.nil? || node.data == value
    return find(node.right, value) if node.data < value
    return find(node.left, value) if node.data > value
  end

  def insert(node, value)
    return node if node.nil? || node.data == value

    if node.data > value
      node.left.nil? ? node.left = Node.new(value) : insert(node.left, value)
    elsif node.data < value
      node.right.nil? ? node.right = Node.new(value) : insert(node.right, value)
    end
  end

  def delete(node, value)
    return node if node.nil?

    if node.data > value
      node.left = delete(node.left, value)
    elsif node.data < value
      node.right = delete(node.right, value)
    else
      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      end

      node.data = min_value(node.right)
      node.right = delete(node.right, node.data)
    end
    node
  end

  def min_value(node)
    min = node.data
    until node.left.nil?
      min = node.left.data
      node = node.left
    end
    min
  end

  def level_order_recursive(node = root, queue = [], &block)
    yield node
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    return if queue.empty?

    level_order_recursive(queue.shift, queue, &block)
  end

  def level_order_iterative(node = root, queue = [node])
    until queue.empty?
      node = queue.shift
      yield node
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
  end

  def inorder(node = root, array = [], &block)
    inorder(node.left, array, &block) unless node.left.nil?
    block_given? ? yield(node) : array << node.data
    inorder(node.right, array , &block) unless node.right.nil?
    array unless block_given?
  end

  def preorder(node = root, array = [], &block)
    block_given? ? yield(node) : array << node.data
    preorder(node.left, array, &block) unless node.left.nil?
    preorder(node.right, array, &block) unless node.right.nil?
    array unless block_given?
  end

  def postorder(node = root, array = [], &block)
    postorder(node.left, array, &block) unless node.left.nil?
    postorder(node.right, array, &block) unless node.right.nil?
    block_given? ? yield(node) : array << node.data
    array unless block_given?
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
tree.level_order_iterative { |node| print "#{node.data} | " }
puts "\n"
tree.level_order_recursive { |node| print "#{node.data} | " }
puts "\n"
tree.preorder { |node| print "#{node.data} | " }
puts "\n"
tree.inorder { |node| print "#{node.data} | " }
puts "\n"
tree.postorder { |node| print "#{node.data} | " }
tree.preorder
tree.inorder
tree.postorder
tree.pretty_print
# two_tree.pretty_print
#  { |node| print "#{node.data} | " }
