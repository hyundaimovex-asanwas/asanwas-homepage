<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 쪽지 쓰기
 * 프로그램ID   : my710i
 * J  S  P		: my710i
 * 서 블 릿		: My710i
 * 작 성 자		: 박경국, 심동현
 * 작 성 일     : 2010-05-20
 * 기능정의		: 쪽지 쓰기, 쓰기 완료면 "정상 발송되었습니다" 얼럿 후 다시 쓰기 화면으로
 * [수정  일자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-03-11][심동현] 새 게시판 타입으로 수정. (menuID= 404)
 * [2010-05-20][박경국] 현대아산 임직원+대리점 담당자가 같이 사용가능한 받은 쪽지함(쓰기화면) 신규 생성.
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="sales.menu.my.My710DTO" %>
<%@ page import="sales.org.common.*"%>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>

<%	// ContextPath 변수 설정.
   String dirPath = request.getContextPath(); //HDASan
   
   String recipient	= HDUtil.nullCheckStr(request.getParameter("brd_creator"));
   String recipient_name	=HDUtil.nullCheckStr(request.getParameter("brd_creator_name"));
   
   String ref 			= HDUtil.nullCheckStr(request.getParameter("ref"));
   String ref_step 	= HDUtil.nullCheckStr(request.getParameter("ref_step"));
   String ref_level = HDUtil.nullCheckStr(request.getParameter("ref_level"));
   String work_flag = "";
	work_flag 	= HDUtil.nullCheckStr(request.getParameter("work_flag"));
   if (work_flag == null || work_flag.equals("")){
       work_flag = "INSERT";
   }
	
   String brd_gu = "01";	//게시판 구분 코드
   String brd_no = "";	//게시판 구분 코드
   
      
   if (ref == null || ref.equals("")){
       ref = "0";
   }
   if (ref_step == null || ref_step.equals("")){
       ref_step = "0";
   }
   if (ref_level == null || ref_level.equals("")){
       ref_level = "0";
   }
   
   
//변수 선언- 파일업로드용 복사한 것 _---------------------
String cmd	= "";			//작업구분 (인서트 | 업뎃)
String title= "";			//제목
String content	= "";		//내용
String passwd	= "";		//비번
String writer	= "";		//작성자 아이디
String writer_name	= "";

String user_id = "";
String user_name = "";
String virtual_name	= "";
String real_name		= "";
String fullFilename	= "";

String fileNameList = "";	//파일 리스트 보관용 (수정시)

Tbrd_attach_file_de_bean[] fileRecord = null;	//파일 첨부용 빈~!

if (work_flag.equals("MODIFY")){	//게시물번호가 있으면 에디트로 인식함
	cmd = "edit";

   ArrayList data3 = new ArrayList();
   SmartRequest sr3 = new SmartRequest(request);
   String where_sql3     = "";
   
   brd_gu = HDUtil.nullCheckStr(request.getParameter("brd_gu"));
   brd_no = HDUtil.nullCheckStr(request.getParameter("brd_no"));

   int len3 = 0;
   BaseDataClass bean3;
   String key 		= HDUtil.nullCheckStr(request.getParameter("search_key"));
   String values 	= HDUtil.nullCheckStr(request.getParameter("search_value"));
   
   sr3.setObject("where_sql",(Object)where_sql3);
   sr3.setObject("brd_no", (Object)brd_no);
   My710Manager manager3 = new My710Manager();
   My710DTO dto = manager3.select(sr3);
   manager3.close();

	//변수에 읽어온 값 넣기 (update의 경우
	title 	= dto.getBrd_subject();		//제목
	content	= dto.getBrd_contents();	//내용
	writer	= dto.getBrd_creator();		//작성자
	//recipient	=	dto.getBrd_recipient();	//수신자 
	writer_name	= dto.getBrd_creator_name();		//작성자 이름
	//recipient_name	=	dto.getBrd_recipient_name();	//수신자 이름


	//파일리스트 html 만들기
    StringBuffer sb = new StringBuffer();
	String real_fileList = dto.getReal_file();	//값을 불러와서 
	String sys_fileList = dto.getSys_file();
	fileNameList = real_fileList;				// 시스파일 리스트를 담음.

	String real_file[] = real_fileList.split(":");	//배열로 정리
	String sys_file[] = sys_fileList.split(":");	//배열로 정리
	
		for(int j=0; j<sys_file.length; j++){

			sb.append("<option value='"+sys_file[j]+ "'>" + real_file[j] +"</option>"); 
		};

	//첨부란에 넣을 html코드 만들기                     
	fullFilename = sb.toString();     	

    //자기가 쓴 글만 삭제 가능
//	if(user_id.equals(session_id)) deleteYn = true;

}else{
	cmd = "insert";
	//user_id = session_id;
	//user_name = session_name;
//	regdate = Util.getDate();
}
//변수 선언- 파일업로드용 복사한 것 _---------------------   
%>

