<%-- 
  - �ۼ���: ������
  - ����: 2006.05.26
  -������:�̼ҿ�(2006.07)  
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ������>���� ���� ���� �űԵ�� or ����

--%> 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%@ include file="/common/logincheck.jsp"  %>	<%//�α��� üũ %>

<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));

//���� ����
String cmd	= "";
String board_type = "";
String title= "";
String content	= "";
String user_id = "";
String user_name = "";
String regdate = "";
int read_num = 0;
String use_yn = "";
String type_code = "";
String type_name = "";
String virtual_name	= "";
String real_name		= "";
int recomm_num = 0;
String fullFilename	= "";
boolean deleteYn = false;


StringBuffer fileNameList = new StringBuffer();

Tbrd_attach_file_de_bean[] fileRecord = null;

if (board_seq > 0){
	//DAO
	TourGalleryBoard dao = new TourGalleryBoard();
    //DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title					  = bean[0].getTitle();
	content					  = bean[0].getContent();
	content					  = content.replaceAll("\"", "'");
	user_id					  = bean[0].getUser_id();
	regdate					  = bean[0].getReg_date_String();
	read_num				  = bean[0].getRead_num();
	user_name					= bean[0].getUser_name();
	virtual_name = bean[0].getVirtual_name();
	real_name   = bean[0].getReal_name();
    recomm_num = bean[0].getRecomm_num();

	fileRecord = dao.getFileView(board_seq);
	
	Tbrd_attach_file_de_bean tBean = null;
	  for(int i=0; i<fileRecord.length; i++){
		tBean =  (Tbrd_attach_file_de_bean)fileRecord[i];
		fileNameList.append(tBean.getVirtual_name());
		if(fileRecord.length-1>i){
			fileNameList.append(",");
		}
	  }


    //�ڱⰡ �� �۸� ���� ����
	if(user_id.equals(session_id)) deleteYn = true;


	cmd = "edit";
}else{
	cmd = "insert";
	user_id = session_id;
    user_name = session_name;
	regdate = Util.getDate();
}


String McNum = "5";
String sub = "4";
String pageNum = "4";
String subNum = "1";
%>
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--


function chk(){	
	


	f = document.mainForm;
	ff = document.fileForm;



	if(f.title.value==""){
		alert("������ �Է��ϼ���.");
		f.title.focus();
		return;
	}else{
	    var intDataLength = f.title.value.length;
		if(intDataLength > 200)
		{
			alert("������ 200�� �̳��θ� �Է��� �����մϴ�.");
			f.title.value = f.title.value.substr(0, 200);
			return;
		}
	
	}

	
	
  
    if(f.content.value==""){
		alert ("������ �Է����ּ���");
		f.content.focus();
		return;
	}else{
	    var intDataLength = f.content.value.length;
		if(intDataLength > 10000)
		{
			alert("������ 10000�� �̳��θ� �Է��� �����մϴ�.");
			f.content.value = f.content.value.substr(0, 10000);
			return;
		}
	
	}

	
	if(ff.fileList.options.length > 0)
	{
		f.virtualFileList.value = "";
		f.realFileList.value = "";
		for(i=0;i<ff.fileList.options.length;i++)
		{
		  if(i==0){
			  f.virtualFileList.value += ff.fileList.options[i].value;
			  f.realFileList.value += ff.fileList.options[i].text;
		  }else{
		    f.virtualFileList.value += "|"+ff.fileList.options[i].value;
		    f.realFileList.value += "|"+ff.fileList.options[i].text;
		  }
		}
	}else{
			alert("������ ���ε� ���ּ���.");
			return;
	}

	//alert(f.virtualFileList.value +"/"+ f.realFileList.value);

	f.submit();

}


function del(){
	f = document.mainForm;

	if(confirm("�Խù��� �����Ͻðڽ��ϱ�?")){
		f.cmd.value = "del";
	    f.submit();
	}else{
		return;
	}
}




//���Ͼ��ε� 5
//���� �̹����� ���
var oldFileNames = "<%=fileNameList.toString()%>";



