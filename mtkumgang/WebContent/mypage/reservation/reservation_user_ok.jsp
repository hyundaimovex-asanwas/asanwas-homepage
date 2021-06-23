<%--
  - 작성자: 이소연
  - 일자: 2006.07.03
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 마이페이지>나의예약보기
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
    String saveDir 		 =  Config.getInstance().getProperty("imjkmd","reservationUserUpload");
    String fileRootDir = Util.getString(Config.getInstance().getProperty("imjkmd","reservationUserLink"),"/asanway/upload/reservationUserUpload/");
	int maxSize = 5*1024*1024;

   //첨부파일 용량 체크
    if(request.getContentLength() > maxSize ){

		out.println("<script language=\"javascript\">");
		out.println("<!--");
		out.println("alert('최대용량은 5M를 넘을 수 없습니다.');");
		out.println("//-->");
		out.println("</script>");
		out.flush();
		out.close();

		return;
	}	

	MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize,"euc-kr", new DefaultFileRenamePolicy());

	//request parameters
	int cust_sid		= ParamUtil.getIntParameter(multi.getParameter("cust_sid"));
	String manage_no	= ParamUtil.getReqParameter(multi.getParameter("manage_no"));
	String regi_no1		= ParamUtil.getReqParameter(multi.getParameter("regi_no1"));
	String regi_no2		= ParamUtil.getReqParameter(multi.getParameter("regi_no2"));
    String regi_no      = regi_no1+regi_no2;
    //String tel_no1	    = ParamUtil.getReqParameter(multi.getParameter("tel_no1"));
    //String tel_no2	    = ParamUtil.getReqParameter(multi.getParameter("tel_no2"));
    //String tel_no3	    = ParamUtil.getReqParameter(multi.getParameter("tel_no3"));
    //String tel_no       = tel_no1+"-"+tel_no2+"-"+tel_no3;    
    //String mobile_no1	= ParamUtil.getReqParameter(multi.getParameter("mobile_no1"));
    //String mobile_no2	= ParamUtil.getReqParameter(multi.getParameter("mobile_no2"));
    //String mobile_no3	= ParamUtil.getReqParameter(multi.getParameter("mobile_no3"));
    //String mobile_no       = mobile_no1+"-"+mobile_no2+"-"+mobile_no3;
    String mobile_no    = ParamUtil.getReqParameter(multi.getParameter("mobile_no"));
    String tel_no	    = ParamUtil.getReqParameter(multi.getParameter("tel_no"));
    String zip_cd1	    = ParamUtil.getReqParameter(multi.getParameter("zip_cd1"));
    String zip_cd2	    = ParamUtil.getReqParameter(multi.getParameter("zip_cd2"));
    String zip_cd       = zip_cd1+zip_cd2;
    String address1	    = ParamUtil.getReqParameter(multi.getParameter("address1"));
    String address2	    = ParamUtil.getReqParameter(multi.getParameter("address2"));
    String company_nm	= ParamUtil.getReqParameter(multi.getParameter("company_nm"));
    String positions	= ParamUtil.getReqParameter(multi.getParameter("positions"));
    String cust_nm	    = ParamUtil.getReqParameter(multi.getParameter("cust_nm"));
    
	String saveDirName		= ParamUtil.getReqParameter(multi.getParameter("saveDirName"));
	String realFileName    	= Util.getString(multi.getParameter("realFileName"),"");
  
	String fileName = new String();
	String fileSystemName = new String();
	Enumeration enum = multi.getFileNames();
	File systemFile = null;
	File tempFile = null;
	int sepIndex = 0;
	String fileExtName = "";
	String virtualName = "";

	while(enum.hasMoreElements())
	{  
		fileName = (String)enum.nextElement();
		fileSystemName = Util.getString(multi.getFilesystemName(fileName),"");
		//확장자 뽑아내기
		sepIndex = fileSystemName.indexOf(".");
		if(sepIndex>0){
		      //fileExtName =  fileSystemName.substring(sepIndex);
		      fileExtName =  ".jpg";
		}
		//업데이트 된 파일 찾기
		systemFile = new File(saveDir+fileSystemName);

		//파일이름 - 관리번호(주민번호)
		String fileNm = regi_no;
		 
		//업데이트 된 파일이 있으면.. 
		if(systemFile.exists()){
		    //파일 이름을 관리번호(주민번호)롤 변경한다.
		    virtualName = fileNm+fileExtName;
		    tempFile = new File(saveDir+virtualName);
		    //서버에 저장한다.
		    systemFile.renameTo(tempFile);
		}
	}

//DAO
ReservationInfo dao = new ReservationInfo();
//DTO
Reservation_bean bean = new Reservation_bean();

bean.setZip_cd(zip_cd);
bean.setAddress1(address1);
bean.setAddress2(address2);
bean.setTel_no(tel_no);
bean.setMobile_no(mobile_no);
bean.setCompany_nm(company_nm);
bean.setPositions(positions);
bean.setCust_sid(cust_sid);
  
int result = 0;

result = dao.getCustUpdate(bean);

if(result>0){

%>
    <script language="JavaScript">
	<!--
	 alert('성공적으로 처리 되었습니다.');
	 opener.location.reload();
	 self.close();
	//-->
	</script>
<%
}else{
%>
	<script language="JavaScript">
	<!--
	alert('처리에 실패하였습니다. 잠시후 다시 사용하여 주십시요.');
	opener.location.reload();
	//-->
	</script>
<%
}		
%>