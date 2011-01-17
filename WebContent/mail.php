<?php
//declare our variables
$name = $_POST['name'];
$email = $_POST['email'];
$message = nl2br($_POST['message']);
//get todays date
$todayis = date("l, F j, Y, g:i a") ;
//set a title for the message
$subject = "Message from Your Website";
$body = "From $name, \n\n$message";
$headers = 'From: '.$email.'' . "\r\n" .
    'Reply-To: '.$email.'' . "\r\n" .
	'Content-type: text/html; charset=utf-8' . "\r\n" .
    'X-Mailer: PHP/' . phpversion();

mail("nadia.znassi@gmail.com", $subject, $body, $headers);
?>
<!--Display a thankyou message in the callback -->
<div id="mail_response">
    <h3>Thank you for your message<?php echo $name ?>!</h3><br />
    <p>We will reply to your message as soon as possible.</p><br /><br /><br />
    <h5>Message successfully sent on: </h5>
    <p><?php echo $todayis ?></p>
</div>    
