<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-----------------------------------------------------------------------------
+ �� �� �� ��	:	����������ʻ���
+ ���α׷� ID	: P030001.HTML
+ �� �� �� ��	: ����,��ȸ
+ �� �� �� ��	: 
+ �� �� �� ��	:  p030001_s1  -��ȸ
                 p030001_s2  -����
-------------------------------------------------------------------------------
+ �� �� �� ��	: �������� ���� ���μ��� ����
+ ��   ��  �� : ��  ��  ��
+ �� �� �� �� : 2010.11.29.��
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>����������ʻ���</title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>


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
get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7)

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcem_curdt.text = gs_date;	//������
  gcem_yyyy.text=parseInt(gcurdate.substring(0,4));

  //�ӽ÷� ����
	gcem_yyyy.text="2010";//2009
  //gcem_yyyy.text='20050701' //�ӽ� 
}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030001_s1?v_str1=" + gcem_curdt.text+"&v_str2="+gcem_yyyy.text+"12"; 
//	prompt("gcds_data", gcds_data.DataID);
	gcds_data.Reset(); 

}

/******************************************************************************
	Description : ����
	2010.11.30 ���� ���� ������.
	SP_Y101000 : Y  - ��������
	             10 - ���ʻ��� ����
							 10 - �⵵
							 00 - ����
******************************************************************************/
function ln_Create(){
 
  /*
	gcds_create.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030001_s2?v_str1=" + gcem_curdt.text //��������
																													+"&v_str2=Y" 
																													+"&v_str3="+ gcem_yyyy.text+"12"
																													+"&v_str4=SP_Y100000"; 
	//prompt("gcds_create", gcds_create.DataID);
	gcds_create.Reset(); 
  */
  /**
	gcds_create.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031001_s2?v_str1=" + gcem_curdt.text //��������
																													+"&v_str2=Y" 
																													+"&v_str3="+ gcem_yyyy.text+"12"
																													+"&v_str4=SP_Y101000"; 
	//prompt("gcds_create", gcds_create.DataID);
	gcds_create.Reset(); 
  **/

  if (gcds_data.namevalue(1,"WRKSTS") == 'C') {
			alert("�̹� ����ó�� �Ǿ����ϴ�.");
			return false;
	}


  //�ҵ��ں���õ¡�� ������ ���� üũ 

  gcds_temp.ClearAll();
  ln_SetDataHeader();
  gcds_temp.Addrow();
	gcds_temp.namevalue(gcds_temp.rowposition,"APPYY")=gcem_yyyy.text;
	gcds_temp.namevalue(gcds_temp.rowposition,"APPYMD")=gcem_yyyy.text+"1231";

	if (confirm("��õ¡�� �����͸� ���� �Ͻðڽ��ϱ�?")){	
		gctr_data.KeyValue = "Payroll.p030001_t1(I:USER=gcds_temp)";
		gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030001_t1";
		//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
		//prompt('gcds_ihead',gcds_ihead.text);
		gctr_data.post();
	}

}