//���Ͼ��ε� 1
//�̹��� ������ �ø���
function tempUpload()
{
	//document.domain="imjk.co.kr";
	f = document.fileForm;
    //alert(f);
	if(f.file1.value.length == 0 || f.file1.value == "÷������ �ѿ뷮 ���� : 5M")
	{
		alert('���ε��� ������ �����Ͽ� �ֽʽÿ�');
		return;
	}

  var realFileName = f.file1.value;

	var idx = realFileName.lastIndexOf("\\");
	realFileName = realFileName.substring(idx+1);
	
	if(realFileName.indexOf(".mp3") > 0 ||realFileName.indexOf(".wma") > 0 || realFileName.indexOf(".asf") > 0){
		alert("���۱� ������ ������ �ִ� mp3, wma, asf ������ �������� ÷�δ� ���� �ʽ��ϴ�.");
	  	return;
	}
	strArray = realFileName.split("."); 
	strArray2 = realFileName.split("|"); 
  
	//�����̸��� [.] �� ������ �ȵȴ�.(Ȯ���� ����)
	if(strArray.length > 2){
	  alert("�����̸��� '.' �� ������ �����Ͽ� �ֽʽÿ� ");
	  return;
	}
	
	if(strArray.length < 1){
	  alert("Ȯ���ڸ��� �ݵ�� �־�� �մϴ�.  ");
	  return;
	}
  //�����̸��� [|] �� ������ �ȵȴ�.
	if(strArray2.length > 1){
	  alert("�����̸��� '|' �� ������ ��� �����Ͽ� �ֽʽÿ� ");
	  return;
	}
	
	f.target="tempUpload";
	f.realFileName.value=realFileName;
	f.mode.value="insert";
	 
	f.action = "./tour_gallery_upload.jsp";
	f.submit();

	
}


//���Ͼ��ε� 2
// ���� ��Ͽ� �߰�
function addFileList(realName, virtualName)
{
	f = document.fileForm;

	if(realName!="")
	{
		
		f.fileList.options[f.fileList.options.length] = new Option(realName,virtualName);
			
	}
	f.file1.value ="÷���������ִ�5M���������մϴ�." ;  //f.file1.title;

}


//���Ͼ��ε� 3
// ���� ��Ͽ��� ���� 
function fileDelete()
{
	f = document.fileForm;
  
	if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0)
	{
		alert('������ ������ ������ �ֽʽÿ�');
		f.fileList.focus();
		return;
	}	

	if(confirm('������ ���� �Ͻðڽ��ϱ�?'))
	{
		var i = f.fileList.options.selectedIndex;
		var select_val = f.fileList.options[i].value;
		var realFileName = f.file1.value;
    var fileArray = oldFileNames.split(",");


		  
		 //******** START ������ �ִ� �������� ���� ***********/
		 var isNew = "i_del";
		 

		 if(fileArray.length>1){
				 for(j=0;j< fileArray.length;j++){
				    tempFileName = fileArray[j];
				   if(tempFileName == select_val){
				      isNew = "u_del";
				      break;
				    }
				 }
		}
		 
		if(fileArray.length <=1){
		   if(oldFileNames == select_val){
				      isNew = "u_del";
			}
		
		}
		 
		  //******** END  ������ �ִ� �������� ���� ***********/
		 
		 
		
		document.file_del.target="tempUpload";
		document.file_del.realFileName.value=realFileName;
		document.file_del.virtualFileName.value = select_val;
		document.file_del.saveDir.value = "memGalleryUpload";
		document.file_del.mode.value=isNew;
		document.file_del.action = "../../../common/deleteFile.jsp";
		document.file_del.submit();
	}
}


//���Ͼ��ε� 4
// ������ �������� ���� �� ����Ʈ���� ����
function delResult(){

	f = document.fileForm;

	idx = f.fileList.selectedIndex;
	cnt = f.fileList.options.length;
	for(i=idx;i< f.fileList.options.length-1;i++)
	{
		f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
	}
	f.fileList.options[cnt - 1] = null;
	f.file1.value = "÷���������ִ�5M���������մϴ�.";
}

//�̹��� ������ ����
function resizeImg(obj){
	//a=document.images.i0;
	//alert(obj.width+'x'+obj.height+'='+obj.fileSize);
	if(obj.width > 450){
		obj.width = 450;
	}
}

//-->
</SCRIPT>

