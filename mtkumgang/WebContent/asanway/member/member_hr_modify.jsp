<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/*****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 10�� 28��
* ��� ���� : ������ȸ�� ����
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.member.HrMemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>

<%
	HrMemberBean bean = new HrMemberBean();
	bean.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<jsp:useBean id="scholarship" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="career" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="contact" class="java.util.ArrayList" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ include file="/asanway/common/country_list.jsp" %>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("member_main.jsp?flag=1");
	}
%>

<SCRIPT language=javascript1.2>
<!--
	function zip_search(val){
		window.open('/member/pop_search_zip.jsp?type=' + val,'','width=450,height=381,top=200,left=200,scrollbars=no');
	}

	function addassignment(){
		if(document.form.jobgroup.selectedIndex == 5){
			tr_assignment.style.display = '';
		}else{
			tr_assignment.style.display = 'none';
		}
	}

	function checkForm(){
		var form = document.form;

		//����
		if( form.country.selectedIndex == 0 ){
			alert("������ ������ �ֽʽÿ�.");
			form.country.focus();
			return false;
		}

		//�̸�
		if( form.lname.value=="" ){
			alert("���� �Է��� �ֽʽÿ�.");
			form.lname.focus();
			return false;
		}

		if( form.fname.value=="" ){
			alert("�̸�1��  �Է��� �ֽʽÿ�.");
			form.fname.focus();
			return false;
		}

		//����
		if( form.jobgroup.selectedIndex == 0 ){
			alert("������ ������ �ֽʽÿ�.");
			form.jobgroup.focus();
			return false;
		}

		//����
		if( form.company.value=="" ){
			alert("������   �Է��� �ֽʽÿ�.");
			form.company.focus();
			return false;
		}

		//����
		if( form.position.value=="" ){
			alert("������   �Է��� �ֽʽÿ�.");
			form.position.focus();
			return false;
		}

		//���� �ּ� �Է½�
		if( form.czip1.value!="" && form.czip2.value!="" ){
			form.czip.value = form.czip1.value + form.czip2.value
		}

		//���ּ� �Է½�
		if( form.hzip1.value!="" && form.hzip2.value!="" ){
			form.hzip.value = form.hzip1.value + form.hzip2.value
		}

		//������� �Է½�
		if( form.birthdayy.value!="" && form.birthdaym.value!="" && form.birthdayd.value!="" ){
			form.birthday.value = form.birthdayy.value + "-" +form.birthdaym.value  + "-" + form.birthdayd.value ;
		}


		//�̸��� �Է½�
		if( form.email1.value!="" && form.email2.value!="" ){
			form.email.value = form.email1.value + "@" +form.email2.value ;
		}


		//��ȭ��ȣ �Է� Ȯ��
		if( form.tel1.value=="" && form.tel2.value=="" && form.mobile.value== ""){
			alert("��ȭ��ȣ�� �ϳ��� �ʼ��Է� �׸��Դϴ�.");
			form.tel1.focus();
			return false;
		}
		return true;
	}

	//�з� ��
	var enteryear= new Array();
	var graduyear= new Array();
	var school= new Array();
	<%
		for(int i = 0; i < scholarship.size(); i++) {
				HashMap hm = (HashMap)scholarship.get(i);
    %>
		enteryear[<%=i%>]  = "<%=(hm.get("SDATE") ==null)?"":hm.get("SDATE")%>"    ;
		graduyear[<%=i%>]  = "<%=(hm.get("EDATE") ==null)?"":hm.get("EDATE")%>"    ;
		school[<%=i%>]  = "<%=(hm.get("CONTENT") ==null)?"":Utility.ko(hm.get("CONTENT").toString())%>"    ;
	<%}%>

	//��»���  ��
	var stdate= new Array();
	var enddate= new Array();
	var career= new Array();
	<%
		for(int i = 0; i < career.size(); i++) {
				HashMap hm = (HashMap)career.get(i);
    %>
		stdate[<%=i%>]  = "<%=(hm.get("SDATE") ==null)?"":hm.get("SDATE")%>"    ;
		enddate[<%=i%>]  = "<%=(hm.get("EDATE") ==null)?"":hm.get("EDATE")%>"    ;
		career[<%=i%>]  = "<%=(hm.get("CONTENT") ==null)?"":Utility.ko(hm.get("CONTENT").toString())%>"    ;
	<%}%>

	//���˻��� ��
	var contactdate= new Array();
	var content= new Array();
	<%
		for(int i = 0; i < contact.size(); i++) {
				HashMap hm = (HashMap)contact.get(i);
    %>
		contactdate[<%=i%>]  = "<%=(hm.get("SDATE") ==null)?"":hm.get("SDATE")%>"    ;
		content[<%=i%>]  = "<%=(hm.get("CONTENT") ==null)?"":Utility.ko(hm.get("CONTENT").toString())%>"    ;
	<%}%>

	function setvalue(type) {
		var f = document.frm;
		if(type == "scholarship"){
			for(var i = 0; i < enteryear.length - 1; i++) {
				f.enteryear[i].value = enteryear[i];
				f.graduyear[i].value = graduyear[i];
				f.school[i].value = school[i];
			}
		}else if(type == "career"){
			for(var i = 0; i < career.length - 1; i++) {
				f.stdate[i].value = stdate[i];
				f.enddate[i].value = enddate[i];
				f.carrer[i].value = carrer[i];
			}
		}else{
			for(var i = 0; i < contactdate.length - 1; i++) {
				f.contactdate[i].value = contactdate[i];
				f.content[i].value = content[i];
			}
		}
	}

	//�з� �߰�
	function scholarship_case(){
		aHtml = "<div id=scholarcaseDiv><table width=100% border=0 cellspacing=1 cellpadding=0  bgcolor=#DEDDCF><tr bgcolor=#ffffff align=center>"
		aHtml = aHtml + "<td width='15%' height=30 ><input type=text name='enteryear' maxlength=4 size=10></td>"
		aHtml = aHtml + "<td width='15%'><input type=text name='graduyear' maxlength=4 size=10></td>"
		aHtml = aHtml + "<td width='70%'><input type=text name='school' maxlength=50 size=60></td>"
		aHtml = aHtml + "</tr></table></div>\r\n\t";
		return aHtml;
	}

	function init_scholarship(val){
		hHtml = "";
		for(i = 1; i <= val; i++){
			hHtml = hHtml + scholarship_case();
		}
		scholarship.innerHTML = hHtml;
	}


	function addscholarship(){
		var datacnt = 0;

		if(document.all.scholarcaseDiv.length) {
			datacnt = document.all.scholarcaseDiv.length;
		}else{
			datacnt = 1;
		}

		if (datacnt > 4) {
			alert("�з��� �ִ� 5������ �Դϴ�");
			return;
		}else {

			cHtml = scholarship_case();

			if(datacnt > 1) {
				document.all.scholarship.all.scholarcaseDiv[datacnt-1].insertAdjacentHTML("BeforeEnd",cHtml);
			}else{
				document.all.scholarship.all.scholarcaseDiv.insertAdjacentHTML("BeforeEnd",cHtml);
			}
		}
	}

	//��� �߰�
	function career_case(){
		aHtml = "<div id=careercaseDiv><table width=100% border=0 cellspacing=1 cellpadding=0  bgcolor=#DEDDCF><tr bgcolor=#ffffff align=center>"
		aHtml = aHtml + "<td width='30%' height=30><input type=text name='stdate' maxlength=4 size=10> - <input type=text name='enddate' maxlength=4 size=10></td>"
	    aHtml = aHtml + "<td width='70%'><input type=text name='career' maxlength=50 size=70></td>"
		aHtml = aHtml + "</tr></table></div>\r\n\t";
		return aHtml;
	}


	function init_career(val){
		hHtml = "";
		for(i = 1; i <= val; i++){
			hHtml = hHtml + career_case();
		}
		careerDiv.innerHTML = hHtml;
	}


	function addcareer(){
		var datacnt = 0;

		if(document.all.careercaseDiv.length) {
			datacnt = document.all.careercaseDiv.length;
		}else{
			datacnt = 1;
		}

		if (datacnt > 4) {
			alert("�����  �ִ� 5������ �Դϴ�");
			return;
		}else {

			cHtml = career_case();

			if(datacnt > 1) {
				document.all.careerDiv.all.careercaseDiv[datacnt-1].insertAdjacentHTML("BeforeEnd",cHtml);
			}else{
				document.all.careerDiv.all.careercaseDiv.insertAdjacentHTML("BeforeEnd",cHtml);
			}
		}
	}

	//���˻��� �߰�
	function contact_case(){
		aHtml = "<div id=contactDiv><table width=100% border=0 cellspacing=1 cellpadding=0  bgcolor=#DEDDCF><tr bgcolor=#ffffff align=center>"
		aHtml = aHtml + "<td width='20%' height=30 ><input type=text name='contactdate' maxlength=4 size=15></td>"
	    aHtml = aHtml + "<td width='80%'><input type=text name='content' maxlength=50 size=80></td>"
		aHtml = aHtml + "</tr></table></div>\r\n\t";
		return aHtml;
	}


	function init_contact(val){
		hHtml = "";
		for(i = 1; i <= val; i++){
			hHtml = hHtml + contact_case();
		}
		contact.innerHTML = hHtml;
	}


	function addcontact(){
		var datacnt = 0;

		if(document.all.contactDiv.length) {
			datacnt = document.all.contactDiv.length;
		}else{
			datacnt = 1;
		}

		if (datacnt > 4) {
			alert("���˻����� �ִ� 5������ �Դϴ�");
			return;
		}else {
			cHtml = contact_case();
			if(datacnt > 1) {
				document.all.contact.all.contactDiv[datacnt-1].insertAdjacentHTML("BeforeEnd",cHtml);
			}else{
				document.all.contact.all.contactDiv.insertAdjacentHTML("BeforeEnd",cHtml);
			}
		}
	}


//-->
</script>
<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3"><jsp:include page="/asanway/common/topbutton.jsp" flush="true" /></td>
  </tr>
  <tr>
    <td valign="top">
      <table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" >
				<table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
	              <tr>
	                <td valign="top" bgcolor="FCFCF6" width="180" > <jsp:include page="/asanway/common/member_leftmenu.jsp" flush="true" /></td>
	                <td width="2"></td>
	              </tr>
	            </table>
          </td>
          <td valign="top" bgcolor="FCFCF6" width=650>

            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr  style="padding: 15 0 0 20;">
              	<td>
              		<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			<tr>
              				<td>*ǥ�� �׸��� �ʼ��Է»����Դϴ�. </td>
              				<td align=right>
              					<input type=text name=regday readonly value="<%=(read.get("LASTTIME")==null)?"":read.get("LASTTIME").toString().substring(0, 10) %>">
              				</td>
              			</tr>
              		</table>
              	</td>
              </tr>
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
				  <form name="form" method=post action="member_hr_action.jsp?cmd=U" enctype="multipart/form-data" onSubmit="return checkForm()">
	                  	<input type=hidden name=idx value="<%=read.get("IDX")%>">
	                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                       <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>�⺻����</b></td>
	                    </tr>
	                    <tr>
	                      <td>
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	                         <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td width="90" height="30" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">* �� �� </td>
	                            <td style="padding-left:5;">
	                            	<select name="country"  style="width:100px;height:20px" >
	                            		<option value="">����</option>
	                            		<%for ( int i = 1 ; i < countryList.size(); i++) {%>
												<option value=<%=i%> <%if(read.get("COUNTRY").toString().equals(Integer.toString(i))){%> selected <%}%>><%=countryList.get(Integer.toString(i))%></option>
										<%}%>
									</select>
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="75" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"  valign=top>* �� ��</td>
	                            <td style="padding-left:5;">
	                            	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
						              <tr height=25>
						                <td width=150>��(Last Name)</td>
						                <td><input type=text name=lname value="<%=(read.get("LNAME")==null)?"":Utility.ko((String)read.get("LNAME")) %>"></td>
						              </tr>
						              <tr height=25>
						                <td>�̸�1(First Name)</td>
						                <td><input type=text name=fname value="<%=(read.get("FNAME")==null)?"":Utility.ko((String)read.get("FNAME")) %>"></td>
						              </tr>
						              <tr height=25>
						                <td>�̸�2(Middle Name)</td>
						                <td><input type=text name=mname value="<%=(read.get("MNAME")==null)?"":Utility.ko((String)read.get("MNAME")) %>"></td>
						              </tr>
						            </table>
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="50" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�� ��</td>
	                            <td style="padding-left:5;">
	                            	<% if( read.get("IMGFILE") == null || read.get("IMGFILE").equals("") ) { %>
		                            	��ϵ� ������ �����ϴ�.
		                            <% } else { %>
										<%= Utility.ko(read.get("IMGFILE").toString()) %>&nbsp;&nbsp;<input type="checkbox" name="imgfiledel">�̹��� ����
		                            <% } %><br>
	                            	<input type="file" name="img" style="width:300px;height:20px" >(* ���� �̹��� ������ : 350 * 450)
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">* �� ��</td>
	                            <td style="padding-left:5;">
	                            	<select name="jobgroup"  style="width:100px;height:20px" onChange="javascript:addassignment();">
	                            		<option value="">����</option>
	                            		<%for ( int i = 1 ; i < jobgroup.size(); i++) {%>
												<option value=<%=i%> <%if(read.get("JOBGROUP").toString().equals(Integer.toString(i))){%> selected <%}%>><%= jobgroup.get(Integer.toString(i))%></option>
										<%}%>
									</select>
	                            </td>
	                          </tr>

	                          <tr id="tr_assignment" style="display:<%=(read.get("JOBGROUP").toString().equals("5"))?"":"none"%>;">
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">* ����ó</td>
	                            <td style="padding-left:5;">
	                            	<input type=text name="assignment"  value="<%=(read.get("ASSIGNMENT")==null)?"":Utility.ko((String)read.get("ASSIGNMENT")) %>">
	                            </td>
	                          </tr>

	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="50" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">* �� ��</td>
	                            <td style="padding-left:5;">
	                            	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
						              <tr height=25>
						                <td width=100>�����</td>
						                <td><input type=text name="company" size=40 value="<%=(read.get("COMPANY")==null)?"":Utility.ko((String)read.get("COMPANY")) %>"></td>
						              </tr>
						              <tr height=25>
						                <td>�� ��</td>
						                <td><input type=text name="position" size=40 value="<%=(read.get("POSITION")==null)?"":Utility.ko((String)read.get("POSITION")) %>"></td>
						              </tr>
						            </table>
								</td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                       </table>
	                    </td>
	                 </tr>
	               </table>
	                <br>

	               <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                       <td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>�ּ� �� ����ó </b></td>
	                    </tr>
	                    <tr>
	                      <td>
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	                         <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td width="90" height="30" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">�����ּ� </td>
	                            <td style="padding-left:5;">
	                            	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			                          <tr>
			                            <td style="padding-left:5;">
				                            <input type=hidden name="czip" value="<%=(read.get("CZIP")==null)?"":Utility.ko((String)read.get("CZIP")) %>">
				                            <input type=text name="czip1" size=6 maxlength=3 readonly value="<%=(read.get("CZIP")==null)?"":read.get("CZIP").toString().substring(0,3)%>">-
				                            <input type=text name="czip2" size=6 maxlength=3 readonly value="<%=(read.get("CZIP")==null)?"":read.get("CZIP").toString().substring(3,6)%>">
				                            <a href="javascript:zip_search('czip');" ><img src="/img/member/btn_sch_zip.gif" align="absmiddle" border=0></a>
			                            </td>
			                          </tr>
			                          <tr>
			                            <td style="padding-left:5;"><input type=text name="caddr1" size=70 value="<%=(read.get("CADDR1")==null)?"":Utility.ko(read.get("CADDR1").toString())%>" readonly></td>
			                          </tr>
			                          <tr>
			                            <td style="padding-left:5;"><input type=text name="caddr2"  size=70 value="<%=(read.get("CADDR2")==null)?"":Utility.ko(read.get("CADDR2").toString())%>"></td>
			                          </tr>
	                          		</table>
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="75" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"  valign=top>�����ּ�</td>
	                            <td style="padding-left:5;">
	                            	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			                          <tr>
			                            <td style="padding-left:5;">
				                            <input type=hidden name="hzip" value="<%=(read.get("HZIP")==null)?"":Utility.ko((String)read.get("HZIP")) %>">
				                            <input type=text name="hzip1" size=6 maxlength=3 readonly value="<%=(read.get("HZIP")==null)?"":read.get("HZIP").toString().substring(0,3)%>">-
				                            <input type=text name="hzip2" size=6 maxlength=3 readonly value="<%=(read.get("HZIP")==null)?"":read.get("HZIP").toString().substring(3,6)%>">
				                            <a href="javascript:zip_search('hzip');" ><img src="/img/member/btn_sch_zip.gif" align="absmiddle" border=0></a>
			                            </td>
			                          </tr>
			                          <tr>
			                            <td style="padding-left:5;"><input type=text name="haddr1" size=70  value="<%=(read.get("HADDR1")==null)?"":Utility.ko(read.get("HADDR1").toString())%>" readonly></td>
			                          </tr>
			                          <tr>
			                            <td style="padding-left:5;"><input type=text name="haddr2" size=70 value="<%=(read.get("HADDR2")==null)?"":Utility.ko(read.get("HADDR2").toString())%>"></td>
			                          </tr>
	                          		</table>
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�Ϲ���ȭ</td>
	                            <td style="padding-left:5;">
	                            	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			                          <tr>
			                            <td style="padding-left:5;">
			                            	���� <input type=radio name="telgbn1" value="h" <%if(read.get("TELGBN1").equals("h")){%> checked <%}%>>
			                            	���� <input type=radio name="telgbn1" value="c" <%if(read.get("TELGBN1").equals("c")){%> checked <%}%>> &nbsp;
			                            	<input type=text name="tel1" size=40 maxlength=20  value="<%=(read.get("TEL1")==null)?"":read.get("TEL1")%>">
			                            </td>
			                          </tr>
			                          <tr>
			                            <td style="padding-left:5;">
			                            	���� <input type=radio name="telgbn2" value="h" checked <%if(read.get("TELGBN2").equals("h")){%> checked <%}%>>
			                            	���� <input type=radio name="telgbn2" value="c"  <%if(read.get("TELGBN2").equals("c")){%> checked <%}%>> &nbsp;
			                            	<input type=text name="tel2" size=40 maxlength=20 value="<%=(read.get("TEL2")==null)?"":read.get("TEL2")%>">
			                            </td>
			                          </tr>
	                          		</table>
	                            </td>
	                          </tr>
							  <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"> �޴���ȭ</td>
	                            <td style="padding-left:5;">
	                            	<input type=text name="mobile" size=40 maxlength=20 value="<%=(read.get("MOBILE")==null)?"":read.get("MOBILE")%>">
	                            </td>
	                          </tr>
							  <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"></td>
	                            <td style="padding-left:5;">
	                            	* �Ϲ� ��ȭ�� �޴���ȭ�� �ϳ��� �ݵ�� �Է��ؾ� �մϴ�.
	                            </td>
	                          </tr>

	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">e-mail</td>
	                            <td style="padding-left:5;">
	                            	<input type=hidden name="email" value="<%=read.get("EMAIL")%>">
	                            	<input type=text name="email1" value="<%=(read.get("EMAIL")==null)?"":Utility.getEmail((String)read.get("EMAIL"),1)%>">@
	                            	<input type=text name="email2"  maxlength=20 size=40 value="<%=(read.get("EMAIL")==null)?"":Utility.getEmail((String)read.get("EMAIL"),2)%>">
	                            </td>
	                          </tr>

	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
							</table>
	                    </td>
	                 </tr>
	               </table>
	               <br>

                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                       <td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>�Ż����� </b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                         <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td width="90" height="30" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">�������  </td>
                            <td style="padding-left:5;">
                        		<input type=hidden name="birthday" value="<%=read.get("BIRTHDAY")%>">
                        		<input type=text name="birthdayy" maxlength=4 size=4 value="<%=(read.get("BIRTHDAY")==null)?"":read.get("BIRTHDAY").toString().substring(0, 4)%>"> ��
                        		<input type=text name="birthdaym" maxlength=2 size=4 value="<%=(read.get("BIRTHDAY")==null)?"":read.get("BIRTHDAY").toString().substring(4, 6)%>"> ��
                        		<input type=text name="birthdayd" maxlength=2 size=4 value="<%=(read.get("BIRTHDAY")==null)?"":read.get("BIRTHDAY").toString().substring(6, 8)%>"> ��
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"  valign=top>�����</td>
                            <td style="padding-left:5;">
                            	<input type=text name="birthplace" maxlength=30 size=70 value="<%=(read.get("BIRTHPLACE")==null)?"":Utility.ko(read.get("BIRTHPLACE").toString())%>">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�� ��</td>
                            <td style="padding-left:5;">
                            	<input type=text name="hobby" maxlength=30  size=70 value="<%=(read.get("HOBBY")==null)?"":Utility.ko(read.get("HOBBY").toString())%>">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"> ��/�ַ� </td>
                            <td style="padding-left:5;">
                            	<input type=text name="smoking" maxlength=30 size=70 value="<%=(read.get("SMOKING")==null)?"":Utility.ko(read.get("SMOKING").toString())%>">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�� ��</td>
                            <td style="padding-left:5;">
                            	<input type=text name="religion" maxlength=30 size=70 value="<%=(read.get("RELIGION")==null)?"":Utility.ko(read.get("RELIGION").toString())%>">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr >
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">������ </td>
                            <td style="padding-left:5;">
                            	<input type=text name="bloodtype" maxlength=30 size=70 value="<%=(read.get("RLOODTYPE")==null)?"":Utility.ko(read.get("BLOODTYPE").toString())%>">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr >
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">��������</td>
                            <td style="padding-left:5;">
                            	<input type=text name="family" maxlength=30 size=70 value="<%=(read.get("FAMILY")==null)?"":Utility.ko(read.get("FAMILY").toString())%>">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">��Ÿ </td>
                            <td style="padding-left:5;">
                            	<input type=text name="etc" maxlength=30 size=70 value="<%=(read.get("ETC")==null)?"":Utility.ko(read.get("ETC").toString())%>">
                            </td>
                          </tr>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
						</table>
                    </td>
                 </tr>
               </table>
               <br>


				   <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                       	<td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>�� �� </b></td>
	                    	<td align=right>[<a href="javascript:addscholarship();">Į���߰�</a>]&nbsp;&nbsp;</td>
	                    </tr>

	                    <tr>
	                      <td colspan=2>
	                        <table width="100%" border="0" cellspacing="1" cellpadding="0"  bgcolor=#DEDDCF>
	                          <tr bgcolor="F2F1E2" align=center>
	                            <td width="15%" height="30" >���г⵵</td>
	                            <td width="15%">�����⵵</td>
	                            <td width="70%">����б� �� ����</td>
	                          </tr>
							</table>
                          	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
                          		<tr><td><div id="scholarship"></div></td></tr>
                          	</table>
	                      </td>
	                    </tr>
	                     <tr>
	                       	<td height="30" align=right colspan=2>* Į���� 5������ �߰� �����մϴ�.  &nbsp;</td>
	                    </tr>
	               </table>
	               <br>



	               <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                        <td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>�ֿ���</b></td>
	                    	<td align=right>[<a href="javascript:addcareer();">Į���߰�</a>]&nbsp;&nbsp;</td>
	                    </tr>
	                    <tr >
	                      <td colspan=2 >
	                         <table width="100%" border="0" cellspacing="1" cellpadding="0"  bgcolor=#DEDDCF>
	                          <tr bgcolor="F2F1E2" align=center >
	                            <td width="30%" height="30" >�� �� </td>
	                            <td width="70%">�ֿ��� </td>
	                          </tr>
							  </table>
	                          <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	                          		<tr><td><div id="careerDiv"></div></td></tr>
	                          </table>
	                      </td>
	                   </tr>
	                   <tr>
	                       	<td height="30" align=right colspan=2>* Į���� 5������ �߰� �����մϴ�.  &nbsp;</td>
	                    </tr>
	               </table>
	               <br>

	               <table width="100%" border="0" cellspacing="0" cellpadding="0">
				   		 <tr>
	                       <td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>���˻���  </b></td>
	                       <td align=right>[<a href="javascript:addcontact();">Į���߰�</a>]&nbsp;&nbsp;</td>
	                    </tr>
	                    <tr>
	                      <td colspan=2>
	                        <table width="100%" border="0" cellspacing="1" cellpadding="0"  bgcolor=#DEDDCF>
	                          <tr bgcolor="F2F1E2" align=center>
	                            <td width="20%" height="30" >�� ��</td>
	                            <td width="85%">���˳��� </td>
	                          </tr>
							 </table>
	                         <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	                          		<tr><td><div id="contact"></div></td></tr>
	                         </table>
	                    </td>
	                   </tr>
	                   <tr>
	                       	<td height="30" align=right colspan=2>* Į���� 5������ �߰� �����մϴ�.  &nbsp;</td>
	                    </tr>
	               </table>
	               <br>

	                <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                       <td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>Ư�����   </b></td>
	                    </tr>
	                    <tr>
	                      <td>
	                        <textarea name="memo" rows=3 cols=90><%=(read.get("MEMO")==null)?"":Utility.ko(read.get("MEMO").toString())%></textarea><br><br>
	                    </td>
	                   </tr>
	                   <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                       </tr>
	               </table>
	               <br>


				   <table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
	                  <td align="right"   style="padding-top:5;">
	                    	<input type=image src="../img/bt_08.gif" border="0">
	                    	<a href="member_hr_list.jsp"><img src="../img/bt_10.gif" hspace="4" border="0"></a>
	                  </td>
	                </tr>
	                <tr>
	                  <td height="50" align="center">&nbsp;</td>
	                </tr>
				   </table>
	               </form>

	        	   </td>
	        	 </tr>
	          </table>
         	</td>
          </tr>
       </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="E4E3C3" height="10"></td>
  </tr>
  <tr>
    <td  height="15"></td>
  </tr>
  <tr>
    <td height="30"  bgcolor="D4D4B2"><jsp:include page="/asanway/common/copyright.jsp" flush="true" /></td>
  </tr>
</table>
</body>
</html>

<SCRIPT language=javascript1.2>
<!--
	init_scholarship(<%=scholarship.size()%>);
	//setvalue("scholarship");
	init_career(<%=career.size()%>);
	//setvalue("career");
	init_contact(<%=contact.size()%>);
	//setvalue("contact");
//-->
</script>
