<?php
  require_once("dbtools.inc.php");
  header("Content-type: text/html; charset=utf-8");
  
  //取得表單資料
  $id = strtoupper($_POST["id"]);
  $name = $_POST["name"];	

  //建立資料連接
  $link = create_connection();
			
  //檢查身份證字號是否投過票
  $sql = "SELECT * FROM id_number Where id = '$id'";
  $result = execute_sql($link, "vote", $sql);

  //如果身份證字號已經投過票
  if (mysqli_num_rows($result) != 0)
  {
    //釋放 $result 佔用的記憶體
    mysqli_free_result($result);
		
    //顯示訊息要求使用者更換帳號名稱
    echo "<script type='text/javascript'>";
    echo "alert('您您已经参加过本次活动了');";
    echo "history.back();";
    echo "</script>";
    exit();
  }
	
  //如果身份證字號沒有投過票
  else
  {
    //釋放 $result 佔用的記憶體	
    mysqli_free_result($result);
		
    /* 執行 INSERT INTO 陳述式，將此瀏覽者的身份證字號加
       入 id_number 資料表，表示此身份證字號已投票 */
    $sql = "INSERT INTO id_number (id) VALUES ('$id')";
    $result = execute_sql($link, "vote", $sql);
				
    //使用 UPDATE 陳述式將票數 + 1
    $sql = "UPDATE candidate SET score = score + 1 WHERE name = '$name'";
    $result = execute_sql($link, "vote", $sql);
  }
	
  //關閉資料連接	
  mysqli_close($link);

  //將使用者導向 result.php 網頁
  header("location:result.php");
?>