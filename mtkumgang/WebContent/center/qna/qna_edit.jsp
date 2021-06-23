<%-- 
  - �ۼ���: ������
  - ����: 2006.06.07
  - ������ : �̼ҿ� 
  - ���� : 2006.07
  - ���۱� ǥ��: IMJ Korea
  - ����: ����� - ������>������ϱ�
--%>
 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>


<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.QnABoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>

<%

//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= clearXSS(ParamUtil.getReqParameter(request.getParameter("part")),avatag );
String keyword    	= clearXSS(ParamUtil.getReqParameter(request.getParameter("keyword")),avatag );
int position = Util.parseInt(request.getParameter("position"), 1);
// �˻� - �Ķ����
String key_str = "&part="+part+"&keyword="+keyword;
//������ ������
String page_str = "&page="+requestedPage+"&position="+position;


//���� ����
int ref_no				= 0; 
int read_num			= 0;
String title			= ""; 
String content		= "";
String type_code  = "";
String type_name = "";
String use_yn			= "";
String user_id		= "";
String user_name =""; 
String regdate = "";
String password = "";
int pageSize			= 10;
int blockSize			= 10;
//�Խ��� Ÿ�԰���
String boardType	= "06";
String open_yn = "1";
String tel01 = "";
String tel02 = "";
String tel03 = "";
String email =""; 
String tel ="";
String cmd ="";

String pageNum = "2";
String McNum = "6";
String sub = "2";

boolean isMember = false;
boolean deleteYn = false;
boolean eidtYn = false;


//DAO
QnABoard dao = new QnABoard();


if(board_seq>0){
	
	
//DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title						= bean[0].getTitle();
	content					= bean[0].getContent();
	content					= content.replaceAll("\"", "'");
	user_id					= bean[0].getUser_id();
	user_name = bean[0].getUser_name();
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	use_yn					= bean[0].getUse_yn();
	open_yn					= bean[0].getOpen_yn();
	password				= bean[0].getPassword();
    email	                = bean[0].getEmail();
	tel	                    = bean[0].getTel();

	cmd = "edit";
	
}else{
	
	user_id = session_id;
    user_name = session_name;
	cmd = "insert";
	
}

//ȸ�� üũ
if(!session_id.equals("")){
	isMember = true;
}


//��ȸ���� ����� ���϶� ���� ��ư ����
// ���� - �űԵ���� ��� �ش� �ȵ�

if(board_seq > 0 && session_id.equals("")){
	deleteYn = true;
    eidtYn = true;
}

//�ڱⰡ �� �۸� ���� ��ư ����
// ���� - �űԵ���� ��� �ش� �ȵ�, �α��� ���� üũ �߰�
if(board_seq > 0 && session_id != "" && user_id.equals(session_id)){
	deleteYn = true;
	eidtYn = true;
}

//�߰� - �α����� ȸ�� �̸��� �� ����ó ��������
if(!session_email.equals("")){
   email = session_email;
}
if(!session_tel.equals("")){
   tel = session_tel;
}


