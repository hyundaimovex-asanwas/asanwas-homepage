<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
/*-------------------------------------------------------------------------------
+ �� �� �� ��	:	
+ ���α׷� ID	: Per_com_pop.jsp
+ �� �� �� ��	: 
+ �� �� �� ��	: 
+ �� �� �� ��	: 
------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<html>
<head>
<jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "<%=dirPath%>/servlet/sales.em.Per_com_pop_s2?v_str1="+txt_empno.value+"&v_str2="+txt_empnmk.value+"&v_str3="+chk_s.value; 
	gcds_data.Reset();
}


/******************************************************************************
	Description : â�ݱ�
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		if(gcds_data.countrow<1) {
			alert("�����Ͻ� ���¾�ü�� �����ϴ�.");
		}
		else {
			var row = gcds_data.rowposition;
      //alert(gcds_data.namevalue(row,"CUST_SID"));
			window.returnValue = gcds_data.namevalue(row,"EMPNO") + ";" 
                         + gcds_data.namevalue(row,"EMPNMK") + ";"
	                   	   + gcds_data.namevalue(row,"DEPT_NM") + ";"
	                   	   + gcds_data.namevalue(row,"TEAM_NM") + ";"
	                   	   + gcds_data.namevalue(row,"CUST_SID")+ ";"
	                   	   + gcds_data.namevalue(row,"JOB_CD")+ ";"
	                   	   + gcds_data.namevalue(row,"DEPT_CD")+ ";"
	                   	   + gcds_data.namevalue(row,"TEAM_CD")+ ";"
	                   	   + gcds_data.namevalue(row,"VEND_CD")+ ";"
	                   	   + gcds_data.namevalue(row,"WORK_CD")+ ";"
												 + gcds_data.namevalue(row,"SKILL_CD");
			window.close();
		}
	} else {
		window.close();
	}
}

/******************************************************************************
	Description : ��� ����
******************************************************************************/
function ln_ChkBox_Chk(){
	if(chk_s.checked) {
		chk_s.value = '3';
	}else {
		chk_s.value = '1'
	}
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">

  //alert(gcds_data.namevalue(rowposition,'TEAM_NM'));

	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	if(gcds_data.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick(row,colid)">
	if (row<1) return;
	ln_Close('A');
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:360px;border:0 solid #c5c5c5">
	<tr>
	  <td class="tab_a1111" style="width:30px;height:30px;">����</td>
		<td class="tab_b0111" width="72px">
		 <input type="text" class="txt_a01" id="txt_empnmk" style="width:70px;position:relative;left:5px;top:0px;" maxlength="10" onkeydown="if(event.keyCode==13) ln_Query();">
    </td>
		<td class="tab_a0111" style="width:30px;height:30px;">���</td>
		<td class="tab_b0111" width="65px">
		  <input type="text" class="txt_a01" id="txt_empno" style="width:60px;position:relative;left:5px;top:0px;" maxlength="10" onkeydown="if(event.keyCode==13) ln_Query();">
		</td>
		<td class="tab_a0111" style="width:30px;height:30px;" bgcolor="#eeeeee">���</td>
		<td class="tab_b0111" bgcolor="#FFFFFF" width="100px">
			<input type="checkbox" id=chk_s   value=""    style="position:relative;left:5px;top:-2px;cursor:hand;width:20px" onClick="ln_ChkBox_Chk()" >
			<img src="../common//img/btn/com_b_find.gif" alt="�ش� ������ �˻��մϴ�" style="position:relative;left:8px;top:3px;cursor:hand;" onclick="ln_Query()">
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td colspan="3">
			<comment id="__NSID__">
			<OBJECT id=gcgd_disp class="tab_b1111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:358;height:329px;" viewastext >
						<param name="DataID"			value="gcds_data">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Indwidth"	  VALUE="0">
						<PARAM NAME="Fillarea"	  VALUE="true">
						<PARAM NAME="Format"			VALUE="  
						<C>ID=EMPNO  	  Name=��� 	width=120 	HeadBgColor=#eeeeee align=center sort = true</C>
						<C>ID=EMPNMK		Name=����	  width=220 	HeadBgColor=#eeeeee align=left	 sort = true</C>
				">
	    </OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:361;height:20px;border:1 solid #c5c5c5;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>


</body>
</html>