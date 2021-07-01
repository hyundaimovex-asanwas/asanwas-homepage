<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:  ������������	- �����ڵ����
+ ���α׷� ID	:  TR00505.html
+ �� �� �� ��	:  �ŷ�ó�ڵ带 ��ȸ�Ѵ�.
+ ��   ��  �� :  �̹���
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ �������� :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML ����-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>


<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
		get_cookdata();

		var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
		var gs_userid = gusrid;
		
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			ln_Start();//����ȸ

			window.status="�Ϸ�";

		}
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){

	  ln_SetDataHeader();
	
	  gcem_settle_cd.enabled= false;

}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(){

		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00505_s1?"+"v_str1="+gcem_settle_cd_fr01.text + "&v_str2=" + txt_settle_nm_fr01.value; 

		gcds_code01.Reset();


}

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){
  
		gcds_code01.addrow();
		
		//ln_Enable("t");
		gcem_settle_cd.focus();
	
}

/******************************************************************************************
	Description : ����
******************************************************************************************/
function ln_Save(){
	

	if (gcds_code01.IsUpdated){
		if(ln_Chk()){
			if (confirm("�����Ͻðڽ��ϱ�?")){	

				gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>transfer.tr00505_t1?";

				
				gctr_code01.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
				gctr_code01.post();
				
			}
		}	
	}
}

/******************************************************************************************
	Description : ����
*****************************************************************************************/
function ln_Delete(){

	if (confirm("�����Ͻðڽ��ϱ�?")){	
	
		gcds_code01.deleterow(gcds_code01.rowposition);
		
		gctr_code01.Action =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>transfer.tr00505_t1?";
		gctr_code01.Parameters = "v_str1=" + gs_userid;
		
		gctr_code01.post();
		
		ln_Query();
	}	
}


/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : �Է�üũ 
	parameter   : 01 - �ŷ�ó, 02 - ����, 03 - ����� 
******************************************************************************/
function ln_Chk(){

		//�ʼ��׸�üũ
		if (fn_trim(gcem_settle_cd.text)=="" ){
			alert("�����ڵ带 �Է��Ͻʽÿ�.");
			gcem_settle_cd.focus();
			return false; 
		}

		if (fn_trim(txt_settle_nm.value)==""){
			alert("�����ڵ���� �Է��Ͻʽÿ�.");
			txt_settle_nm.focus();
			return false; 
		} 
	
	return true; 
}


/***********************************************************************************************
	Description : Enable _ Disabled 
	parameter   : p==> t - Enable, f - Disable
***********************************************************************************************/

/*function ln_Enable(p) {
	if (p=="t"){
		gcem_settle_cd.enable=true;
	}else if (p=="f"){
		gcem_settle_cd.enable=false;

	}
}
*/
/******************************************************************************
	Description : Dataset Head ����
******************************************************************************/
function ln_SetDataHeader(){
    var s_temp = "SETTLE_CD:STRING,SETTLE_NM:STRING,ACC_CODE:STRING,SELL_TYPE:STRING,SORT_NO:DECIAML,"
								+ "REMARK:STRING,CREAT_USR:STRING,UPDATE_USR:STRING";
			
		gcds_code01.SetDataHeader(s_temp);
}


</script> 
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_code01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="tr00505_t1(I:USER=gcds_code01)"> 
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt01.innerText = "��ȸ�Ǽ� : �� ( " + row + " ) ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcds_code01 event=OnClick(Row,Colid)>
	if(Row>0) ;//ln_Enable01("f");
</script>

<script language=javascript for=gcds_code01 event="OnRowPosChanged(row)">
	if (gcds_code01.sysStatus(row)=="0") gcem_settle_cd.enable = false;
	else gcem_settle_cd.enable = true;
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_code01" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	ln_Query();
</script>