//��ȭ��ȣ �и��ϱ�
if(!tel.equals("")){
    String[] telArray = Util.getItemArray(tel,'-');

	if(telArray != null && telArray.length == 3){
	   tel01 = telArray[0];
	   tel02 = telArray[1];
	   tel03 = telArray[2];
	}  
}

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

	if (!f.privacy_chk[0].checked == true){
	    alert("����������޹�ħ�� ������ �ֽʽÿ�.");
	    return;
	}
    
    if(f.qnaTitle.value==""){
		alert ("������ �Է� �ϼ���");
		f.qnaTitle.focus();
		return;
	}
	
	if(f.writer.value==""){
		alert ("�ۼ����� �Է� �ϼ���");
		f.writer.focus();
		return;
	}

    var tel = f.tel01.value +f.tel02.value+f.tel03.value;

    if(tel !=""){
		if(valid_tel(f.tel01, f.tel02, f.tel03)){
		}else{
			return;
		}
	}


	if(f.email.value!=""){
        if(valid_email(f.email)){
		}else{
			return;
		}
	}
    
    
    //�߰�
	if(f.email != null){
		if(f.email.value == "" ){
	      alert ("�̸����� �Է� �ϼ���");
		  f.email.focus();
		  return;
	   }
	}
    

	if(f.password != null){
		if(f.password.value == "" ){
	      alert ("��й�ȣ�� �Է� �ϼ���");
		  f.password.focus();
		  return;
	   }

	   if(f.passwordRe.value == "" ){
	      alert ("��й�ȣȮ���� �Է� �ϼ���");
		  f.passwordRe.focus();
		  return;
	   }


	   if(f.password.value !=f.passwordRe.value ){
	      alert ("��й�ȣ�� ��ġ���� �ʽ��ϴ�. ��Ȯ�ϰ� �Է� �ϼ���");
		  f.password.value="";
		  f.passwordRe.value="";
		  f.password.focus();
		  return;
	   }
	}
  
    if(f.content.value==""){
		alert ("������ �Է� �ϼ���");
		f.content.focus();
		return;
	}




   f.submit();


}


function del(){

	f = document.mainForm;
	if(f.password != null){
		if(f.password.value == "" ){
	      alert ("��й�ȣ�� �Է� �ϼ���");
		  f.password.focus();
		  return;
	   }

	   if(f.passwordRe.value == "" ){
	      alert ("��й�ȣȮ���� �Է� �ϼ���");
		  f.passwordRe.focus();
		  return;
	   }


	   if(f.password.value !=f.passwordRe.value ){
	      alert ("��й�ȣ�� ��ġ���� �ʽ��ϴ�. ��Ȯ�ϰ� �Է� �ϼ���");
		  f.password.value="";
		  f.passwordRe.value="";
		  f.password.focus();
		  return;
	   }
	}

	if(confirm("�Խù��� �����Ͻðڽ��ϱ�?")){
		f.cmd.value = "del";
	    f.submit();
	}else{
		return;
	}
}


function valid_email(ele) { 
  /**********************************************************************************
 *�̸��� üũ�ϴ� �ڹ� ��ũ��Ʈ
 1.�̸����� �Է��ߴ��� üũ�Ѵ�.
 2.�̸��Ͽ� '@' �� '.'�� �ִ��� üũ�Ѵ�.
 3.�̸��Ͽ� �ѱ۰� Ư�����ڰ� �ִ��� üũ�Ѵ�.
 ***********************************************************************************/
 
 /*
 if(ele.value=="")
 {
  alert("�̸����� �Է��ϼ���");
  ele.focus();
  return false;
 }
*/

 if(((ele.value.indexOf('@')) <= 0) && (ele.value.indexOf('.') <= 0) )
 {//@�� . �� ���� ���� �ʴ´ٸ� alertâ ����
  alert("�������� �̸����� �ƴմϴ�.");
  ele.value="";
  ele.focus();
  return false;
 }

 var special = ' ~!#$%^&*()=+|\\{}[];:"\'<>,?\/';//Ư�������߿� '@' �� ' . ' �� ��������.
 for(var i = 0 ; i < ele.value.length; i++)
 {//�ѱ۰� Ư�����ڸ� ���� ���ϰ� �ϴ� ����

     var email_check = ele.value.charAt(i);//�̸��� �Է����� ���� �ϳ��� �����´�.

      if(((email_check >= "��") && (email_check <= "��")) || ((email_check >="��") && (email_check <="��")))
      {//��� �ѱ��� Ȯ���ϴ� ���� 
             alert("�̸��Ͽ��� �ѱ��� �ȵ˴ϴ�.");
             ele.value="";
             ele.focus();
             return false;
      }
	  for(var j=0; j<special.length;j++)
	  {//Ư�����ڸ� Ȯ���ϴ� ����.�̸� ��ϵ� Ư�����ڸ� �ϳ��� �����´�.
		   if(email_check == special.charAt(j))
		   {//�̸��� �Է����� ���ڸ� �ϳ��� �����ͼ� �̸� ��ϵ� Ư�����ڸ� ���Ͽ� ���ٸ� Ư��������. 
			alert("�̸��Ͽ��� Ư�� ���ڰ� �ȵ˴ϴ�.");
			ele.value="";
			ele.focus();
			return false;
		   }
	  }
  
 }

  return true;
} 