<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		

	<script language="javascript">
	function fnOnLoad(tree_idx){
		fnInit_tree(400);	//트리초기화 호출
	}

	/**
	 * 정규표현식을 이용한 공백 체크
	 */
	function isNull( text ){
		 if( text == null ) return true;  
		
		 var result = text.replace(/(^\s*)|(\s*$)/g, "");  
		
		 if( result )  
			return false;  
		 else  
			return true;  
	}
	
	//게시판 전송 체크
	function send_ok(){
		var f = document.form1;
		var ff = document.fileForm;
		
//		if(f.brd_subject.value==""){alert("제목을 입력해 주세요!");  f.brd_subject.focus(); return;}
//		if(f.brd_creator.value==""){alert("작성자를 입력해 주세요!");  f.brd_creator.focus(); return;}
//		if(f.brd_recipient.value==""){alert("수신자를 입력해 주세요!");  f.brd_recipient.focus(); return;}
//		if(f.brd_passwd.value==""){alert("비밀번호를 입력해 주세요!");  f.brd_passwd.focus(); return;}
	
		var oEditor = FCKeditorAPI.GetInstance('brd_contents') ;
		var div = document.createElement("DIV");
		div.innerHTML = oEditor.GetXHTML();
		if( isNull( div.innerText ) ) { 
		  alert("내용을 입력하세요.");  
		  oEditor.Focus();
		  return;
		};
		
		//첨부파일명 
		if(ff.fileList.options.length > 0)
		{
			f.sys_file.value = "";
			f.real_file.value = "";
			for(i=0;i<ff.fileList.options.length;i++)
			{
			  if(i==0){
				  f.sys_file.value += ff.fileList.options[i].value;
				  f.real_file.value += ff.fileList.options[i].text;
			  }else{
			    f.sys_file.value += ":"+ff.fileList.options[i].value;
			    f.real_file.value += ":"+ff.fileList.options[i].text;
			  }
			}
		}else{
			//alert("파일을 업로드 해주세요.");
			//return;
		}
	
	//	alert(f.sys_file.value +"/"+ f.real_file.value);
		//첨부파일명 처리
	   
	   f.action='my710_exec.jsp?idx=404';
	   f.target="";
	   f.method = "POST";
	   f.submit();
	};


	//취소버튼 : 클릭 >> 목록으로
	function cancel(){
		window.history.back();
	//	var f = document.form1;
	//	f.action='my710_list.jsp?idx=404';
	//	f.target='';
	//	f.method='POST';
	//	f.submit();
	}
	
	
	//파일업로드 함수 5
	//기존 이미지들 목록
	var oldFileNames = "<%=fileNameList%>";


	//파일업로드 함수 1
		//이미지 서버로 올리기
	function tempUpload()
	{
		//document.domain="imjk.co.kr";
		f = document.fileForm;
	    //alert(f);
		if(f.file1.value.length == 0 || f.file1.value == "첨부파일 총용량 제한 : 5M")
		{
			alert('업로드할 파일을 선택하여 주십시요');
			return;
		}
	
		var realFileName = f.file1.value;
		var idx = realFileName.lastIndexOf("\\");
		realFileName = realFileName.substring(idx+1);
		//alert(realFileName);
		if(realFileName.indexOf(".mp3") > 0 ||realFileName.indexOf(".wma") > 0 || realFileName.indexOf(".asf") > 0){
			alert("저작권 문제의 소지가 있는 mp3, wma, asf 형식의 음악파일 첨부는 되지 않습니다.");
			return;
		}
		strArray = realFileName.split("."); 
		strArray2 = realFileName.split("|"); 
	  
		//파일이름에 [.] 이 있으면 안된다.(확장자 제외)
		if(strArray.length > 2){
		  alert("파일이름중 '.' 이 있으면 삭제하여 주십시요 ");
		  return;
		}
		
		if(strArray.length < 1){
		  alert("확장자명은 반드시 있어야 합니다.  ");
		  return;
		}
		//파일이름에 [|] 이 있으면 안된다.
		if(strArray2.length > 1){
		  alert("파일이름중 '|' 이 있으면 모두 삭제하여 주십시요 ");
		  return;
		}
		
		f.target="tempUpload";	//업로드 폼의 타겟은 iFrame !
		f.realFileName.value=realFileName;
		f.mode.value="insert";
		 
		f.action = "./my710_upload.jsp";
		f.submit();
	}

	//파일업로드 2
		//파일 목록에 추가: iFrame 안에서 호출한다
	function addFileList(realName, virtualName)	{
		f = document.fileForm;
	
		if(realName!=""){
			f.fileList.options[f.fileList.options.length] = new Option(realName,virtualName);
		}
		f.file1.value ="첨부파일은최대5M까지가능합니다." ;  //f.file1.title;
	}


	//파일업로드 3
	// 파일 목록에서 삭제 
	function fileDelete(){
		f = document.fileForm;
	  
		if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0){
			alert('삭제할 파일을 선택해 주십시요');
			f.fileList.focus();
			return;
		}	
	
		if(confirm('정말로 삭제 하시겠습니까?')){
			var i = f.fileList.options.selectedIndex;
			var select_val = f.fileList.options[i].value;
			var realFileName = f.file1.value;
		    var fileArray = oldFileNames.split(":");
	
			//alert(select_val);
			//alert(oldFileNames);
	
			//******** START 기존에 있던 파일인지 구분 ***********/
			var isNew = "i_del"; // 이게 금방 올린 파일인 경우... insert_file
			 
	
			if(fileArray.length>1){
				 for(j=0;j< fileArray.length;j++){
				    tempFileName = fileArray[j];
				   if(tempFileName == select_val){
				      isNew = "u_del";		// 여기가 예전 파일	update_file 
				      break;
				    }
				 }
			}
			 
			if(fileArray.length <=1){
			   if(oldFileNames == select_val){
					      isNew = "u_del";
				}
			}
			//******** END  기존에 있던 파일인지 구분 ***********/
			 
			//alert(isNew);
	
			document.file_del.target="tempUpload";
			document.file_del.realFileName.value=realFileName;
			document.file_del.virtualFileName.value = select_val;
	//		document.file_del.saveDir.value = "memGalleryUpload";
			document.file_del.mode.value=isNew;
			document.file_del.action = "./my710_deleteFile.jsp";	//여기로 섬밋
			document.file_del.submit();
		}
	}




	//파일업로드 4
	// 파일을 서버에서 삭제 후 리스트에서 삭제
	function delResult(){
		f = document.fileForm;
	
		idx = f.fileList.selectedIndex;
		cnt = f.fileList.options.length;
		for(i=idx;i< f.fileList.options.length-1;i++){
			f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
		}
		f.fileList.options[cnt - 1] = null;
		f.file1.value = "첨부파일은최대5M까지가능합니다.";
	}


	</script>
