<!doctype html>
<html>
  <head>
  	<title>宠物电子相册</title>
    <meta charset="utf-8">
    <script type="text/javascript">
      function DeletePhoto(album_id, photo_id)
      {
        if (confirm("请确认是否删除此相片？"))
          location.href = "delPhoto.php?album_id=" + album_id + "&photo_id=" + photo_id;
      }
    </script>
  </head>	
  <body>
    <p align="center"><img src="Title.png"></p>
    <?php 
      require_once("dbtools.inc.php");
      $album_id = $_GET["album_id"]; 
      
      //取得登入者帳號
	    $login_user = "";
	    session_start();
	    if (isset($_SESSION["login_user"]))
        $login_user = $_SESSION["login_user"];
      
      //建立資料連接
      $link = create_connection();

      //取得相簿名稱及相簿的主人
      $sql = "SELECT name, owner FROM album WHERE id = $album_id";
      $result = execute_sql($link, "album", $sql);
      $row = mysqli_fetch_object($result);
      $album_name = $row->name;
      $album_owner = $row->owner;
      
      echo "<p align='center'>$album_name</p>";
													
      //取得相簿裡所有照片的縮圖
      $sql = "SELECT id, name, filename FROM photo WHERE album_id = $album_id";
      $result = execute_sql($link, "album", $sql);
	    $total_photo = mysqli_num_rows($result);
	  
      echo "<table border='0' align='center'>";

      //指定每列顯示幾張照片
      $photo_per_row = 5;
      					
      //顯示相片縮圖
      $i = 1;
      while ($row = mysqli_fetch_assoc($result))
      {
      	$photo_id = $row["id"];
      	$photo_name = $row["name"];
      	$file_name = $row["filename"];
      	
        if ($i % $photo_per_row == 1)
          echo "<tr align='center'>";
        
        echo "<td width='160px'><a href='photoDetail.php?album=$album_id&photo=$photo_id'>
              <img src='Thumbnail/$file_name' style='border-color:Black;border-width:1px'>
              <br>$photo_name</a>";
        
        if ($album_owner == $login_user)
          echo "<br><a href='editPhoto.php?photo_id=$photo_id'>编辑</a> 
               <a href='#' onclick='DeletePhoto($album_id, $photo_id)'>删除</a>";
          
        echo "<p></td>";
        
        if ($i % $photo_per_row == 0 || $i == $total_photo)
          echo "</tr>";
        
        $i++;
      }
      
      echo "</table>" ;
											  		
      //釋放資源並關閉資料連接
      mysqli_free_result($result);
      mysqli_close($link);
      
      echo "<hr><p align='center'>";
      if ($album_owner == $login_user)
        echo "<a href='uploadPhoto.php?album_id=$album_id'>上传相片</a> ";
    ?>
    <a href='index.php'>回首页</a></p>
  </body>                                                                                 
</html>