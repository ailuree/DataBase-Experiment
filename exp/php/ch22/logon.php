<?php
  if (isset($_POST["account"]))
  {
    require_once("dbtools.inc.php");
		
    //取得登入資料
    $login_user = $_POST["account"]; 	
    $login_password = $_POST["password"];
	
    //建立資料連接
    $link = create_connection();
						
    //檢查帳號密碼是否正確
    $sql = "SELECT account, name FROM user Where account = '$login_user'
            AND password = '$login_password'";
    $result = execute_sql($link, "album", $sql);
	
    //若沒找到資料，表示帳號密碼錯誤
    if (mysqli_num_rows($result) == 0)
    {
      //釋放 $result 佔用的記憶體
      mysqli_free_result($result);
		
      //關閉資料連接	
      mysqli_close($link);
			
      //顯示訊息要求使用者輸入正確的帳號密碼
      echo "<script type='text/javascript'>alert('账号密码错误，请查明后再登录')</script>";
    }
    else     //如果帳號密碼正確
    {
      //將使用者資料加入 Session
      session_start();
      $row = mysqli_fetch_object($result);
      $_SESSION["login_user"] = $row->account;
      $_SESSION["login_name"] = $row->name;
	    
      //釋放 $result 佔用的記憶體	
      mysqli_free_result($result);
			
      //關閉資料連接	
      mysqli_close($link);
	        
      header("location:index.php");
    }
  }
?>
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>宠物电子相册</title>
  </head>
  <body>
    <p align="center"><img src="Title.png"></p>
    <form action="logon.php" method="post" name="myForm">
      <table align="center">
        <tr> 
          <td> 
            账号：
          </td>
          <td>
            <input type="text" name="account" size="15">
          </td>
        </tr>
        <tr> 
          <td> 
            密码：
          </td>
          <td>
            <input type="password"name="password" size="15">
          </td>
        </tr>
        <tr>
          <td align="center" colspan="2"> 
            <input type="submit" value="登录">
            <input type="reset" value="重填">
          </td>
        </tr>
      </table>
    </form>
  </body>
</html>