require_relative 'tree.rb'

p tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# p two_tree = Tree.new([1, 7, 3])
# p tree.root

p tree.find(tree.root, 7)
# p tree.find(tree.root, 4)
# tree.insert(tree.root, 6)
# tree.insert(tree.root, 5)
# p tree.root
# p tree.find(tree.root, 7)
# puts "\n"
# tree.pretty_print
# tree.delete(tree.root, 9)
# tree.delete(tree.root, 67)
# p "new line"
# p tree.find(tree.root, 7)
# tree.level_order_iterative { |node| print "#{node.data} | " }
# puts "\n"
# tree.level_order_recursive { |node| print "#{node.data} | " }
# puts "\n"
# tree.preorder { |node| print "#{node.data} | " }
# puts "\n"
# tree.inorder { |node| print "#{node.data} | " }
# puts "\n"
# tree.postorder { |node| print "#{node.data} | " }
# tree.preorder
# tree.inorder
# tree.postorder
three = tree.find(tree.root, 3)
five = tree.find(tree.root, 5)
sixty_seven = tree.find(tree.root, 67)
tree.height(three)
tree.height(five)
tree.height(sixty_seven)
tree.pretty_print
# two_tree.pretty_print
#  { |node| print "#{node.data} | " }