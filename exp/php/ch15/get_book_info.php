<?php
  require_once("file://C:/wamp/www/ch15/dbtools.inc.php");

  $book_id = $_GET["book_id"];
  $mode = $_GET["mode"];
  $link = create_connection();

  if ($mode == "prev")
  {
    $sql = "select * from product where book_id < $book_id order by book_id desc limit 1";
    $result = execute_sql($link, "mobile_store", $sql);
    $total_records = mysqli_num_rows($result);

    if ($total_records == 1)
    {
      $row = mysqli_fetch_assoc($result);

      echo json_encode(array("book_id" => $row["book_id"], "image_name" => $row["image_name"], "description" => $row["description"]));
    }
    else
    {
      $sql = "select * from product where book_id = (select max(book_id) from product)";
      $result = execute_sql($link, "mobile_store", $sql);
      $row = mysqli_fetch_assoc($result);

      echo json_encode(array("book_id" => $row["book_id"], "image_name" => $row["image_name"], "description" => $row["description"]));
    }
  }
  else if ($mode == "next")
  {
    $sql = "select * from product where book_id > $book_id order by book_id limit 1";
    $result = execute_sql($link, "mobile_store", $sql);
    $total_records = mysqli_num_rows($result);

    if ($total_records == 1)
    {
      $row = mysqli_fetch_assoc($result);

      echo json_encode(array("book_id" => $row["book_id"], "image_name" => $row["image_name"], "description" => $row["description"]));
    }
    else
    {
      $sql = "select * from product where book_id = (select min(book_id) from product)";
      $result = execute_sql($link, "mobile_store", $sql);
      $row = mysqli_fetch_assoc($result);

      echo json_encode(array("book_id" => $row["book_id"], "image_name" => $row["image_name"], "description" => $row["description"]));
    }
  }

  mysqli_free_result($result);
  mysqli_close($link);
?>