function valid_tel(ele01,ele02,ele03) { 
/**********************************************************************************
 *��ȭ��ȣ üũ�ϴ� �ڹ� ��ũ��Ʈ
 1.��ȭ��ȣ�� �Է��ߴ��� üũ�Ѵ�.
 2.��ȭ��ȣ�� �ڸ����� üũ�Ѵ�.
 3.��ȭ��ȣ�� �������� üũ�Ѵ�.
 ***********************************************************************************/
 if(ele01.value=="")
 {
  alert("��ȭ��ȣ�� �Է��ϼ���");
  ele01.focus();
  return false;
 }

 if(ele01.value.length < 2 )
 {//ù��° ��ȭ��ȣ�� �ڸ����� 2�����̸� alertâ ����
        alert("��ȭ��ȣ �ڸ����� Ʋ���ϴ�.");
  ele01.value.length="";
  ele01.value="";
  ele01.focus();
  return false;
 }

  for(var i=0;i<ele01.value.length;i++)
 {//ù��° ��ȭ��ȣ���� ���ڸ� ����־�� �Ѵ�.�׷��� ������ alertâ ����.
    var ch1 = ele01.value.substring(i,i+1);
    if (ch1<'0' || ch1>'9') 
	{
		alert("���ڸ� �Է��ϼ���");
		ele01.value="";
		ele01.focus();
		return false;
	}
 }

 
 if(ele02.value=="")
 {
  alert("��ȭ��ȣ�� �Է��ϼ���");
  ele02.focus();
  return false;
 }


  if(ele02.value.length < 3 )
 {//�ι�° ��ȭ��ȣ�� �ڸ����� 2�����̸� alertâ ����
        alert("��ȭ��ȣ �ڸ����� Ʋ���ϴ�.");
  ele02.value.length="";
  ele02.value="";
  ele02.focus();
  return false;
 }

  for(var i=0;i<ele02.value.length;i++)
 {//�ι�° ��ȭ��ȣ���� ���ڸ� ����־�� �Ѵ�.�׷��� ������ alertâ ����.
    var ch1 = ele02.value.substring(i,i+1);
    if (ch1<'0' || ch1>'9') 
	{
		alert("���ڸ� �Է��ϼ���");
		ele02.value="";
		ele02.focus();
		return false;
	}
 }



 if(ele03.value=="")
 {
  alert("��ȭ��ȣ�� �Է��ϼ���");
  ele03.focus();
  return false;
 }

 if(ele03.value.length < 3 )
 {//����° ��ȭ��ȣ�� �ڸ����� 2�����̸� alertâ ����
        alert("��ȭ��ȣ �ڸ����� Ʋ���ϴ�.");
  ele03.value.length="";
  ele03.value="";
  ele03.focus();
  return false;
 }

 for(var i=0;i<ele03.value.length;i++)
 {//����° ��ȭ��ȣ���� ���ڸ� ����־�� �Ѵ�.�׷��� ������ alertâ ����.
      var ch1 = ele03.value.substring(i,i+1);
      if (ch1<'0' || ch1>'9') 
	  {
	   alert("���ڸ� �Է��ϼ���");
	   ele03.value="";
	   ele03.focus();
	   return false;
	  }
  }
  
  return true;

}


//-->
</SCRIPT>

</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
                <%@ include file="../../include/center/tour_center_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174" style="border:0 solid black">
			<!--  left menu flash -->
                        <%@ include file="../../include/center/tour_center_left.jsp" %>
                        </td>
			<td>