<script language="javascript" for="gctr_code01" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr>
    	<td width="876" align="right" background="../../common/img/com_t_bg.gif">
    	<td width="876" align="right" background="../../common/img/com_t_bg.gif">    	
		<img src="../../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete()" >
		<img src="../../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add()" >
		<img src="../../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save()"> 
		<img src="../../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query()">
	 </td>
	</tr>
	<tr>  
    <td align="center" colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td class="tab12" style="height:30px;width:100px;" bgcolor="#eeeeee">�����ڵ�</td>
					<td class="tab23" style="width:150px">&nbsp;
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_settle_cd_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query();">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="#############">
							<param name=PromptChar    value="">
							<param name=maxlength     value="13">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td width="100" class="tab12" bgcolor="#eeeeee" align="center">�����ڵ��</td>
					<td>
						<input id="txt_settle_nm_fr01" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px;IME-MODE: active" maxlength="72" onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);"> 
					</td>
				</tr>
			</table>
		</td>
	</tr>
		
		<tr><td height="3px" colspan =2 align="left" valign="top"></td></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:540px;border:0 solid #708090;">
					<tr> 			
						<td>
						<%=HDConstant.COMMENT_START%>
						<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_code01  
							style="position:relative;left:0px;width:540px;top:1px;height:420px; border:1 solid #708090;">
							<PARAM NAME="DataID"			VALUE="gcds_code01">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='�����ڵ�'					    ID=SETTLE_CD   		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  </C> 
								<C> Name='�����ڵ��'						ID=SETTLE_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	 </C> 
								<C> Name='ȸ������ڵ�'					ID=ACC_CODE				HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=LEFT	 </C> 
								<C> Name='���ⱸ��'							ID=SELL_TYPE			HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=LEFT	 </C> 
								<C> Name='���'	    						ID=REMARK			    HeadAlign=Center HeadBgColor=#B9D4DC Width=110		align=LEFT	</C> 
								">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
						<fieldset style="position:relative;left:0px;width:542px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
						</fieldset>
				</td>
			</tr>
		</table>
	</td>

		<td valign="top">

			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:2px;top:1px;width:330px;border:0 solid #708090;">
			 <tr>
				<td class="tab15" style="width:90px;height:30px;" bgcolor="#eeeeee" >&nbsp;�����ڵ�</td>
				<td class="tab18"> 
					 <%=HDConstant.COMMENT_START%>
					 <OBJECT id=gcem_settle_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:36px;height:20px;position:relative;left:8px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
					 	<param name=BackColor     value="#CCCCCC"> 
						<param name=InheritColor  value=false>
						<param name=format        value="0000">
						<param name=maxlength     value="4">
						<param name=PromptChar		value="_">
					</OBJECT>
					<%=HDConstant.COMMENT_END%> 
				</td>
		</tr>
		<tr>
			<td class="tab17" style="width:90px;height:30px;" bgcolor="#eeeeee" >&nbsp;�����ڵ��</td>
			<td class="tab19"> 
				 <input id="txt_settle_nm" type="text" class="txtbox"  style= "width:226px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="50" >
			</td>
		</tr>
		<tr>
			<td class="tab17" style="width:90px;height:30px;" bgcolor="#eeeeee" >&nbsp;ȸ������ڵ�</td>
			<td class="tab19"> 
			<input id="txt_acc_code" type="text" class="txtbox"  style= "width:226px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="10" >

			
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;height:30px;" bgcolor="#eeeeee" >&nbsp;���ⱸ��</td>
				<td class="tab19"> 
				 <input id="txt_sell_type" type="text" class="txtbox"  style= "width:226px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="4" >
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;height:30px;" bgcolor="#eeeeee" >&nbsp;Sort</td>
				<td class="tab19" > 
					 <%=HDConstant.COMMENT_START%><OBJECT id=gcem_sort_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:8px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
					 	<param name=BackColor     value="#CCCCCC"> 
						<param name=InheritColor  value=false>
						<param name=format        value="####">
						<param name=maxlength     value="4">
						<param name=Alignment			value=2>
						<param name=PromptChar		value="">
					</OBJECT><%=HDConstant.COMMENT_END%> 
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;height:80px;" bgcolor="#eeeeee" >&nbsp;���</td>
				<td class="tab19"> 
					<textarea id="txt_remark" class="txtbox"  style= "width:226px; height:68px; overflow:auto;position:relative;left:8px;IME-MODE: active" maxlength="50" onBlur="bytelength(this,this.value,50);"></textarea>
				</td>
			</tr>
		
				<tr>
					<td height="211px" style="border:1 solid #708090;border-right-width:0px;border-top-width:0px;" >&nbsp;</td><!--�ؿ� ���ĭ-->
					<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td>
				</tr>
		
		</table> 
	  </td>
  </tr> 

</table> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_code01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code01>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=SETTLE_CD			 Ctrl=gcem_settle_cd				Param=text</C>
		<C>Col=SETTLE_NM			 Ctrl=txt_settle_nm					Param=Value</C>
		<C>Col=ACC_CODE				 Ctrl=txt_acc_code		 			Param=Value</C>
		<C>Col=SELL_TYPE			 Ctrl=txt_sell_type					Param=Value</C>
		<C>Col=SORT_NO				 Ctrl=gcem_sort_no					Param=text</C>
		<C>Col=REMARK					 Ctrl=txt_remark						Param=value</C>
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

