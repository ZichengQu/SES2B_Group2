package com.util;

import java.util.Date;
import java.util.Properties;
import java.util.Timer;
import java.util.TimerTask;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
 
public class MailUtils {
    public static void sendMail(String email, String emailMsg, String emailSubject)throws Exception {
        String myEmailAccount = "SESUTSHelps@gmail.com";
        String myEmailPassword = "UTSHelps999";
        String myEmailSMTPHost = "smtp.gmail.com";
        String receiveMailAccount = email;
        String emailSub;
        
        if (emailSubject.equals("1") || emailSubject.equals("2")){
    		emailSub = "Confirmation of booking";
    	} else if (emailSubject.equals("3")|| emailSubject.equals("4")) {
    		emailSub = "Confirmation of cancellation";
    	} else if (emailSubject.equals("5")|| emailSubject.equals("6")) {
    		emailSub = "Student on waiting list is booked for a session automatically";
    	} else if (emailSubject.equals("7")) {
    		emailSub = "Student registers for waiting list";
    	} else if (emailSubject.equals("8")) {
    		emailSub = "Confirmation of workshop booking";	
    	} else if (emailSubject.equals("9")) {
    		emailSub = "Confirmation of waiting list";
    	} else {
    		emailSub = "SES2A UTSHelps Website";
    	}
       
        Properties props = new Properties();
        props.setProperty("mail.transport.protocol", "smtp");
        props.setProperty("mail.smtp.host", myEmailSMTPHost);
        props.setProperty("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.smtp.port", "25");
        props.setProperty("mail.smtp.starttls.enable", "true");
 
        Session session = Session.getDefaultInstance(props);
        session.setDebug(false);
 
	    MimeMessage message = createMimeMessage(session, myEmailAccount, receiveMailAccount,emailMsg, emailSub);
	    Transport transport = session.getTransport();
	    transport.connect(myEmailAccount, myEmailPassword);
	    transport.sendMessage(message, message.getAllRecipients());
	    transport.close();
	}

    public static MimeMessage createMimeMessage(Session session, String sendMail, String receiveMail, String emailMsg, String emailSub) throws Exception {
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(sendMail, "SES2A UTSHelps", "UTF-8"));
        Address[] ccAdresses = new InternetAddress[1];
        ccAdresses[0] = new InternetAddress(receiveMail, "Student", "UTF-8");
        message.addRecipients(MimeMessage.RecipientType.TO, ccAdresses);
        //message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "Receive", "UTF-8"));
        message.setSubject(emailSub, "UTF-8");
        message.setContent(emailMsg, "text/html;charset=UTF-8");
        message.setSentDate(new Date());
        message.saveChanges();
        
	    return message;
	}
}