<FORM METHOD=POST name="mainForm" ACTION="https://www.mtkumgang.com/center/qna/qna_ok.jsp" >
<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
<INPUT TYPE="hidden" name="part" value="<%=part%>">
<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
<INPUT TYPE="hidden" name="position" value="<%=position%>">
<INPUT TYPE="hidden" name="user_id" value="<%=user_id%>">
<INPUT TYPE="hidden" name="user_name" value="<%=user_name%>">

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				  <tr><td height="11"></td></tr>
				  <tr><td><img src="<%=imageServer%>/tour_img/customer/img_top_cus02.jpg"></td></tr>
				  <tr>
					<td valign="top">
						<!-- / write table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="72"><col width="1"><col width="284" class="lpad_10">
						<col width="96"><col width="217" class="lpad_10">
						<tr><td height="2" colspan="5" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write01.gif"><!-- ���� --></td>
							<td colspan="3"><input type="text"  name=qnaTitle  style="width:597px;" value="<%=title%>"></td>
						</tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_view02.gif"><!-- �ۼ��� --></td>
							<td>
							<%if(isMember){%>
							<input type="text" name=writer  style="width:273px;" value="<%=user_name%>(<%=user_id%>)" readonly>
         					<%}else{%>
							   <!--��ȸ��-->
							   <%if(board_seq>0){%>
							        <input type=text name=writer style="width:273px;" value="<%=user_name%>" readonly ></td>
							   <%}else{%>
							        <input type=text name=writer style="width:273px;" value=""></td>
                               <%}%>
							<%}%>
							</td>
							<td><img src="<%=imageServer%>/tour_img/txt_write06.gif"><!-- ����ó --></td>
							<td>					
							<input type="text" name=tel01 style="width:49px;" value="<%=tel01%>" > - 
							<input type="text" name=tel02 style="width:65px;" value="<%=tel02%>" > - 
							<input type="text" name=tel03 style="width:65px;" value="<%=tel03%>" >
							
							</td>
						</tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write07.gif"><!-- �̸��� --></td>
							<td colspan="3">
							<input type="text" name=email  style="width:273px;" value="<%=email%>">
							<input type=hidden name=open_yn value="1" class="noborder">
							</td>
							<!--td><img src="<%=imageServer%>/tour_img/txt_write08.gif"></td>
							<td>							
                                                           <%if(open_yn.equals("1")){%>checked<%}%>><strong>����</strong> &nbsp;<input type=radio name=open_yn class="noborder" value="0" <%if(open_yn.equals("0")){%>checked<%}%>><strong>�����</strong>
                                                        </td-->
						</tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						
						
						<%if(board_seq>0){%>
							<!--��й�ȣ�� �ɷ� ������ ���� -->
							<%if(!password.equals("")){%>
							<tr height=28>
								<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write09.gif"><!-- ��й�ȣ --></td>
								<td class=lpad10 ><input type=password name=password style="width:273px;" value=""></td>
								<td><img src="<%=imageServer%>/tour_img/txt_write10.gif"><!-- ��й�ȣȮ�� --></td>
								<td class=lpad10 ><input type=password name=passwordRe style="width:207px;" value=""></td>
							</tr>
							<%}%>
						<!-- ���� ��Ͻ� -->
						<%}else{%>
							<!--��ȸ�� �۾��� -->
							<%if( session_id == null || session_id.trim().equals("") ){%>
							<tr height=28>
								<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write09.gif"><!-- ��й�ȣ --></td>
								<td class=lpad10 ><input type=password name=password style="width:273px;" value=""></td>
								<td><img src="<%=imageServer%>/tour_img/txt_write10.gif"><!-- ��й�ȣȮ�� --></td>
								<td class=lpad10 ><input type=password name=passwordRe style="width:207px;" value=""></td>
							</tr>
							<%}%>

						<%}%>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						<tr><td height="6" colspan="5"></td></tr>
						<tr>
							<td height="218" align="right"><img src="<%=imageServer%>/tour_img/txt_write11.gif" style="margin-right:14px;"><!-- ���ǳ���Ȯ�� --></td>
							<td class="bg_dgray"></td>
							<td colspan="3">
							<textarea name=content style="width:597px;height:218px;"><%=content%></textarea></td>
						</tr>
						<tr><td height="6" colspan="5"></td></tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						</table>
						<!-- write table / -->

						<!-- /button -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td height="13"></td></tr>
						<tr>
							<td align="right">
							
								 <%if(board_seq>0){%>
								     <a href="javascript:chk()"><img src="<%=imageServer%>/tour_img/btn/btn_cus_modify.gif" class="btn"></a><!-- �����ϱ� -->
								 <%}else{%>
                                     <a href="javascript:chk()"><img src="<%=imageServer%>/tour_img/btn/btn_cus_question.gif" class="btn"></a><!-- �����ϱ� -->
                                 <%}%>
                                 
								   <%
								    if(deleteYn){%>
								    <a href="javascript:del()"><img src="<%=imageServer%>/tour_img/btn/btn_cus_delete.gif" class="btn"></a><!-- �����ϱ� -->
								   <%}%>
								   <a href="qna_list.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>"><img src="<%=imageServer%>/tour_img/btn/btn_cus_listview.gif" class="btn"></a><!-- ��Ϻ��� -->
								   
							</td>
						</tr>
						</table>
						<!-- button/ -->
					</td>
				  </tr>
				  <tr><td height="11"></td></tr>
				  <tr><%//�������� ���� �� �̿� ����%>
					<td height="11">



						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top">��<font color="white">�������� ���� �� �̿뿡 ���� �ȳ�</font></td>
							<td class="bg_dblue" align=right><a href="/include/privacy.jsp"><font color="yellow"><b>����������޹�ħ �ٷΰ���</b></font></a>��</td>
						</tr>
						<tr>
							<td style="padding:7 2 7 7px;" colspan=2>
