<?php

$subject = $argv[1];
$message = $argv[1];
$path = pathinfo($argv[2]);
$to = $argv[3];
$from = $argv[4];

sendAttachment($path['basename'], $path['dirname']."/", $to, $from, $subject, $message);

function sendAttachment($filename, $path, $mailto, $from, $subject, $message)
{
  $file = $path.$filename;
  $file_size = filesize($file);
  $handle = fopen($file, "r");
  $content = fread($handle, $file_size);
  fclose($handle);
  $content = chunk_split(base64_encode($content));
  $uid = md5(uniqid(time()));
  $header = "From: ".$from."\r\n";
  $header .= "MIME-Version: 1.0\r\n";
  $header .= "Content-Type: multipart/mixed; boundary=\"".$uid."\"\r\n\r\n";
  $header .= "This is a multi-part message in MIME format.\r\n";
  $header .= "--".$uid."\r\n";
  $header .= "Content-type:text/plain; charset=iso-8859-1\r\n";
  $header .= "Content-Transfer-Encoding: 7bit\r\n";
  $header .= $message."\r\n\r\n";
  $header .= "--".$uid."\r\n";
  $header .= "Content-Type: application/octet-stream; name=\"".$filename."\"\r\n";
  $header .= "Content-Transfer-Encoding: base64\r\n";
  $header .= "Content-Disposition: attachment; filename=\"".$filename."\"\r\n\r\n";
  $header .= $content."\r\n\r\n";
  $header .= "--".$uid."--";
  if (mail($mailto, $subject, "", $header)) {
      echo "[".date('Y-m-d H:i:s')."] Successfully sent mail.\n";
  } else {
      echo "[".date('Y-m-d H:i:s')."] Error sending mail.\n";
  }
}
?>