</head>

<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<!-- 새 폼 -->

        <form name="form1" enctype="MULTIPART/FORM-DATA">		
             <input type="hidden" name="brd_gu" value="<%=brd_gu%>">
             <input type="hidden" name="brd_no" value="<%=brd_no%>">
             <input type="hidden" name="recipient" value="<%=recipient%>">
             <input type="hidden" name="recipient_name" value="<%=recipient_name%>">
             <input type="hidden" name="ref" value="<%=ref%>">
             <input type="hidden" name="ref_step" value="<%=ref_step%>">
             <input type="hidden" name="ref_level" value="<%=ref_level%>">
             <input type="hidden" name="work_flag" value="<%=work_flag%>">
             <input type="hidden" name="real_file" value="">
             <input type="hidden" name="sys_file" value="">

                  <table  border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td> 
                      
                      <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width=30 height="1" bgcolor="D3D2C3"></td>
                            <td width=50 height="1" bgcolor="D3D2C3"></td>
                            <td width=320 height="1" bgcolor="D3D2C3"></td>
                            
                          </tr>
                          <tr height="30">
                            <td colspan=2 align=center  bgcolor="F2F1E2" >수신자</td>
                            <td style="padding-left:5;"><input type="text" id=TEXT7 name="brd_recipient" value="<%=recipient%>" size="10" maxlength="7" class=textbox  readOnly="true">
                            	<input type="text" id=TEXT8 name="brd_recipient_name" value="<%=recipient_name%>" size="10" maxlength="20" class=textbox  readOnly="true">
	  							<input type="hidden" name="brd_creator" size="20" ID="Text2" value="<%=writer%>" class=textbox readonly>
                            <input type="hidden" name="brd_creator_name" size="20" ID="Text2" value="<%=writer_name%>" class=textbox readonly>
                            <input type="hidden" name="brd_passwd" size="14" maxlength='4' ID="Text3" value="0" class=textbox>
                            <input type="hidden" name="brd_subject" maxlength="40" size="10" ID="Text1" value="쪽지제목" class=textbox></td>
                          </tr>
                          <tr> 
                            <td colspan=3 height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td colspan=3 style="padding: 6 6 6 6 ;" align=center>
							<!-- 본문 : 에디터 사용 2098-03-12 by 심동현 -->
							<FCK:editor id="brd_contents" basePath="/FCKeditor/" 
								width="440" height="300" 
								toolbarSet="memo_write" 
								imageBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
								linkBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector"
								flashBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=connectors/jsp/connector"
								imageUploadURL="/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Image"
								linkUploadURL="/FCKeditor/editor/filemanager/upload/simpleuploader?Type=File"
								flashUploadURL="/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Flash">
								<%=content%>
							</FCK:editor>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan=3 height="1" bgcolor="D3D2C3"></td>
                          </tr>

			</form>                          

						<% //파일이 있는 경우 (수정화면 또는 최초입력시 파일을 업로드한 경우가 아닐지
						if(fileRecord != null){                                                                
							StringBuffer sb = new StringBuffer();                                             
							String viewVirtual_name = "";                                                     
							String viewReal_name = "";                                                        
						                                                       
							for(int j=0; j<fileRecord.length; j++){	//파일 갯수만큼
								Tbrd_attach_file_de_bean fbean = fileRecord[j];                                
								                                                       
								virtual_name		= Util.getString(fbean.getVirtual_name(),"");                  
								real_name			= Util.getString(fbean.getReal_name(),"");                       
						
								String img_name =  virtual_name;                                               
							                                                       
								if(virtual_name.lastIndexOf("/")>0){                                           
									viewVirtual_name = virtual_name.substring(virtual_name.lastIndexOf("/")+1);
								}                                                                              
								if(real_name.lastIndexOf("/")>0){                                              
									viewReal_name = real_name.substring(real_name.lastIndexOf("/")+1);         
								}                                                                              
								System.out.println("viewVirtual_name=>"+viewVirtual_name);               
								System.out.println("viewReal_name=>"+viewReal_name);                          
								
								//첨부란에 넣을 html코드 만들기                     
								sb.append("<option value='"+viewVirtual_name +"'>"+viewReal_name+"</option>"); 
							}                                                                                 
							fullFilename = sb.toString();                                                     
						}                                                                                    
						%> 
                          
						<!-- 파일 첨부용 폼-->
						<form name="fileForm" method="post" encType="multipart/form-data">
						<input type="hidden" name="realFileName">
						<input type="hidden" name="virtualFileName">
						<input type="hidden" name="mode">                          
                          <tr> 
                            <td bgcolor="F2F1E2" align=center>파<br>일<br>첨<br>부</td>
                            <td colspan=2 style="padding-left:10;padding-top:5px"><!-- 파일 복수 업로드 -->
							  <table width="100%" cellpadding="0" cellspacing="0" border=0>
								<tr>
								  <td width="305"><input type="text" name="file1" id="file1" style="width:300px;" value="첨부파일은최대5M까지가능합니다." readonly  class=textbox></td>
								  <td style="padding-left:8px">
                                      <div style="position:relative;left:0px;top:0px;height:19;width:40;background-image:url(http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_filesch.gif);background-repeat:no-repeat;">
                                      <input type='file' name='file_nm' onChange="this.form.file1.value=this.value" style="width:40;height:19;filter:alpha(opacity=0);"></div>
								  </td>
								</tr>
								<tr><td height="5" colspan="2"></td></tr>
								<tr>
								  <td>
									<select multiple name="fileList" style="width:300px;height:68px;border-color:#666666;background-color:#F5F2FB;font-weight:bold;">
                                         <%=fullFilename%>
									</select>
								  </td>
								  <td style="padding-left:8px" valign=top>
									<a href="javascript:tempUpload()"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_upload.gif" border=0></a><br>
									<a href="javascript:fileDelete()"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_del.gif" border=0></a>
								  </td>
								</tr>
							  </table>
							  ※ <B>파일명을 영문</B>으로 올려주셔야 다운로드가 정상 작동합니다.
							</td>
                          </tr>
						</form>

						<!-- 파일 삭제용 폼-->
						<FORM METHOD=POST NAME="file_del">
						<input type="hidden" name="realFileName">
						<input type="hidden" name="virtualFileName">
						<input type="hidden" name="saveDir">
						<input type="hidden" name="mode">
						<input type="hidden" name="brd_gu" value="<%=brd_gu%>">
						</FORM> 
						<!-- 파일 임시 업로드용 iFrame -->
						<iframe name="tempUpload" width="0" height="0" src="about:blank"></iframe>		
					                       
                          <tr> 
                            <td colspan=3 height="1" bgcolor="D3D2C3"></td>
                          </tr>
			              <tr>
			                <td colspan=3 align="center" style="padding-top:5px"><a href="javascript:send_ok();"><img src="<%=dirPath%>/Sales/images/b_ok.gif" alt="" border="0"></a>&nbsp;&nbsp;<a href="javascript:cancel();"><img src="<%=dirPath%>/Sales/images/b_cancel.gif" alt="" border="0"></a></td>
			              </tr>                          
                        </table>
                        
                        </td>
                    </tr>
                    <tr> 
                      <td height="50" align="center">&nbsp;</td>
                    </tr>
                  </table>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

<script language=javascript>
var workFlag = "<%=work_flag%>";
if(workFlag=="INSERT"){
	get_cookdata();
	document.form1.brd_creator.value=GetCookie("vusrid");//+ "("+GetCookie("vusrid")+")";
//	document.form1.brd_subject.focus();
};
</script>

<script language=javascript>
var workFlag = "<%=work_flag%>";
if(workFlag=="INSERT"){
	get_cookdata();
	document.form1.brd_creator_name.value=GetCookie("vusrnm");//+ "("+GetCookie("vusrid")+")";
//	document.form1.brd_subject.focus();
};
</script>
