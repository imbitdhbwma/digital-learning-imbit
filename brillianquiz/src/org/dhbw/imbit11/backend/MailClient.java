package org.dhbw.imbit11.backend;

import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
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
	 	
	 	/*added by Christopher Krah on 2016-03-03*/
	 	public void sendCertificateMail(String username, String useremail, int score1, int score2, int score3, String completedCountry, HttpServletRequest request){
	 		ServletContext sc = request.getServletContext();
	 		Properties props = new Properties();
	 		props.put("mail.smtp.auth", sc.getInitParameter("smtpauth"));
			props.put("mail.smtp.starttls.enable", sc.getInitParameter("smtptls"));
	 		props.put("mail.smtp.host", sc.getInitParameter("mailserver"));
	 		props.put("mail.smtp.port", sc.getInitParameter("mailport"));
	 			 		
	 		final String mailusername = sc.getInitParameter("mailuser");
	 		final String mailpassword = sc.getInitParameter("mailpw");

			System.out.println(sc.getInitParameter("domain"));
	 		System.out.println(sc.getInitParameter("smtpauth"));
			System.out.println(sc.getInitParameter("smtptls"));
			System.out.println(sc.getInitParameter("mailserver"));
			System.out.println(sc.getInitParameter("mailport"));
			System.out.println(sc.getInitParameter("mailuser"));
			System.out.println(sc.getInitParameter("mailpw"));
	 		
	 		Session session = Session.getInstance(props,
	 				  new javax.mail.Authenticator() {
	 					protected PasswordAuthentication getPasswordAuthentication() {
	 						return new PasswordAuthentication(mailusername, mailpassword);
	 					}
	 				  }
	 		);
	 		
	 		ByteArrayOutputStream outputStream = null;
	 		
	        try {           
	            //construct the text body part
	            MimeBodyPart textBodyPart = new MimeBodyPart();
	            textBodyPart.setText("Dear " +username + ", \n\n"
	            		+ "congratulations to the successful completion of your project in "+completedCountry + "! \n"
	            		+ "Please find your certificate and badge attached. \n"
	            		+ "For more information about OpenBadges visit openbadges.org. \n\n"
	            		+ "Kind regards, \n"
	            		+ "Your brillianICM Team \n");
	             
	            //now write the PDF content to the output stream
	            outputStream = PDFCreator.createCertificate(username,"brillianICM",score1, score2, score3, "Competence", "Communications", "Behavior", useremail, completedCountry);
	            byte[] bytes = outputStream.toByteArray();
	            //construct the pdf body part
	            DataSource dataSource = new ByteArrayDataSource(bytes, "application/pdf");
	            MimeBodyPart pdfBodyPart = new MimeBodyPart();
	            pdfBodyPart.setDataHandler(new DataHandler(dataSource));
	            pdfBodyPart.setFileName("brillianICM Certificate for "+username+".pdf");

	            //construct the svg file
	            byte[] bytesSVG = BadgeBakery.bakeBadge(useremail, completedCountry);
	            //construct the svg body part
	            DataSource dataSourceSVG = new ByteArrayDataSource(bytesSVG, "image/svg+xml");
	            MimeBodyPart svgBodyPart = new MimeBodyPart();
	            svgBodyPart.setDataHandler(new DataHandler(dataSourceSVG));
	            svgBodyPart.setFileName("brillianICM Module "+completedCountry+" "+username+".svg");
	                         
	            //construct the mime multi part
	            MimeMultipart mimeMultipart = new MimeMultipart();
	            mimeMultipart.addBodyPart(textBodyPart);
	            mimeMultipart.addBodyPart(pdfBodyPart);
	            mimeMultipart.addBodyPart(svgBodyPart);
	             
	            //construct the mime message
	            MimeMessage mimeMessage = new MimeMessage(session);
	            mimeMessage.setSender(new InternetAddress(mailusername));
	            mimeMessage.setFrom(new InternetAddress(mailusername));
	            mimeMessage.setSubject("Your brillianICM certificate");
	            mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(useremail));
	            mimeMessage.setContent(mimeMultipart);
	             
	            //send the email
	            Transport.send(mimeMessage);
	            System.out.println("Certificate Send");
	                   
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            //clean off
	            if(null != outputStream) {
	                try { outputStream.close(); outputStream = null; }
	                catch(Exception ex) { }
	            }
	        }
	 		
	 	}
	 	
	 	
	 	/**
	 	 * Function which sends a specified email with the installed mail system.
	 	 * 
	 	 * 
	 	 * @param toEmail recipient email address
	 	 * @param subject subject of the email
	 	 * @param content text of the mail
	 	 * @param request request object which is necessary to access context parameters defined in web.xml
	 	 * @throws IOException 
	 	 * @throws NoSuchProviderException 
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
