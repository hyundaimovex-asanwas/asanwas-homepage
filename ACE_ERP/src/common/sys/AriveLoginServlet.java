package common.sys;
/*
 * [ �������� ][������] ����   
 * [2011-08-12][�ɵ���] �� �α� ó�� ����
 * 						common.sys.HdasanLogin ���� 
 *                      	���Ȱ�ȭ�� ���� request �Ķ��Ÿ �޴� �κ� SQL ������ ���� ��ƿ �߰�
 *                      	SecUtil.sqlFilter(�Ķ����)
 * 						ARIVE == hyundai Asan Rich Internet application deVelop Environment
 * TestVo vo = new TestVo();
 * vo.setTitle("tktktktk");
 * req.setAttriubte("VO", vo);
 * ��� �������� ���ֹ�
 * 
 * jsp����
 * TestVo vo  = (TestVo)request.getAttribute("VO");
 * vo.getTitle() �ϸ� �޴°�¡
 * 
 * request.setAttriute("TEST", " gjgjgjgjjg");
 * String test = (String)request.getAttribute("TEST")
 *
 *  218���� : ���� �ʱ������� portal.jsp
 *				���� �ʱ������� ks_portal.jsp �� ���� ����   
 *  
 * */

import com.octo.captcha.service.CaptchaServiceException;

import javax.servlet.*;
import javax.servlet.http.*;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.imageio.ImageIO;

import common.sys.HdasanLogin;




public class AriveLoginServlet extends HttpServlet
{
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
	String login_msg 	= ""; //�޼��� ó��
	String login_gubn 	= ""; //���� ����
	String login_ssn	= ""; // �������� �ֹ�
	String foward_page	= "/newLogin.jsp";//������ ����


	String[] arr1 = (String[])paramMap.get( "ssID" );
	String[] arr2 = (String[])paramMap.get( "inCaptchaChars" );
	String[] arr3 = (String[])paramMap.get( "txt_id" );
	String[] arr4 = (String[])paramMap.get( "txt_pass" );
	String[] arr5 = (String[])paramMap.get( "login_attempt" );
	
	String 	sessId = request.getSession().getId();
	
	String 	incomingSsId = "";
	String 	txt_id = "";
	String 	txt_pass = "";
	String 	login_attempt = "1";
	String 	inputChars = "";
	int 	login_attempt_added = 1;
	String 	logicalResult = "100";
	String[] results = new String[4];	// �����
	String[] results2 = new String[4];	// �����

	String 	pcmobile = "";      // 2018.04.12 �̵��� pc �������� mobile �������� Ȯ�ο�
	
	HdasanLogin hl = new HdasanLogin();
	
	if ( arr1==null || arr3==null || arr4==null  || arr5==null ){
		//System.out.println( "Validating -: ���̵� �н����� ��ĭ�� ���Ⱑ �ƴϳ�.. �Ķ���Ͱ� �ƿ� ��������"  );
		login_msg="�ʿ��� ���� ���������� �Էµ��� �ʾҽ��ϴ�.";
	}else{
		incomingSsId = arr1.length>0 ? arr1[0] : "";
		//System.out.println( "incomingSsId ::::::" + incomingSsId +"::" );
		//�Ķ���� �޾ƿ��� ~ ������ ""�� ����
		txt_id = arr3.length>0 ? arr3[0] : "";
		txt_pass = arr4.length>0 ? arr4[0] : "";
		login_attempt = arr5.length>0 ? arr5[0] : "1";
		
		login_msg="�Ķ���� �޾ƿ���";
		if (Integer.parseInt(login_attempt)>3 ){ //�õ� 3ȸ �ʰ�
			if ( arr2==null ){
				System.out.println( "ĸ��ó��: �α�" + login_attempt +"ȸ �õ���");
				
			}else{
				inputChars = arr2.length>0 ? arr2[0] : "";	//ĸ������
				login_msg="�ʿ��� ���� ���������� �Էµ��� �ʾҽ��ϴ�(02).";
				System.out.println( "ĸ��ó��: �α�" + login_attempt +"ȸ �õ�");
			}
		}
	}

	login_attempt_added = Integer.parseInt(login_attempt)+1;	//�ϴ� Ƚ���� 1����

	// Check validity and consistency of the data.
	if ( sessId==null || incomingSsId==null || !sessId.equals(incomingSsId) )	{
		logicalResult = "02";		
	}

	if (txt_id.length()== 0 || txt_pass.length()==0 ){//���̵� �н����带 ����� ���
		logicalResult = "03";
	}else{
		if (Integer.parseInt(login_attempt)>3 ){
			// ĸ�� �Ҹ� Ȯ�� - �ɵ��� 20110811
			boolean passedCaptchaTest =	MyCaptchaService.getInstance().validateResponseForID( incomingSsId, inputChars ).booleanValue();
			System.out.println( "Validating - passedCaptchaTest are: " + passedCaptchaTest );		
			if(passedCaptchaTest){//ĸ���� true�� db access~
				
				results = hl.LoginA(request, response);
				logicalResult 	= results[0];
				login_msg 		= results[1];
				login_gubn 		= results[2].trim();
				login_ssn		= results[3].trim();
			}else{
				logicalResult = "04";
			}
		}else{
			login_msg="DBaccess";
			results = hl.LoginA(request, response);
			logicalResult 	= results[0];
			login_msg 		= results[1];
			login_gubn 		= results[2].trim();
			login_ssn		= results[3].trim();		
		}
	}
	
