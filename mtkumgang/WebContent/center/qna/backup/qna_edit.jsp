<%--
  - �ۼ���: ������
  - ����: 2006.06.07
  - ���۱� ǥ��: IMJ Korea
  - ����: ����� - ������>������ϱ�
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.QnABoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>

<%

//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));
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
	//content					= content.replaceAll("\"", "'");
	user_id					= bean[0].getUser_id();
	user_name = bean[0].getUser_name();
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	use_yn					= bean[0].getUse_yn();
	open_yn					= bean[0].getOpen_yn();
	password					= bean[0].getPassword();
    email	= bean[0].getEmail();
	tel	= bean[0].getTel();

	cmd = "edit";
}else{
	user_id = session_id;
    user_name = session_name;
	cmd = "insert";
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

//ȸ�� üũ
if(!session_id.equals("")){
	isMember = true;
}


//��ȸ���� ����� ���϶� ���� ��ư ����
if(session_id.equals("")){
	deleteYn = true;
    eidtYn = true;
}


//�ڱⰡ �� �۸� ���� ��ư ����
if(user_id.equals(session_id)){
	deleteYn = true;
	eidtYn = true;
}




//out.println("pageCount: "+pageCount);
//out.println("dataNum: "+dataNum);

%>


<html>
<head>
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>
<SCRIPT LANGUAGE="JavaScript">
<!--


function chk(){	
	


	f = document.mainForm;
    
    if(f.qnaTitle.value==""){
		alert ("������ �Է����ּ���");
		f.qnaTitle.focus();
		return;
	}

	//alert("title=|"+f.title.value+"|");
	
	if(f.writer.value==""){
		alert ("�ۼ����� �Է����ּ���");
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


	if(f.password != null){
		if(f.password.value == "" ){
	      alert ("�н����带 �Է��Ͽ� �ֽʽÿ�");
		  f.password.focus();
		  return;
	   }

	   if(f.passwordRe.value == "" ){
	      alert ("�н�����Ȯ���� �Է��Ͽ� �ֽʽÿ�");
		  f.passwordRe.focus();
		  return;
	   }


	   if(f.password.value !=f.passwordRe.value ){
	      alert ("�н����尡 ��ġ���� �ʽ��ϴ�. ��Ȯ�ϰ� �Է��Ͽ� �ֽʽÿ�");
		  f.password.value="";
		  f.passwordRe.value="";
		  f.password.focus();
		  return;
	   }
	}
  
    if(f.content.value==""){
		alert ("������ �Է����ּ���");
		f.content.focus();
		return;
	}




   f.submit();


}


function del(){

	f = document.mainForm;

	f = document.mainForm;
	if(f.password != null){
		if(f.password.value == "" ){
	      alert ("�н����带 �Է��Ͽ� �ֽʽÿ�");
		  f.password.focus();
		  return;
	   }

	   if(f.passwordRe.value == "" ){
	      alert ("�н�����Ȯ���� �Է��Ͽ� �ֽʽÿ�");
		  f.passwordRe.focus();
		  return;
	   }


	   if(f.password.value !=f.passwordRe.value ){
	      alert ("�н����尡 ��ġ���� �ʽ��ϴ�. ��Ȯ�ϰ� �Է��Ͽ� �ֽʽÿ�");
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

 var special = ' ~!#$%^&*()-_=+|\\{}[];:"\'<>,?\/';//Ư�������߿� '@' �� ' . ' �� ��������.
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
<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<TR valign=top>
                <!-- main -->
                <TD width=650 valign=top>
                	<table width=650 border=0 cellspacing=0 cellpadding=0>
                	<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                			 <td class='title'><img src=<%=imageServer%>tour_img/bu_blue_title.gif align=texttop class=rmar10>������ϱ�</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
					<FORM METHOD=POST name="mainForm" ACTION="qna_ok.jsp" >
					<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
					<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
					<INPUT TYPE="hidden" name="part" value="<%=part%>">
					<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
					<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
					<INPUT TYPE="hidden" name="position" value="<%=position%>">
					<INPUT TYPE="hidden" name="user_id" value="<%=user_id%>">
					<INPUT TYPE="hidden" name="user_name" value="<%=user_name%>">
<%="session_id==|"+session_id+"|"%>
         			<table width=100% border=0 cellspacing=0 cellpadding=0>
         				<col width=100>
         				<tr><td colspan=6 height=2 class=linec1></td></tr>
         				<tr height=28>
         					<td class='tdcolor th' align=center>����</td>
         					<td class=lpad10 colspan=7>
         					<input type=text name=qnaTitle style=width:300; value="<%=title%>">
         					</td>
         				</tr>
         				<tr><td colspan=6 height=1 class=linec0></td></tr>
         				<tr height=28>
         					<td class='tdcolor th' align=center>�ۼ���</td>
         					<td class=lpad10>
							<%if(isMember){%>
							<input type=text name=writer style=width:100; value="<%=user_name%>(<%=user_id%>)" readonly></td>
         					<%}else{%>
							   <!--��ȸ��-->
							   <%if(board_seq>0){%>
							        <input type=text name=writer style=width:100; value="<%=user_name%>" readonly ></td>
							   <%}else{%>
							        <input type=text name=writer style=width:100; value=""></td>
                               <%}%>
							<%}%>
							<td class='tdcolor th' align=center>����ó</td>
         					<td class=lpad10>
         					<input type=text name=tel01 style=width:30; value="<%=tel01%>" >-
         					<input type=text name=tel02 style=width:30; value="<%=tel02%>" >-
         					<input type=text name=tel03 style=width:30; value="<%=tel03%>" >
         					</td>
         				</tr>
         				<tr><td colspan=6 height=1 class=linec0></td></tr>    
         				<tr height=28>
         					<td class='tdcolor th' align=center>�̸���</td>
         					<td class=lpad10><input type=text name=email style=width:100; value="<%=email%>"></td>
         					<td class='tdcolor th' align=center>����/�����</td>
         					<td class=lpad10><input type=radio name=open_yn value="1" <%if(open_yn.equals("1")){%>checked<%}%>>���� &nbsp;<input type=radio name=open_yn value="0" <%if(open_yn.equals("0")){%>checked<%}%>>�����</td>
         				</tr>
         				<tr><td colspan=6 height=1 class=linec0></td></tr>
         				<!-- ������ -->
						<%if(board_seq>0){%>
							<!--��й�ȣ�� �ɷ� ������ ���� -->
							<%if(!password.equals("")){%>
							<tr height=28>
								<td class='tdcolor th' align=center>��й�ȣ</td>
								<td class=lpad10 ><input type=password name=password style=width:100; value=""></td>
								<td class='tdcolor th' align=center>��й�ȣ Ȯ��</td>
								<td class=lpad10 ><input type=password name=passwordRe style=width:100; value=""></td>
							</tr>
							<%}%>
						<!-- ���� ��Ͻ� -->
						<%}else{%>
							<!--��ȸ�� �۾��� -->
							<%if( session_id == null || session_id.trim().equals("") ){%>
							<tr height=28>
								<td class='tdcolor th' align=center>��й�ȣ</td>
								<td class=lpad10 ><input type=password name=password style=width:100; value=""></td>
								<td class='tdcolor th' align=center>��й�ȣ Ȯ��</td>
								<td class=lpad10 ><input type=password name=passwordRe style=width:100; value=""></td>
							</tr>
							<%}%>

						<%}%>
         				<tr><td colspan=6 height=1 class=linec0></td></tr>         				
         				<tr height=28>
                          <td class='tdcolor th' align=center valign=top style=padding-top:7;>���ǳ���</td>
                          <td colspan=4 class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top>
                             <textarea name=content cols=60 rows=10><%=content%></textarea>
                          </td>
         				</tr>
         				<tr><td colspan=6 height=1 class=linec1></td></tr>
         				</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
								 <%if(board_seq>0){%>
								 <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=�����ϱ� class=btn onclick="javascript:chk()"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>
								 <%}else{%>
                                  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=�����ϱ� class=btn onclick="javascript:chk()"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>
                                 <%}%>
                                 
								   <% if(deleteYn){%>
										 <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=�����ϱ�  class=btn onclick="javascript:del()" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								   <%}%>
								  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=��Ϻ��� class=btn onclick="location.href='qna_list.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>'"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>
                                 </td>
                				</tr>
                			</table>
                
                			<table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
                		</td>
                	</tr>
					</FORM>
                	</table>
                </TD>
                <!-- //main -->
         </TR>
      </TABLE>
</BODY>
</HTML>

