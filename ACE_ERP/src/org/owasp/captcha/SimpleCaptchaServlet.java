package org.owasp.captcha;

import com.octo.captcha.service.CaptchaServiceException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Map;
import javax.imageio.ImageIO;

public class SimpleCaptchaServlet extends HttpServlet
{
  String sImgType = null;

  public void init( ServletConfig servletConfig ) throws ServletException
  {
    super.init( servletConfig );

    // For this servlet, supported image types are PNG and JPG.
    sImgType = servletConfig.getInitParameter( "ImageType" );
    sImgType = sImgType==null ? "png" : sImgType.trim().toLowerCase();
    if ( !sImgType.equalsIgnoreCase("png") && !sImgType.equalsIgnoreCase("jpg") && !sImgType.equalsIgnoreCase("jpeg") )
    {
      sImgType = "png";
    }
  }

  // doGet() - handles captcha image generation.
  protected void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException
  {
    ByteArrayOutputStream imgOutputStream = new ByteArrayOutputStream();
    byte[] captchaBytes;

    if ( request.getQueryString()!=null )
    {
      response.sendError( HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "GET request should have no query string." );
      return;
    }

    try
    {
      // Session ID is used to identify the particular captcha.
      String captchaId = request.getSession().getId();

      // Generate the captcha image.
      BufferedImage challengeImage = MyCaptchaService.getInstance().getImageChallengeForID( captchaId, request.getLocale() );
      ImageIO.write( challengeImage, sImgType, imgOutputStream );
      captchaBytes = imgOutputStream.toByteArray();

      // Clear any existing flag.
      request.getSession().removeAttribute( "PassedCaptcha" );
    }
    catch( CaptchaServiceException cse )
    {
       System.out.println( "CaptchaServiceException - " + cse.getMessage() );
       response.sendError( HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Problem generating captcha image." );
       return;
    }
    catch( IOException ioe )
    {
       System.out.println( "IOException - " + ioe.getMessage() );
       response.sendError( HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Problem generating captcha image." );
       return;
    }

    // Set appropriate http headers.
    response.setHeader( "Cache-Control", "no-store" );
    response.setHeader( "Pragma", "no-cache" );
    response.setDateHeader( "Expires", 0 );
    response.setContentType( "image/" + (sImgType.equalsIgnoreCase("png") ? "png" : "jpeg") );

    // Write the image to the client.
    ServletOutputStream outStream = response.getOutputStream();
    outStream.write( captchaBytes );
    outStream.flush();
    outStream.close();
  }

  // doPost() - handles validation of user input
  protected void doPost( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException
  {
    // Get the request params.
    Map paramMap = request.getParameterMap();
    if ( paramMap.isEmpty() )
    {
      response.sendError( HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Post method not allowed without parameters." );
      return;
    }
    String[] arr1 = (String[])paramMap.get( "ssID" );
    String[] arr2 = (String[])paramMap.get( "inCaptchaChars" );
	String[] arr3 = (String[])paramMap.get( "txt_id" );
	String[] arr4 = (String[])paramMap.get( "txt_pass" );
	String[] arr5 = (String[])paramMap.get( "login_attempt" );
    if ( arr1==null || arr2==null || arr3==null || arr4==null || arr5==null  )
    {
      response.sendError( HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "값이 정상적으로 넘어오지 않았습니다.Expected parameters were not found." );
      return;
    }

    String sessId = request.getSession().getId();
    String incomingCaptchaId = arr1.length>0 ? arr1[0] : "";
    String inputChars = arr2.length>0 ? arr2[0] : "";	//arr2의 0번째..ㅎ
	String txt_id = arr3.length>0 ? arr3[0] : "";
	String txt_pass = arr4.length>0 ? arr4[0] : "";
	String login_attempt = arr5.length>0 ? arr5[0] : "0";

	String login_msg 	= ""; //메세지 처리
	String foward_page	= "";//페이지 설정


    // Check validity and consistency of the data.
    if ( sessId==null || incomingCaptchaId==null || !sessId.equals(incomingCaptchaId) )
    {
      response.sendError( HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Browser must support session cookies." );
      return;
    }

    // Validate whether input from user is correct.
	System.out.println( "Validating - incomingCaptchaId are: " + incomingCaptchaId );
    System.out.println( "Validating - inputChars are: " + inputChars );
	
	
	
	//시도 4회이상일 때
	if (Integer.parseInt(login_attempt)>3 ){
		System.out.println( "캡차처리: 로긴" + login_attempt +"회 시도중");
		//자꾸 오류가 나서 바로 처리해버림 - 심동현 20110811
		boolean passedCaptchaTest =	MyCaptchaService.getInstance().validateResponseForID( incomingCaptchaId, inputChars ).booleanValue();
		System.out.println( "Validating - passedCaptchaTest are: " + passedCaptchaTest );
		if(passedCaptchaTest){//캡차가 true면 db access~
			
		}else{
			login_msg = "";//메세지 처리
			foward_page="";//페이지 설정

		}
	}else{
		System.out.println( "Validating - txt_id are: " + txt_id );
		System.out.println( "걍 로긴 암호 :  " + txt_pass );
	}
	// Set MSG into session.
	request.getSession().setAttribute( "loginMSG", login_msg);
	//	Forward request to results page.
	RequestDispatcher rd = getServletContext().getRequestDispatcher( foward_page );
	//rd.forward( request, response );
  }

  private boolean validateCaptcha( String captchaId, String inputChars )
  {
    boolean bValidated = false;
    try
    {
		System.out.println( "----------" + MyCaptchaService.getInstance().validateResponseForID(captchaId, inputChars).booleanValue()   );
      bValidated = MyCaptchaService.getInstance().validateResponseForID( captchaId, inputChars ).booleanValue();
	  System.out.println("---dd-------" + bValidated  );      
    }
    catch( CaptchaServiceException cse )
    {
    	System.out.println("eee"+ cse);
    }
    return bValidated;
  }
}