	//System.out.println( "������ �б� ��� ::::::" + logicalResult +"::" );
	//System.out.println( "ȸ������ �� :::::: " + login_gubn +"::" );
	//System.out.println( "login_msg ::::::" + login_msg +"::" );

	
	
	/* 2018.4.4 mobile ������ ���� �Ǵ� �� ó���̶� �����ְ��� */ 
	String userAgent = request.getHeader("User-Agent");
	
	//System.out.println( "userAgent!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! :::::: " + userAgent +"::" );				

	boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
	
	if ( ie )
	{
		
		pcmobile = "pc";
	
	}else
	{
		
		pcmobile = "mobile";
	}	
	
	
	//System.out.println( "userAgent>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> :::::: " + results[3] +"::" );
	
	//DBaccess �� ��� ó�� 
	if (logicalResult.equals("1")){			// ����ó��(in)�� ���
		
		if(!login_gubn.equals("80")){ //���»�� ������������ c= login_gubn�� ������ ���� ���� ���� ó���ϱ�
			
			foward_page="/newError.jsp?c="+ login_gubn;	//����ó�� ������
			
		}else{ //����(80)�̸� �λ����� ��ȸ �� ��������
			
			results2 = hl.setInfo(request, response, txt_id ); //���� ����

			if(results2[0].equals("10") ) { //-- �������� ��� 
				
				if(pcmobile.equals("pc") ) { //-- pc ������ ��� 
				
					foward_page="/portal.jsp?ssID="+incomingSsId;
					//foward_page="/Mobile/main.html";
				
				}
				else if(pcmobile.equals("mobile") )
				{
					
					foward_page="/Mobile/main.html";
				}
				
				
			}else{
				
				login_msg= results2[1];
				
			}
		}
	}else if(logicalResult.equals("537")){	// ����ó��(o)
		//System.out.println( "login_gubn:::::::::"+login_gubn);
		if(!login_gubn.equals("80")){ //���»�� ������������ c= login_gubn�� ������ ���� ���� ���� ó���ϱ�
			foward_page="/newError.jsp?c="+ login_gubn;	//����ó�� ������
		}else{ //����(80)�̸� �������� ������ ����
			//�̷� ������ �ؾ� �ϴ°�! ��;;
			PrintWriter out = response.getWriter();
			response.setContentType("text/html;charset=euc-kr");
			out.println("<html><body>");
			out.println("<form name=movForm id=movForm method=post>");
			out.println("	<input name=ssID type=hidden value='"+ incomingSsId +"' />");
			out.println("	<input name=ssn type=hidden value='"+ login_ssn +"' />");
			out.println("	<input name=aed type=hidden value='"+ txt_id +"' />");
			out.println("</form>	");
			out.println("<script language=javascript>	");
			out.println("	var f = document.movForm;	");
			out.println("		f.action='https://www.mtkumgang.com/popup/lgin2.jsp';	");
			out.println("		f.submit();	");
			out.println("</script>	");
			out.println("</body></html>	");
			return;
		}
	}else if(logicalResult.equals("-1") || logicalResult.equals("0") ){
		login_msg="���̵� ���ų� ��й�ȣ�� Ʋ�Ƚ��ϴ�.";
	}else if(logicalResult.equals("02")){
		login_msg="�������� ���ǰ� ��Ű�� ����ؾ� �մϴ�.";
	}else if(logicalResult.equals("03")){	// ���̵� �н����带 ����� ���
		login_msg="���̵� ���ų� �ʿ��� ���� ���������� �Էµ��� �ʾҽ��ϴ�(03).";
	}else if(logicalResult.equals("04")){	// ĸ���� ���ų� Ʋ����? �׼��� ���� ���
		login_msg="���̵� ���ų� �ʿ��� ���� ���������� �Էµ��� �ʾҽ��ϴ�(04).";
	}else if(logicalResult.equals("10")){	// ���� ���̵� ��ȸ �ȵǴ� ���
		login_msg="���̵� ���ų� �ʿ��� ���� ���������� �Էµ��� �ʾҽ��ϴ�(10).";
	}else if(logicalResult.equals("15")){	// ���� ����� Ʋ�� ���
		login_msg="���̵� ���ų� �ʿ��� ���� ���������� �Էµ��� �ʾҽ��ϴ�(15).";
	}else if(logicalResult.equals("20")){	// ���̵�� ������ �λ����� ��ȸ ����
		login_msg="���̵� ���ų� �ʿ��� ���� ���������� �Էµ��� �ʾҽ��ϴ�(20).";
	}else{
		foward_page="/newError.jsp?c=1";	//����ó�� ������
	}
	//System.out.println( "�޼��� 2:::::: " + login_msg );
	//System.out.println( "�õ�ȸ��::::: " + login_attempt_added );

		
	// Set MSG into session.
	request.getSession().setAttribute( "loginMSG", login_msg);
	request.getSession().setAttribute( "login_attempt", login_attempt_added+"");
	
	//	Forward request to results page.
	RequestDispatcher rd = getServletContext().getRequestDispatcher( foward_page );
	rd.forward( request, response );
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
  
  /* Cookie set */
  public static void setCookie(HttpServletResponse response, String name, String value, String domain, int expiry){
	  if ((name != null) && (value != null)) {
			
		  Cookie aCookie = new Cookie(name, value);
		  if (domain != null) {
			  aCookie.setDomain(domain); 
		  }
		  aCookie.setMaxAge(expiry);
		  aCookie.setPath("/");
		  response.addCookie(aCookie);
	  }
  }  
  

}