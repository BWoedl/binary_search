require_relative 'tree.rb'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# p two_tree = Tree.new([1, 7, 3])
# p tree.root
# p tree.find(tree.root, 7)
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
# p tree.height(three)
# p tree.height(five)
# p tree.height(sixty_seven)
# p "\n"
# p tree.depth(tree.root, sixty_seven)
# p tree.depth(tree.root, five)
# p tree.depth(tree.root, three)
p tree.balanced?
tree.pretty_print
# two_tree.pretty_print
#  { |node| print "#{node.data} | " }
p new_tree = Tree.new(Array.new(15) { rand(1..100) })
p new_tree.balanced?
# new_tree.preorder
# new_tree.inorder
# new_tree.postorder
new_tree.insert(new_tree.root, 120)
new_tree.insert(new_tree.root, 134)
new_tree.insert(new_tree.root, 145)
new_tree.insert(new_tree.root, 160)
new_tree.insert(new_tree.root, 101)
new_tree.insert(new_tree.root, 114)
new_tree.pretty_print
# new_tree.balanced?
# new_tree.rebalance
p new_tree.balanced?
new_tree.pretty_print