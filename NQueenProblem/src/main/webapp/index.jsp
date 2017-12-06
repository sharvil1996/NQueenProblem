<%@page import="com.controller.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>NQueenProblem</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/vis.css">
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/nQueen.js"></script>
<script src="js/vis.js"></script>
<script src="js/analytics.js"></script>
<script src="js/googleAnalytics.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$('#drawBoard')
								.click(
										function() {
											var board = "";
											var size = parseInt($("#boardSize")
													.val());
											for (i = 0; i < size; i++) {
												board += '<div class="btn-group-horizontal" >';
												for (j = 0; j < size; j++)
													board += '<button type="button" count=0 class="btn btn-default" id="rc'+i+'~'+j+'">.</button>';
												board += '</div>';
											}
											$('#board').html(board);
											return false;
										});

						function enableDisableLocation(val, id) {
							var btnClass;
							if (val)
								btnClass = "btn btn-danger";
							else
								btnClass = "btn btn-default";
							var index = id.indexOf('~');
							var row = id.substr(0, index);
							var col = id.substr(index + 1);
							var tempRow = row, tempCol = col;
							var size = parseInt($("#boardSize").val());
							for (i = 0; i < size; i++) {
								document.getElementById('rc' + row + '~' + i).className = btnClass;
								document.getElementById('rc' + i + '~' + col).className = btnClass;
								document.getElementById('rc' + row + '~' + i).disabled = val;
								document.getElementById('rc' + i + '~' + col).disabled = val;
							}
							while (tempRow > 0 && tempCol > 0) {
								document.getElementById('rc' + (--tempRow)
										+ '~' + (--tempCol)).className = btnClass;
								document.getElementById('rc' + (tempRow + 1)
										+ '~' + (tempCol + 1)).disabled = val;
							}
							document.getElementById('rc' + (tempRow) + '~'
									+ (tempCol)).disabled = val;
							tempRow = row;
							tempCol = col;
							while (tempCol < size - 1 && tempRow < size - 1) {
								document.getElementById('rc' + (++tempRow)
										+ '~' + (++tempCol)).className = btnClass;
								document.getElementById('rc' + (tempRow - 1)
										+ '~' + (tempCol - 1)).disabled = val;
							}
							document.getElementById('rc' + (tempRow) + '~'
									+ (tempCol)).disabled = val;
							tempRow = row;
							tempCol = col;
							while (tempCol > 0 && tempRow < size - 1) {
								document.getElementById('rc' + (++tempRow)
										+ '~' + (--tempCol)).className = btnClass;
								document.getElementById('rc' + (tempRow - 1)
										+ '~' + (tempCol + 1)).disabled = val;
							}
							document.getElementById('rc' + (tempRow) + '~'
									+ (tempCol)).disabled = val;
							tempRow = row;
							tempCol = col;
							while (tempCol<size-1 && tempRow>0) {
								document.getElementById('rc' + (--tempRow)
										+ '~' + (++tempCol)).className = btnClass;
								document.getElementById('rc' + (tempRow + 1)
										+ '~' + (tempCol - 1)).disabled = val;
							}
							document.getElementById('rc' + (tempRow) + '~'
									+ (tempCol)).disabled = val;

							document.getElementById('rc' + (row) + '~' + (col)).disabled = false;
							if (val)
								document.getElementById('rc' + row + '~' + col).className = "btn btn-info";
							else
								document.getElementById('rc' + row + '~' + col).className = "btn btn-default";
						}
						$(document).on('click', '[id^=rc]', function() {
							var id = $(this).attr('id').substr(2);
							var isEnabled = $(this).hasClass('btn-info');
							if (isEnabled)
								enableDisableLocation(false, id);
							else
								enableDisableLocation(true, id);
						});
					});
</script>
</head>
<body>

	<div class="container">
		<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#home">Home</a></li>
			<li><a data-toggle="tab" href="#menu1">Play Game</a></li>
			<li><a data-toggle="tab" href="#menu2">Show Solution Tree</a></li>
			<li><a data-toggle="tab" href="#menu3">Show Solution Only</a></li>
		</ul>

		<div class="tab-content">
			<div id="home" class="tab-pane fade in active">
				<h3>
					<label>N-Queen Problem</label>
				</h3>
				<p>
					The <b>N Queens puzzle</b> is the problem of placing <b>N</b> chess
					queen on an <b>N x N</b> chessboard so that no two queens threaten
					each other. Thus, a solution requires that no two queens share the
					same row, column, or diagonal. In <b>N queens problem</b> there
					exist solution for all natural numbers <b>N</b> with the exception
					of <b>n=2</b> and <b>n=3</b>.
				</p>
				<div class="row">
					<div class="col-md-4">
						<a href="images/8x8.png" class="thumbnail">
							<p>8 Queen</p> <img src="images/8x8.png" alt="Pulpit Rock"
							style="width: 150px; height: 150px">
						</a>
					</div>
					<div class="col-md-4">
						<a href="images/9x9.png" class="thumbnail">
							<p>9 Queen</p> <img src="images/9x9.png"
							alt="Moustiers Sainte Marie" style="width: 150px; height: 150px">
						</a>
					</div>
					<div class="col-md-4">
						<a href="images/10x10.png" class="thumbnail">
							<p>10 Queen</p> <img src="images/10x10.png" alt="Cinque Terre"
							style="width: 150px; height: 150px">
						</a>
					</div>
				</div>
			</div>
			<div id="menu1" class="tab-pane fade">
				<h3>
					<form class="form-inline" role="form">
						<div class="form-group">
							<label>Enter Board Size</label> <input type="text"
								class="form-control" id="boardSize">
						</div>
						<button class="btn btn-success" id="drawBoard">Draw Board</button>
					</form>
				</h3>
				<div id="board"></div>
			</div>
			<div id="menu2" class="tab-pane fade">
				<h3>
					<form class="form-inline">
						<div class="form-group">
							<label for="email">Solution Tree for N = </label> <input
								type="number" class="form-control" id="sizeTree">
						</div>
						<button type="button" class="btn btn-success"
							id="btnGetSolutionTree">Generate Tree</button>
					</form>
				</h3>
				<div id="mynetwork"
					style="width: 1200px; height: 530px; border: 1px solid lightgray;"></div>
			</div>
			<div id="menu3" class="tab-pane fade">
				<h3>
					<form class="form-inline">
						<div class="form-group">
							<label for="email">Solution List for N = </label> <input
								type="number" class="form-control" id="sizeList">
						</div>
						<button type="button" class="btn btn-success"
							id="btnGetSolutionList">Generate List</button>
					</form>
				</h3>
				<table class="table table-bordered" id="solutionTable">
					<thead>
						<tr>
							<th>Sr No.</th>
							<th>Position</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<br />
	</div>

</body>
</html>

<!--
There is some mistake which causes site to be non-responsive
-->