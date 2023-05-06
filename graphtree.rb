require 'ruby-graphviz'

def graph_folder_contents(parent_directory, graph, parent_node)
  Pathname(parent_directory).children.each do |child|
    child_node = graph.add_nodes(child.to_s, label: child.basename.to_s)
    graph.add_edges(parent_node, child_node)

    if child.directory?
      graph_folder_contents(child.to_s, graph, child_node)
    end
  end
end

directory = ARGV[0]

graph = GraphViz.new(:G, type: :digraph)
root_node = graph.add_nodes(directory)

graph_folder_contents(directory, graph, root_node)

graph.output(svg: __dir__ + '/graphtree.svg')