</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/community/tour_gallery_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../../include/community/tour_gallery_left.jsp" %>
            <!--  left menu flash -->
            </td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm04.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">Ŀ�´�Ƽ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">ȸ��������</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
                <FORM METHOD=POST name="mainForm" ACTION="tour_gallery_ok.jsp" >
                <INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
                <INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
                <INPUT TYPE="hidden" name="part" value="<%=part%>">
                <INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
                <INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
                <input type="hidden" name="realFileList" value="">
                <input type="hidden" name="virtualFileList" value="">
                <input type="hidden" name="returnUri" value="<%=nowUri%>">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr>
					<td>
						<table width="690" height="166" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/community/bg_top_comm04.jpg');fixed no-repeat left top;">
						<tr><td valign="bottom" class="bpad_12"><img src="<%=imageServer%>/tour_img/community/stit_comm04.gif" hspace="5"></td></tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / view table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="2" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_write01.gif"><!-- ���� --></td>
							<td ><input type="text" name="title" style="width:597px;" value="<%=title%>"></td>
						</tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_write02.gif"><!-- �ۼ��� --></td>
							<td class="tpad_3"><%=user_name%>(<%=user_id%>)</td>
						</tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr><td height="6" colspan="2"></td></tr>
						<tr>
							<td height="218" align="right"><img src="<%=imageServer%>/tour_img/txt_write04.gif" style="margin-right:17px;"><!-- ���� --></td>
							<td ><textarea name="content" style="width:597px;height:218px;"><%=content%></textarea></td>
						</tr>
                  <% 
                  		if(fileRecord != null){ 
                  %>						
						<tr>
						<td height="26" align="right" ></td>
						<td >
                           <%
                           StringBuffer sb = new StringBuffer();
                           String viewVirtual_name = "";
                           String viewReal_name = "";
                           
                           for(int j=0; j<fileRecord.length; j++){
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
                           		
                           		sb.append("<option value='"+viewVirtual_name +"'>"+viewReal_name+"</option>");
                           		
                           %>
                           <img src="<%=img_name%>" onload=resizeImg(this)><br>
                           <%
                           }
                           fullFilename = sb.toString();
                           %>						
						</td>
						</tr>
                     <%
                     		} 
                     %>
                     </FORM>
						<tr><td height="6" colspan="2"></td></tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr><td height="6" colspan="2"></td></tr>
                     <form name="fileForm" method="post" encType="multipart/form-data">
                     <input type="hidden" name="realFileName">
                     <input type="hidden" name="virtualFileName">
                     <input type="hidden" name="mode">						
						<tr>
							<td height="94" align="right"><img src="<%=imageServer%>/tour_img/txt_write05.gif" style="margin-right:17px;"><!-- �̹���÷�� --></td>
							<td >
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
								  <td width="455"><input type="text" name="file1" id="file1" style="width:450px;" value="÷���������ִ�5M���������մϴ�." readonly></td>


								  <td style="padding-left:8px">
                                      <div  style="position:relative;left:0px;top:0px;height:19;width:40;background-image:url(http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_filesch.gif);background-repeat:no-repeat;">
                                      <input type='file' name='file_nm' onChange="this.select(); document.getElementById('file1').value=document.selection.createRange().text.toString();" style="width:40;height:19;filter:alpha(opacity=0);"></div>
								  </td>

								</tr>
								<tr><td height="5" colspan="2"></td></tr>
								<tr valign="top">
									<td>
									<select multiple name="fileList" style="width:450px;height:68px;border-color:#666666;background-color:#F5F2FB;font-weight:bold;">
                                         <%=fullFilename%>
									</select>
									
									</td>
									<td style="padding-left:8px">
										<a href="javascript:tempUpload()"><img src="<%=imageServer%>/tour_img/btn/btn_s_upload.gif"></a>
										<a href="javascript:fileDelete()"><img src="<%=imageServer%>/tour_img/btn/btn_s_del.gif"></a>
									</td>
								</tr>
								</table>
							</td>
						</tr>
					</form>
						<tr><td height="6" colspan="2"></td></tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						</table>
						<!-- view table / -->

						<!-- /button -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td height="13"></td></tr>
						<tr>
							<td align="right">							
								    <%if(board_seq>0){%>
									<a href="javascript:chk()"> <img src="<%=imageServer%>/tour_img/btn/btn_comm_modify.gif" class="btn"></a>
									  

									    <%if(deleteYn){%>
										     <a href="javascript:del()">
							                   <img src="<%=imageServer%>/tour_img/btn/btn_comm_delete.gif" class="btn">
							                  </a>
								        <%}%>
									<%}else{%>
									    <a href="javascript:chk()"><img src="<%=imageServer%>/tour_img/btn/btn_comm_regis.gif" class="btn"></a>
									<%}%>
									   <a href="tour_gallery.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_comm_listview.gif" class="btn"></a>
							</td>
						</tr>
						</table>
						<!-- button/ -->
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>
<FORM METHOD=POST NAME="file_del">
<input type="hidden" name="realFileName">
<input type="hidden" name="virtualFileName">
<input type="hidden" name="saveDir">
<input type="hidden" name="mode">
<input type="hidden" name="board_type" value="<%=board_type%>">
</FORM> 
<iframe name="tempUpload" width="0" height="0" src="about:blank">
</iframe>		
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->       
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>