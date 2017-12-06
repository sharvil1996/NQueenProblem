$(document)
		.ready(
				function() {
					var network = null;
					var layoutMethod = "directed";
					function destroy() {
						if (network !== null) {
							network.destroy();
							network = null;
						}
					}
					function draw(data, links) {
						destroy();
						var nodes = [];
						var edges = [];
						for (var i = 0; i < Object.keys(data).length; i++) {
							var temp = data[i].split(":");
							if (temp[1] == $("#sizeTree").val() - 1) {
								nodes.push({
									id : i,
									label : temp[0],
									color : {
										background : '#5cb85c',
										border : 'purple'										
									}
								});
							} else {
								nodes.push({
									id : i,
									label : temp[0],
								});
							}
						}
						for (var i = 0; i < Object.keys(links).length; i++) {
							var temp = links[i].split(":");
							edges.push({
								from : parseInt(temp[0]),
								to : parseInt(temp[1])
							});
						}
						var container = document.getElementById('mynetwork');
						var treeData = {
							nodes : nodes,
							edges : edges
						};
						console.log(treeData);
						var options = {
							layout : {
								hierarchical : {
									sortMethod : layoutMethod
								}
							},
							edges : {
								smooth : true,
								arrows : {
									to : true
								}
							}
						};
						network = new vis.Network(container, treeData, options);
					}
					$("#btnGetSolutionTree,#btnGetSolutionList")
							.click(
									function() {
										var val;
										var sizeEle;
										if ($(this).attr('id') == "btnGetSolutionList") {
											val = false;
											sizeEle = "sizeList";
										} else {
											val = true;
											sizeEle = "sizeTree";
										}
										$
												.ajax({
													url : "SolutionServlet",
													type : "post",
													data : {
														"size" : $(
																"#" + sizeEle)
																.val(),
														"allNodes" : val
													},
													success : function(data) {
														if (val) {
															data = data
																	.split("*");
															data[0] = JSON
																	.parse(data[0]);
															data[1] = JSON
																	.parse(data[1]);
															draw(data[0],
																	data[1]);
														} else {
															$('#solutionTable')
																	.find(
																			"tr:gt(0)")
																	.remove();
															data = JSON
																	.parse(data);
															for (var i = 0; i < Object
																	.keys(data).length; i++) {
																$(
																		'#solutionTable tr:last')
																		.after(
																				"<tr><td>"
																						+ (i + 1)
																						+ "</td><td>"
																						+ (data[i])
																						+ "</td></tr>");
															}
														}
													}
												});
									});
				});