<?php
	//连接数据库
	$con = mysql_connect("localhost", "zm", "0000");
	if (!$con)
	{
		die('Could not connect: ' . mysql_error());
	}
	//选择venus数据库
	$db_selected = mysql_select_db("vote",$con);
	
	$ret = array();
	$sql = "select * from info";
	$result= mysql_query($sql,$con);
	while($row = mysql_fetch_array($result)){
		if($row['state'])
		{
			array_push($ret,(int)$row['vote']);
		}
	}
	echo json_encode($ret);
?>