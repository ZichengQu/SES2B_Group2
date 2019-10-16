package com.util;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {
    	 public static void Email(String email, String emailMsg, String content)throws Exception {
    	        String myEmailAccount = "SESUTSHelps@gmail.com";
    	        String myEmailPassword = "UTSHelps999";
    	        String myEmailSMTPHost = "smtp.gmail.com";
    	        String receiveMailAccount = email;
    	        Properties props = new Properties();
    	        props.setProperty("mail.transport.protocol", "smtp");
    	        props.setProperty("mail.smtp.host", myEmailSMTPHost);
    	        props.setProperty("mail.smtp.auth", "true");
    	        props.put("mail.smtp.starttls.enable", "true");
    	        props.setProperty("mail.smtp.port", "25");
    	        props.setProperty("mail.smtp.starttls.enable", "true");
    	 
    	        Session session = Session.getDefaultInstance(props);
    	        session.setDebug(false);
    	 
    		    MimeMessage message = MailUtils.createMimeMessage(session, myEmailAccount, receiveMailAccount,emailMsg, content);
    		    Transport transport = session.getTransport();
    		    transport.connect(myEmailAccount, myEmailPassword);
    		    transport.sendMessage(message, message.getAllRecipients());
    		    transport.close();
    	}
    
    public static void main(String[] args) {
		try {
			sendMail("zpx961015@163.com", "测试", "傻狗张天琪");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
