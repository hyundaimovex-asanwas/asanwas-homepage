<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ� �����ֹ����
+ ���α׷� ID	: TR00106_E1.HTML
+ �� �� �� ��	: �����ֹ���� - �������� ���
+ �� �� �� ��	: ���̼�
+ �� �� �� ��	: 
------------------------------------------------------------------------------

----------------------------------------------------------------------------->
+ ������ :
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
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc55 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00106_e1t1">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00106_e1t1(I:USER=gcDs1)">
</OBJECT><%=HDConstant.COMMENT_END%>  

<!-- /******************************************************************************
	Description : Java Script 
******************************************************************************/ --> 
<SCRIPT language=JavaScript>
	var	lb_boolean1 =  false ; 
	var opener = window.dialogArguments;

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function Start(){
		GetParam() ; 

		gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e4?NOH=Y";  //���籸�� 
		gcDs_etc5.Reset();

		gcDs_etc55.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00510_s?";  //���籸�� 
		gcDs_etc55.Reset();
	}
 
	/******************************************************************************
		Description :  ��ȸ
	******************************************************************************/ 
	function ln_Query(){
	
		var parm = "gstr1=" + CAR_NO.value
						 + "&gstr2=" + REG_NO.value
						 + "&gstr3=" + PERSON.value
						 + "&gstr4=" + PERSON_NO.value
						 + "&gstr5=" + CAR_TYPE.BindColVal
						 + "&gstr6=" + opener.gcDs1.namevalue(1,"EDT_DATE");

		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCarInfo?NOH=Y&"+parm  ; 
		gcDs1.Reset();
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Clear(){
		CAR_NO.value =""; 
		REG_NO.value =""; 
		PERSON.value =""; 
		PERSON_NO.value =""; 
		CAR_TYPE.BindColVal =""; 
	}

	/******************************************************************************
		Description : �߰�
	******************************************************************************/
	function ln_Add(){
		gcDs1.AddRow();
		
		CAR_TYPE.bindColVal = "";
		gcDs1.namevalue(gcDs1.rowposition,"CARTYPENO") = CAR_TYPE.bindcolval;
	}

	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Save(){
		if (gcDs1.IsUpdated){
			if (confirm("�ű����������� �����Ͻðڽ��ϱ�?")){	
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00106_e1t1?";
				gctr_data.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
				gctr_data.post();
			}
		}
	}


	/******************************************************************************
		Description :  �������� ����
	******************************************************************************/  
	function getCarNo(row){
	  if(gcDs1.countRow> 0 ){
			var ls_param = new Array();
			ls_param[0] = gcDs1.NameValue(row,"CAR_NO"); // �ý��� ���� 
			ls_param[1] = gcDs1.NameValue(row,"PERSON_NO"); // �ý��� ���� 
			ls_param[2] = gcDs1.NameValue(row,"PSN_KNAME"); // �ý��� ���� 
			window.returnValue	=	ls_param  ;
		}

		window.close();  
	}
 
	/******************************************************************************
		Description :  ADD COMBO == "����" 
	******************************************************************************/
	function AddChoice01(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"CAR_TYPE" )  = "" ; 
		obj.NameValue(1,"CAR_NAME" )  = "=����=" ;    
	}

	
</SCRIPT> 

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcDs1" event="onloadCompleted(row,colid)">
	if(gcDs1.countrow <1)	alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<script language =JavaScript for = gcGR0 event =OnDblClick(row,colid) > 
	getCarNo(row);
</script>

<script language=JavaScript for=gcDs_etc5 event=OnLoadCompleted(row,colid)> 
	AddChoice01(gcDs_etc5) ; 
	CAR_TYPE.Index = 0 ; 
</script>  

<script language=JavaScript for=gcGR0 event=OnKeyPress(kcode)>
	CAR_TYPE.bindcolval = gcDs1.namevalue(gcDs1.rowposition,"CARTYPENO");
</script>

<script language="javascript"  for=gcGR0 event=OnClick(Row,Colid)>
	CAR_TYPE.bindcolval = gcDs1.namevalue(gcDs1.rowposition,"CARTYPENO") ;
 </script>

