package org.dhbw.imbit11.backend;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;


/**
 * General Class which provides mail sending functionality
 * Usage with sendMail function as documented.
 * 
 * @author benste
 * 
 * @version 2.1
 */
public class MailClient extends HttpServlet
{
	 static final long serialVersionUID = 1L;
	 
	 	/**
	 	 * Function which sends a specified email with the installed mail system.
	 	 * 
	 	 * 
	 	 * @param toEmail recipient email address
	 	 * @param subject subject of the email
	 	 * @param content text of the mail
	 	 * @param request request object which is necessary to access context parameters defined in web.xml
	 	 */
	
		public void sendMail(String toEmail, String subject, String content, HttpServletRequest request) {

//			BufferedWriter writer = null;
//			try {
//				writer = new BufferedWriter(new FileWriter("/opt/tomcat/webapps/brillianicm-test2/log.txt", true));
//			} catch (IOException e1) {
//				// TODO Auto-generated catch block
//				e1.printStackTrace();
//			}
//			long yourmilliseconds = System.currentTimeMillis();
//			SimpleDateFormat sdf = new SimpleDateFormat("MMM dd,yyyy HH:mm");    
//			Date resultdate = new Date(yourmilliseconds);
			
		    
			//Getting servlet context from request
			ServletContext sc = request.getServletContext();
			//Getting context parameters from servlet context
			final String username = sc.getInitParameter("mailuser");
			final String password = sc.getInitParameter("mailpw");
	 
			Properties props = new Properties();
			props.put("mail.smtp.auth", sc.getInitParameter("smtpauth"));
			props.put("mail.smtp.starttls.enable", sc.getInitParameter("smtptls"));
			String host = sc.getInitParameter("mailserver");
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", sc.getInitParameter("mailport"));
			
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.user", username);
			props.put("mail.password", password);
			
			
			
//			try {
//				writer.newLine();
//				writer.write(sdf.format(resultdate)+"password: "+password);
//				writer.newLine();
//				writer.write(sdf.format(resultdate)+"props: "+props.toString());
//				writer.newLine();
//				writer.write(sdf.format(resultdate)+"username"+username);
//				writer.newLine();
//				writer.write(sdf.format(resultdate)+"toEmail: "+toEmail);
//				writer.newLine();
//				writer.write(sdf.format(resultdate)+"subject: "+subject);
//				writer.newLine();
//				writer.write(sdf.format(resultdate)+"content: "+content);
//				 writer.close();
//			} catch (IOException e1) {
//				// TODO Auto-generated catch block
//				e1.printStackTrace();
//			}
		   
			
			Session session = Session.getDefaultInstance(props);
			
			
//			Session session = Session.getInstance(props,
//			  new javax.mail.Authenticator() {
//				protected PasswordAuthentication getPasswordAuthentication() {
//					return new PasswordAuthentication(username, password);
//				}
//			  });
	 
			Transport transport = null;
			try {
				transport = session.getTransport();
			} catch (NoSuchProviderException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			try {
	 
				MimeMessage message = new MimeMessage(session);
//				message.setFrom(new InternetAddress(username));
				message.setFrom(new InternetAddress("no-reply@brillianideas.com","brillianIDEAS"));
				message.setRecipient(Message.RecipientType.TO,
					new InternetAddress(toEmail));
				message.setSubject(subject);
				message.setContent(content, "text/html; charset=utf-8");
			   // messageBodyPart.setText(html, "UTF-8", "html");

				

//				Transport.send(message);
				transport.connect(host,username,password);
	            transport.sendMessage(message, message.getAllRecipients());
				
				System.out.println("Email sent");
				transport.close();
	 
			} catch (AddressException e) {
	        	e.printStackTrace();
				//System.out.println("Sending email failed, incorrect address.");
	        } catch (MessagingException e) {
	        	e.printStackTrace();
				//System.out.println("Sending email failed, message could not be sent.");
		} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}
}
