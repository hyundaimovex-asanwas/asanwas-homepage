<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:  �ڱݰ��� - �����ڱݽ�û����
+ ���α׷� ID	:   A700002.html
+ �� �� �� ��	:   ���,��ȸ ȭ���̴�.
+ ��   ��  ��   :  
+ �� �� �� ��	:	
------------------------------------------------------------------------------
+ �� �� �� ��  :	�������� ����
+ ��   ��  ��  :  �̹���
+ �� �� �� ��  :  2007. 2. 23
+ �� �� �� ��	: a070002_s1, a070007_s6
----------------------------------------------------------------------------->

<html>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ڱݰ���</title>  


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var g_chk = "";
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	//	var str1 = gclx_sfdcode.BindColVal;   //����
	//	var str2 = gcem_sgetdatefr.text;			//��û����
	//	var str3 = gclx_statcd.bindcolval;		//��������


		var str1  = gclx_sfdcode.BindColVal;				    //�����ڵ�   
		var str2  = gclx_cadeptcd.BindColVal;					//�μ��ڵ�       
		var str3  = fn_trim(gcem_sgetdatefr1.text);	           //��û����
		var str4  = fn_trim(gcem_sgetdateto2.text);	           //��û���� 



		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070002_s1_1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
		gcds_data1.Reset();

		gcds_temp.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s6"
											+ "?v_str1="+str1+"&v_str2="+str2;
		gcds_temp.Reset();
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Finish(){
	if (gcds_data1.countrow>0) {
	//	if(gclx_statcd.bindcolval =="N") {
		if(ln_Chk()) {
				if (confirm("����ó�� �Ͻðڽ��ϱ�?")){
				
						//prompt('', gcds_data1.Text);
						gctr_data1.KeyValue = "Account.a070002_t1_1(I:USER=gcds_data1)";
						gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070002_t1_1";
						gctr_data1.Parameters = "v_str1=Y"+",v_str2="+gs_date;//+",v_str3="+str3;
						gctr_data1.post();
				//	}
				}
		}
	//	}else alert("�̹� ����ó���Ǿ����ϴ�");
	}else alert("����ó���� ������ �����ϴ�.");
}

/******************************************************************************
	Description : �ʼ��׸� �Է�üũ 
******************************************************************************/
function ln_Chk() {

row = gcds_data1.rowposition;
	if(gcds_data1.NameValue(row,"STATDIV") == "Y"){ 
		alert("�̹� ������ �� ���Դϴ�. ") ; 
	//	gcds_data1.NameValue(row,"CHECK" )   ="F" ;  
		return false ;
	}
 return true; 
}
/*	var str1  = gclx_sfdcode.BindColVal;				  //�����ڵ�         
	var str2  = fn_trim(gcem_sgetdatefr2.text);            //�ǻ�����
	
	if(ln_magam(str1,str2,'A')==true) {
		alert("�̹� ����ó���Ǿ����ϴ�");
		return true;
	}

	if(ln_magam(str1,str2,'B')==true) {
		alert("���� �������� ���� �ڷᰡ �����մϴ�");
		return true;
	}

	return false;
}
*/
/******************************************************************************
	Description : ����
******************************************************************************/
function ln_magam(parm1,parm2,gubn) {
//gubn="A":�ش��ϸ�������üũ    gubn="B":���ϸ�������üũ  gubn="C":������ҽ� ����üũ
	switch(gubn) {
		case "A":
			gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070002_s2"
											+ "?v_str1="+parm1+"&v_str2="+parm2;
			gcds_data2.Reset();
	
			if(gcds_data2.countrow>0) {
				return true;
			}
			break;
		case "B" :
			gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070002_s3"
											+ "?v_str1="+parm1+"&v_str2="+parm2;
			gcds_data3.Reset();
	
			if(gcds_data3.countrow>0) {
				return true;
			}
			break;
		case "C" :
			gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070002_s4"
											+ "?v_str1="+parm1+"&v_str2="+parm2;
			gcds_data4.Reset();
	
			if(gcds_data4.countrow>0) {
				return true;
			}
			break;
	}

	return false;
}


