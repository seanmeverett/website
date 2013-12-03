<?php
$name = $_POST['name'];
$email = $_POST['email'];

$message = $_POST['message'];
$formcontent=" From: $name \n Email: $email \n Message: $message";
$recipient = "seanmeverett@gmail.com";
$subject = "Contact Form: seanmeverett.com";
$mailheader = "From: $email \r\n";
mail($recipient, $subject, $formcontent, $mailheader) or die("Error!");
echo "Transmission received. Keep journeying through my site:" . "<a href='portfolio.html' style='text-decoration:underline;color:#233e73;'> View Portfolio</a>";
?>
