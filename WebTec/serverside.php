<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="Simon Hischier">
    <title>Simons Webtec Website</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link type="text/css" rel="stylesheet" media="all" href="main.css" />
	<script src="themeswitch.js"></script>
</head>
<body class="darkTheme">
    <div class="topBar">
        <input type="button" id="webtheme" class="topBarButtons" name="webtheme" value="dark" onclick="toggleColor()">
        <input type="color" id="drawcolor" class="topBarButtons" name="drawcolor" value="#12edc1" onchange="drawOnCanvas()">
    </div>
    <div class="canvasArea">
		Hallo <?php echo htmlspecialchars($_POST['name']); ?>.
		Herzlichen dank für ihr Feedback
		<br />
		(<?php echo htmlspecialchars($_POST['feedback']); ?>)

		<a href="index.html">zurück zum Canvas</a>
	</div>

	<script>
		setTheme();
	</script>
</body>
</html>
