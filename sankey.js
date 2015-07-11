var width = 500, height = 450;

var svg = d3.select("div").append("svg");

var color = d3.scale.category20();

var force = d3.layout.force()
    .charge(-120)
    .linkDistance(30)
    .size([width, height]);

svg.attr("width", width)
    .attr("height", height);

d3.json("static/reblognetwork_{{ session_username }}.json", function(error, graph) {
  force
      .nodes(graph.nodes)
      .links(graph.links)
      .start();

  var link = svg.selectAll(".link")
      .data(graph.links)
    .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", function(d) { return Math.sqrt(d.value); });

  var node = svg.selectAll("g.node")
      .data(graph.nodes);
  var nodeEnter = node.enter()
      .append("g")
      .attr("class", "node")
      .call(force.drag);
  nodeEnter.append("circle")
      .attr("r", 5)
      .style("fill", function(d) { return color(d.group); })
      .call(force.drag);

  nodeEnter.append("text")
     .attr("dx", 5)
     .style("text-anchor", "start")
     .text(function(d) { return d.id; });

  force.on("tick", function() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("transform", function(d) {
      return "translate(" + [d.x, d.y] + ")";
    });
  });
};