<script language=JavaScript for=gcDs1 event=onRowPosChanged(row)>
	if (gcDs1.RowStatus(row) == "1" ) gcGR0.editable=true;
	else gcGR0.editable=false;
</script> 
	
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	ln_Clear();
	gcDs1.reset();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>
</HEAD>

<BODY onLoad="Start();">
	<table width="475" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;top:5px;">
		<tr> 
			<td width="475" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">  
			  <img src="../../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_Add()">
			  <img src="../../../Common/img/btn/com_b_save.gif"   style="cursor:hand" onclick="ln_Save()">
				<img src="../../../Common/img/btn/com_b_query.gif"  style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="width:477px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;">
					<tr>
						<td class="tab11" bgcolor="#eeeeee" align=center>������ȣ</td>
						<td class="tab21"><input id="CAR_NO" name="CAR_NO" type="text" class="txt11" style='width:100;position:relative;left:8px;top:0px' onkeydown="if(event.keyCode==13) ln_Query();"></td> 
						<td class="tab11" bgcolor="#eeeeee" align=center>�����ڸ�</td>
						<td class="tab21"><input id="PERSON" name="PERSON" type="text" class="txt11" style='width:100;position:relative;left:8px;top:0px' onkeydown="if(event.keyCode==13) ln_Query();"></td> 
					</tr>
					<tr>
						<td class="tab11" bgcolor="#eeeeee" align=center>�����ڹ�ȣ</td>
						<td class="tab21"><input id="PERSON_NO" name="PERSON_NO" type="text" class="txt11" style='width:100;position:relative;left:8px;top:0px' onkeydown="if(event.keyCode==13) ln_Query();" maxlength="10" onBlur="bytelength(this,this.value,10);" disabled></td> 
						<td class="tab11" bgcolor="#eeeeee" align=center>�ֹι�ȣ</td>
						<td class="tab21"><input id="REG_NO" name="REG_NO" type="text" class="txt11" style='width:100;position:relative;left:8px;top:0px' onkeydown="if(event.keyCode==13) ln_Query();" maxlength="13" onBlur="bytelength(this,this.value,13);"></td> 
					</tr> 
					<tr>
						<td class="tab11" bgcolor="#eeeeee" align=center>��������</td>
						<td class="tab21" colspan="3">
						 <%=HDConstant.COMMENT_START%><OBJECT id=CAR_TYPE  style='border:0;position:relative;left:8px;top:1px;width:120px;height:300' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc5>  
								<param name=CBDataColumns		value="CAR_TYPE,CAR_NAME">
								<param name=SearchColumn		value="CAR_NAME">
								<param name=SortColumn			value="CAR_TYPE">  
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="CAR_NAME^0^120"> 
								<param name=BindColumn			value="CAR_TYPE">
								<param name=InheritColor		value="true">  
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:475px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR0 style="width:475;height:381px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"		VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="IndWidth"		VALUE="17">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="true">
								<param name="AllShowEdit" VALUE="true"> 
								<PARAM NAME="Format"			VALUE="  
									<C> Name='������ȣ'		ID=CAR_NO		 HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=center</C> 
									<C> Name='�����ڸ�'		ID=PSN_KNAME HeadAlign=Center HeadBgColor=#eeeeee Width=77  align=center</C> 
									<C> Name='����'				ID=CARTYPENO HeadAlign=Center HeadBgColor=#eeeeee Width=85  align=center  EditStyle=Lookup Data='gcDs_etc5:CAR_TYPE:CAR_NAME'</C> 
									<C> Name='�����ڹ�ȣ' ID=PERSON_NO HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center Edit=none show=false</C> 
									<C> Name='��ȭ��ȣ  ' ID=TEL_NO    HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=left </C> 
									<C> Name='�ֹι�ȣ'		ID=REG_NO		 HeadAlign=Center HeadBgColor=#eeeeee Width=97  align=center Mask='XXXXXX-XXXXXXX'</C>  
								">
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
				</table> 
			</td>
		</tr>  
	</table>


 </body>
</html>

