<?php
  require_once("dbtools.inc.php");
  header("Content-type: text/html; charset=utf-8");
  
  //取得表單資料
  $name = $_POST["name"];
  $introduction = $_POST["introduction"];
	
  //建立資料連接
  $link = create_connection();
			
  //執行 SELECT 陳述式來擷取候選人資料
  $sql = "SELECT * FROM candidate WHERE name='$name'";
  $result = execute_sql($link, "vote", $sql);
   
  //檢查被推薦人是否有在候選人清單中
  if (mysqli_num_rows($result) == 0)
  {
    //釋放資源
    mysqli_free_result($result);
		
    //將候選人資料加入資料庫
    $sql = "INSERT INTO candidate (name , introduction , score)
            VALUES ('$name', '$introduction', 0)";
    $result = execute_sql($link, "vote", $sql);
		
    //將使用者導向線上投票首頁
    header("location:index.php");
  }
  else
  {
    //顯示被推薦人已經是候選人的訊息
    echo "<p align='center'>您推荐的人已经在候选人名单中了，不须要再推荐。</p>";
    echo "<p align='center'><a href ='javascript:history.back()'>回上一页</a>";
    echo "　　<a href='index.php'>回首页</a></p>";
  }
	
  //關閉資料連接
  mysqli_close($link);
?>