/******************************************************************************
	Description : Head ����
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "APPYY:STRING(4),APPYMD:STRING(8)";					
	gcds_temp.SetDataHeader(s_temp);
}


/******************************************************************************
	Description : üũ
******************************************************************************/
function ln_Chk(){
	
	if(gcem_yyyy.text==""){
	  alert("�ͼӳ⵵�� Ȯ���Ͻʽÿ�!");
		gcem_yyyy.Focus();
		return false;
	}
		
	//����üũ - YCPERCOL�� �����Ͱ� �����ϸ� �������� ����.
 	gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030001_s2?v_str1="+gcem_yyyy.text; 
  gcds_chk.Reset(); 
		
	return true;
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

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
	Description : �۾����� 
******************************************************************************/
function ln_WorkSts(strPaycd,strGb,strMemo){

  gcds_worksts.ClearAll();
	var s_temp = "APPDT:STRING(6),PAYDT:STRING(8),PBDIV:STRING(1),PAYCD:STRING(8),WRKSTS:STRING(1),MEMO:STRING(100)";					
	gcds_worksts.SetDataHeader(s_temp);
  gcds_worksts.Addrow();

	gcds_worksts.namevalue(gcds_worksts.rowposition,"APPDT")=gcem_yyyy.text+"12";
	gcds_worksts.namevalue(gcds_worksts.rowposition,"PAYDT")=gcem_yyyy.text+"1231";
  gcds_worksts.namevalue(gcds_worksts.rowposition,"PAYCD")=strPaycd;
	gcds_worksts.namevalue(gcds_worksts.rowposition,"WRKSTS")=strGb;
	gcds_worksts.namevalue(gcds_worksts.rowposition,"MEMO")=strMemo;
	
	gctr_data2.KeyValue = "Payroll.worksts_t1(I:USER=gcds_worksts)";
	gctr_data2.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>worksts_t1";
	//prompt('',gcds_worksts.text);
	gctr_data2.post();
}

/******************************************************************************
	Description : �������� 
******************************************************************************/
function ln_Finish(){
	var row = gcds_data.rowposition;
	var str1 = gcem_yyyy.text+"12";
	var str2 = 'Y';
	var str3 = "Y101001S";

	if(gcds_data.Countrow>0){
		if (gcds_data.namevalue(1,"WRKSTS") == 'C') {
			alert("�̹� ����ó�� �Ǿ����ϴ�.");
			return false;
		}else{
			gcds_data.namevalue(1,"WRKSTS") = 'C';
			if (confirm("�������� ���ʻ����� ���� �Ͻðڽ��ϱ�?")){
				gctr_data3.KeyValue = "worksts_t2(I:USER=gcds_data)";
				gctr_data3.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>worksts_t2?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;
				gctr_data3.Post();
				ln_Query();
			}else{
				return false;
			}
		}
	}
}

</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_create classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ���� DS -->
</OBJECT>

<OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ���� DS -->
</OBJECT>

<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- üũ DS -->
</OBJECT>

<OBJECT id=gcds_worksts classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �۾����� DS -->
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>
<object  id=gctr_data2 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data3 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	  alert("������ �߻� �߽��ϴ�.");
	  window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
  ft_cnt1.innerText = "��ȸ�Ǽ� : " + rowcount + " ��";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_create" event="OnLoadStarted()">
	//ft_cnt1.innerText="����Ÿ �������Դϴ�.";
	window.status=" �������� ���� �������Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_create" event="onloadcompleted(row,colid)">

	window.status="  �������� ���� ������ �Ϸ� �߽��ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if(gcds_create.countrow <=0)
		alert("���ϰ��� �����ϴ�.");
	else {
		if(gcds_create.NameValue(1,"RETCOD") =="Y")
		alert( "����� ���������� ���� �Ǿ�����\n��ȸ ��ư�� ����Ͽ� ������¸� ��ȸ�Ͻñ� �ٶ��ϴ�.");
		else
		alert( "����� ���������� ���� ���� �ʾҽ��ϴ�.");
		}
	window.status="";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gctr_data event=OnSuccess()>
	ln_WorkSts('Y101001S','2','������������ ���� �� �ҵ�ݾ� ����'); //�۾�����
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
  ln_WorkSts('Y101001S','E','������������ ���� �� �ҵ�ݾ� ���� ����');
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data2 event=OnFail()>
  //alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	//alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>


</HEAD>

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p030001_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>	 
		  <img src="../../Common/img/btn/com_b_finish.gif" style="cursor:hand" onclick="ln_Finish()">
			<img src="../../Common/img/btn/com_b_create.gif" style="cursor:hand" onclick="ln_Create()">
			<img src="../../Common/img/btn/com_b_query.gif"  style="cursor:hand" onclick="ln_Query()" >
			</nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			
			<table cellpadding="0" cellspacing="0" border="0" style='width:877px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="100px" class="tab12" bgcolor="#eeeeee">&nbsp;�ͼӳ⵵&nbsp;</td>
					<td style="width:110px; height:30px;border:0 solid #708090;border-right-width:1px;padding-top:0px;"><nobr><comment id="__NSID__"><object id=gcem_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:6px;top:1px; width:40px; height:20px; font-family:����; font-size:9pt;z-index:2; ">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	    value=true>
							<param name=Numeric				value=false>
							<param name=Format	      value="YYYY">
							<param name=MaxLength     value=8>
							<param name=PromptChar		value="_">
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td width="100px" class="tab12" bgcolor="#eeeeee">&nbsp;��������&nbsp;</td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:3px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	    value=true>
							<param name=Numeric				value=false>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=MaxLength     value=8>
							<param name=PromptChar		value="_">
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_curdt', 'Text')"   style="position:relative;width:20px;left:5px;cursor:hand;">
							</nobr>
					</td>
						<td width="580px"  bgcolor="#FFFFFF">&nbsp;</td>
						<td width="500px" style="height:30px;border:0 solid #708090;">&nbsp;</td>
					</tr>
				</table>
		</td>
  </tr>
  <tr><td colspan="2" height=3></td></tr>
  <tr> 
    <td colspan="2"> 
			<comment id="__NSID__"><OBJECT id=gcgd_data classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH:875px;HEIGHT:423px;border:1 solid #777777" viewastext>
				<PARAM NAME="DataID"			VALUE="gcds_data">
				<PARAM NAME="Editable"		VALUE="FALSE">
				<PARAM NAME="ColSizing"		VALUE="True">
				<PARAM NAME="BorderStyle" VALUE="0">
				<param name="Fillarea"		VALUE="true">
				<PARAM NAME="Format"			VALUE="
					<C> Name='������'		ID=APPDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=center  Mask='XXXX/XX' </C>
					<C> Name='���걸��'		ID=PAYDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center </C>
					<C> Name='�޿��׸�'		ID=PAYCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center</C>
					<C> Name='������'			ID=FRDT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center  Mask='XXXX/XX/XX'</C> 
					<C> Name='���۽ð�'		ID=FRTM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center Mask='XX:XX:XX' </C> 
					<C> Name='������'			ID=TODT			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center  Mask='XXXX/XX/XX'</C>
					<C> Name='����ð�'		ID=TOTM			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center  Mask='XX:XX:XX' </C>
					<C> Name='����'				ID=WRKSTS		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=center  Value={Decode(WRKSTS,1,'������',2,'�Ϸ�','E','����','C','����')} </C>
					<C> Name='���'				ID=MEMO			HeadAlign=Center HeadBgColor=#B9D4DC Width=280 align=left</C>
				">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
				<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
			</fieldset>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	


