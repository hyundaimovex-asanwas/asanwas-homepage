package common.sys;
/*
 * [ 수정일자 ][수정자] 내용   
 * [2011-08-12][심동현] 새 로긴 처리 서블릿
 * 						common.sys.HdasanLogin 내에 
 *                      	보안강화를 위한 request 파라미타 받는 부분 SQL 인젝션 방지 유틸 추가
 *                      	SecUtil.sqlFilter(파라미터)
 * 						ARIVE == hyundai Asan Rich Internet application deVelop Environment
 * TestVo vo = new TestVo();
 * vo.setTitle("tktktktk");
 * req.setAttriubte("VO", vo);
 * 라고 서블릿에서 해주믄
 * 
 * jsp에는
 * TestVo vo  = (TestVo)request.getAttribute("VO");
 * vo.getTitle() 하면 받는거징
 * 
 * request.setAttriute("TEST", " gjgjgjgjjg");
 * String test = (String)request.getAttribute("TEST")
 *
 *  218라인 : 본사 초기페이지 portal.jsp
 *				개성 초기페이지 ks_portal.jsp 로 변경 저장   
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
	String login_msg 	= ""; //메세지 처리
	String login_gubn 	= ""; //계정 구분
	String login_ssn	= ""; // 본인인증 주번
	String foward_page	= "/newLogin.jsp";//페이지 설정


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
	String[] results = new String[4];	// 결과값
	String[] results2 = new String[4];	// 결과값

	String 	pcmobile = "";      // 2018.04.12 이동훈 pc 접속인지 mobile 접속인지 확인용
	
	HdasanLogin hl = new HdasanLogin();
	
	if ( arr1==null || arr3==null || arr4==null  || arr5==null ){
		//System.out.println( "Validating -: 아이디나 패스워드 빈칸은 여기가 아니네.. 파라미터가 아예 없을때군"  );
		login_msg="필요한 값이 정상적으로 입력되지 않았습니다.";
	}else{
		incomingSsId = arr1.length>0 ? arr1[0] : "";
		//System.out.println( "incomingSsId ::::::" + incomingSsId +"::" );
		//파라미터 받아오기 ~ 없으면 ""로 설정
		txt_id = arr3.length>0 ? arr3[0] : "";
		txt_pass = arr4.length>0 ? arr4[0] : "";
		login_attempt = arr5.length>0 ? arr5[0] : "1";
		
		login_msg="파라미터 받아오기";
		if (Integer.parseInt(login_attempt)>3 ){ //시도 3회 초과
			if ( arr2==null ){
				System.out.println( "캡차처리: 로긴" + login_attempt +"회 시도중");
				
			}else{
				inputChars = arr2.length>0 ? arr2[0] : "";	//캡차문자
				login_msg="필요한 값이 정상적으로 입력되지 않았습니다(02).";
				System.out.println( "캡차처리: 로긴" + login_attempt +"회 시도");
			}
		}
	}

	login_attempt_added = Integer.parseInt(login_attempt)+1;	//일단 횟수는 1증가

	// Check validity and consistency of the data.
	if ( sessId==null || incomingSsId==null || !sessId.equals(incomingSsId) )	{
		logicalResult = "02";		
	}

	if (txt_id.length()== 0 || txt_pass.length()==0 ){//아이디나 패스워드를 비워둔 경우
		logicalResult = "03";
	}else{
		if (Integer.parseInt(login_attempt)>3 ){
			// 캡차 불린 확인 - 심동현 20110811
			boolean passedCaptchaTest =	MyCaptchaService.getInstance().validateResponseForID( incomingSsId, inputChars ).booleanValue();
			System.out.println( "Validating - passedCaptchaTest are: " + passedCaptchaTest );		
			if(passedCaptchaTest){//캡차가 true면 db access~
				
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
	
	//System.out.println( "로지컬 분기 결과 ::::::" + logicalResult +"::" );
	//System.out.println( "회원구분 값 :::::: " + login_gubn +"::" );
	//System.out.println( "login_msg ::::::" + login_msg +"::" );

	
	
	/* 2018.4.4 mobile 에서도 뭔가 되는 것 처럼이라도 보여주고자 */ 
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
	
	//DBaccess 후 결과 처리 
	if (logicalResult.equals("1")){			// 정상처리(in)인 경우
		
		if(!login_gubn.equals("80")){ //협력사면 오류페이지로 c= login_gubn을 가지고 가서 값에 따라 처리하기
			
			foward_page="/newError.jsp?c="+ login_gubn;	//에러처리 페이지
			
		}else{ //직원(80)이면 인사정보 조회 후 메인으로
			
			results2 = hl.setInfo(request, response, txt_id ); //정보 설정

			if(results2[0].equals("10") ) { //-- 정상설정된 경우 
				
				if(pcmobile.equals("pc") ) { //-- pc 접속인 경우 
				
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
	}else if(logicalResult.equals("537")){	// 정상처리(o)
		//System.out.println( "login_gubn:::::::::"+login_gubn);
		if(!login_gubn.equals("80")){ //협력사면 오류페이지로 c= login_gubn을 가지고 가서 값에 따라 처리하기
			foward_page="/newError.jsp?c="+ login_gubn;	//에러처리 페이지
		}else{ //직원(80)이면 본인인증 받으러 고고싱
			//이런 짓까지 해야 하는가! ㅋ;;
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
		login_msg="아이디가 없거나 비밀번호가 틀렸습니다.";
	}else if(logicalResult.equals("02")){
		login_msg="브라우저가 세션과 쿠키를 허용해야 합니다.";
	}else if(logicalResult.equals("03")){	// 아이디나 패스워드를 비워둔 경우
		login_msg="아이디가 없거나 필요한 값이 정상적으로 입력되지 않았습니다(03).";
	}else if(logicalResult.equals("04")){	// 캡차가 없거나 틀려서? 액세스 안한 경우
		login_msg="아이디가 없거나 필요한 값이 정상적으로 입력되지 않았습니다(04).";
	}else if(logicalResult.equals("10")){	// 계정 아이디가 조회 안되는 경우
		login_msg="아이디가 없거나 필요한 값이 정상적으로 입력되지 않았습니다(10).";
	}else if(logicalResult.equals("15")){	// 계정 비번이 틀린 경우
		login_msg="아이디가 없거나 필요한 값이 정상적으로 입력되지 않았습니다(15).";
	}else if(logicalResult.equals("20")){	// 아이디는 있으나 인사정보 조회 실패
		login_msg="아이디가 없거나 필요한 값이 정상적으로 입력되지 않았습니다(20).";
	}else{
		foward_page="/newError.jsp?c=1";	//에러처리 페이지
	}
	//System.out.println( "메세지 2:::::: " + login_msg );
	//System.out.println( "시도회수::::: " + login_attempt_added );

		
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