/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){
	if(gcds_data1.countrow>0){
		if(gclx_statcd.bindcolval =="Y") {
			if (confirm("����ó���� ����Ͻðڽ��ϱ�?")) {
				var str1  = gclx_sfdcode.BindColVal;				   //�����ڵ�         
				var str2  = fn_trim(gcem_sgetdatefr.text);            //����
				if(ln_magam(str1,str2,"C")==false) {
					var str1 = gclx_sfdcode.BindColVal;				  //�����ڵ�         
					var str2 = fn_trim(gcem_sgetdatefr.text);         //����
					var str3 = "D";
					gctr_data1.KeyValue = "Account.a070002_t1(I:USER=gcds_data1)";
					gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070002_t1";
					gctr_data1.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3;
					gctr_data1.post();
				} else alert("�ش��Ϻ��� ū ��¥�� �����ڷᰡ �����մϴ�");
			}
		}else alert("�̹� ������ ��ҵǾ����ϴ�.");
	}else alert("����� ������ �����ϴ�.");
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	//gcem_sgetdatefr.text = gs_date;
//	gcem_sgetdatefr1.text = gs_date;            //��û����
//	gcem_sgetdateto2.text = gs_date;           //��û���� 

	gcem_sgetdatefr1.text = gs_date2+"01";	 
	gcem_sgetdateto2.text = gs_date;	


	//gclx_statcd.index=1;
	
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();

	gcds_com.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0054"; 
	gcds_com.Reset();

	gcds_dept.DataID = "<%=dirPath%>/servlet/Person.h010003_s1?v_str1=&v_str2=";
	gcds_dept.Reset();

	gcds_dept1.DataID = "<%=dirPath%>/servlet/Person.hcdept_s2?v_str1=";
	gcds_dept1.Reset();

//	gcds_temp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s6?v_str1="+gclx_sfdcode.BindColVal+"&v_str2="+gcem_sgetdatefr.text;
//	gcds_temp.Reset();
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false">
	<PARAM NAME="SubSumExpr" VALUE="1:DEPTCD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_com" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_temp" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object  id="gcds_dept1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<OBJECT id=gctr_data1 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="";
	gclx_sfdcode.BindColVal = gs_fdcode;
</script>

<script language="javascript" for="gcds_com" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";       
	gcds_com.InsertRow(1);
	gcds_com.NameValue(1,"CDCODE")="";
	gcds_com.NameValue(1,"CDNAM")="";
</script>

<script language="javascript" for="gcds_temp" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		//gclx_statcd.bindcolval = "N";
	}else{
		gclx_statcd.bindcolval = gcds_temp.namevalue(row,"CHK");
	}
</script>


<script language=JavaScript for=gcgd_disp01 event=OnClick(row,colid)> 

	if (colid!="CHECK") return;



	if(colid == "CHECK") {
		if (gcds_data1.NameValue(row,colid) == "T") gcds_data1.NameValue(row,colid) = gcds_data1.orgNameValue(row,colid);
		else gcds_data1.NameValue(row,colid) = "T";
	} 

	
	
</script>



<script language="javascript" for="gcds_dept1" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";     
	gcds_dept1.InsertRow(1);
	gcds_dept1.NameValue(1,"DEPTCD")="";
	gcds_dept1.NameValue(1,"DEPTNM")="";
	gclx_cadeptcd.BindColVal = gs_deptcd;
</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data1" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_data1" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");


</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
 
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a070002_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:5px">
      <table width="0" cellpadding="1" cellspacing="0" border="0" style="position:relative;top:4px;left:-6px;">
		<tr> 
			<td width="0" align=left><nobr></nobr>
			</td>
        </tr>
      </table>
	</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
<!-- �ڱݽ�û���� ===========================================================================================================-->
<table cellpadding="0" cellspacing="0" border="0" style="position:absolute;top:52px;">	
<!-- <tr><td height="3px"><td></tr>
	<tr><td height="3px"><td></tr> -->
	<tr>
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>�μ�</nobr>
					</td>
					<td class="tab23" style="width:120px"><comment id="__NSID__">
						<OBJECT id=gclx_cadeptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
								<param name=ComboDataID			value="gcds_dept1">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="DEPTNM^0^110">
								<param name=BindColumn			value="DEPTCD">
							</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��û����</nobr>
					</td>
					<td style="width:210px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="YYYY/MM/DD">
							<param name=PromptChar		value="_">
							<param name=Enable			value="true">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
						<comment id="__NSID__"><object id=gcem_sgetdateto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="YYYY/MM/DD">
							<param name=PromptChar		value="_">
							<param name=Enable			value="true">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td align="right">&nbsp;<nobr>  
						<img src="../../Common/img/btn/com_b_cancle.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Cancel()">				
						<img name="btn_finish"  src="../../Common/img/btn/com_b_finish.gif"		style="position:relative;top:2px;cursor:hand" onclick="ln_Finish()"> 
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
			</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
								<F> Name=''					ID='CHK'		HeadAlign=Center HeadBgColor=#B9D4DC Width=20		align=center EditStyle=CheckBox, cursor=hand, edit=none, bgcolor=@ucolor</F>
								<C> Name='No.'				ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='��û����'		ID=ACDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX' show=true</C>
								<C> Name='��������'		ID=STATDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''		SumBgColor='#C3D0DB'  show=true </C>
								<C> Name='�μ�'				ID=DEPTCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=220	align=left		SumText='��'	SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_dept:DEPTCD:DEPTNM' SubSumText='               �Ұ�'</C>
								<C> Name='��������'		ID=ATKORNAM	HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='��û�ݾ�'		ID=PLAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='���ޱ���'		ID=AMTDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center	SumText=''		SumBgColor='#C3D0DB' EditStyle='combo' Data='C:����,B:����'</C>
								<C> Name='��������'		ID=EXDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								<C> Name='��������'		ID=STDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								<C> Name='����'				ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data1>
	<param name=BindInfo  value='  
		<C>Col=STDIV		Ctrl=gclx_stdiv1		Param=BindColVal</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"					value="
	">
</object></comment><script>__ws__(__NSID__);</script> 



</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 