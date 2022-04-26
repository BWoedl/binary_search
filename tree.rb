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

  def find(node = root, value)
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

  def height(node, count = -1)
    return count if node.nil?
    count += 1
    [height(node.left, count), height(node.right, count)].max
  end

  def depth(parent = root, node = root, count = 0)
    if parent.nil? 
      return "Not found"
    elsif parent == node
      return count
    end
    count +=1
    return depth(parent.right, node, count) if parent.data < node.data
    return depth(parent.left, node, count) if parent.data > node.data
  end

  def balanced?
    
  end

  def rebalance(node = root)
    array = []
    array = preorder(node)
    root = array.build_tree
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