<textarea id='xmlarea' name='xmlarea' rows='5' style='width : 100%;font-size : 12px;'>
�� ���������� ���� �� �̿����

ȸ��� ������ ���������� ������ ������ ���� Ȱ���մϴ�..

 �� ���� ������ ���� ��� ���� �� ���� ������ ���� �������
���� �� ��� ����
 �� ȸ�� ����
ȸ���� ���� �̿뿡 ���� ����Ȯ�� , ���� �ĺ� , �ҷ�ȸ���� ���� �̿� ������ ���ΰ� ��� ���� , �Ҹ�ó�� �� �ο�ó�� , �������� ����
 �� ������ �� ���� Ȱ��
�̺�Ʈ �� ���� ���� ���� , �α�������� Ư���� ���� ���� ���� �� ���� ���� , ���� �� �ľ� �Ǵ� ȸ���� ���� �̿뿡 ���� ���
 �� ��Ÿ
�������� ��������������



�� �����ϴ� �������� �׸�

ȸ��� ȸ������, ���, ���� ��û ����� ���� �Ʒ��� ���� ���������� �����ϰ� �ֽ��ϴ�.

�� �����׸� : �̸� , ������� , ���� , �α���ID , ��й�ȣ , ���� �ּ� , �޴���ȭ��ȣ , �̸��� , ȸ��� , ��å , �ֹε�Ϲ�ȣ , �ſ�ī�� ���� , ��Ű , ���� IP ���� , �������
�� �������� ������� : Ȩ������(ȸ������, �Խ���, ��������) , ��ȭ/�ѽ��� ���� ȸ������ , ��ǰ ��� ���� 


�� ���������� ���� �� �̿�Ⱓ

ȸ��� �������� ���� �� �̿������ �޼��� �Ŀ��� ���� ���� �ش� ������ ��ü ���� �ı��մϴ�.
</textarea>
							</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan=2></td></tr>
						<tr>
						 <td height="40" colspan=2 align=center>
							<input type="radio" name="privacy_chk" value="Y" class="noborder">����
							&nbsp;&nbsp;&nbsp;
							<input type="radio" name="privacy_chk" value="N" class="noborder">�������� �ʽ��ϴ�.
                         </td>
						</tr>
						</table>



					</td>
				  </tr>
				  <tr><td height="11"></td></tr>
				  <tr>
					<td><img src="<%=imageServer%>/tour_img/community/bottom_080307.gif"></td>
				  </tr>
				  <tr><td height="11"></td></tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
</FORM>
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