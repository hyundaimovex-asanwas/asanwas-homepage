<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:  �ڱݰ��� - �����Ա���Ȳ
+ ���α׷� ID	:   A700006.html
+ �� �� �� ��	:   ���,��ȸ ȭ���̴�.
+ ��   ��  �� :   
+ �� �� �� ��	:	
------------------------------------------------------------------------------>

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
gs_fdcode = gfdcode;
gs_cocode = gcocode;
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
function ln_Query(s){
	var str1  = gclx_sfdcode1.BindColVal;				//�����ڵ�   
	var str2  = gclx_cadeptcd.BindColVal				//�μ�      
	var str3  = fn_trim(gcem_sgetdatefr1.text);			//�Ա�����fr
	var str4  = fn_trim(gcem_sgetdateto2.text);			//�Ա�����to

	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070006_s1"
										+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
										+ "&v_str4="+str4;
	gcds_data1.Reset();
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(e){
	alert("�غ����Դϴ�.");
	/*
	if(gcds_print1.countrow<1) {
		alert("����� ������ �����ϴ�.");
	}else	gcrp_print1.preview();
	*/
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){
	if(e=="01"){
		if (gcds_data1.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp01.RunExcel('�����Ա���Ȳ');
	}
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	gcem_sgetdatefr1.text = gs_date2+"01";	 
	gcem_sgetdateto2.text = gs_date;	
							
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_hcdept_s2?v_str1="; 
	gcds_dept1.Reset();

	gcds_dept00.DataID = "<%=dirPath%>/servlet/Person.h010003_s1?v_str1=&v_str2=";
	gcds_dept00.Reset();
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SubsumExpr"	VALUE="1:ACDATE:DEPTCD">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_dept1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_dept00" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

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

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	gclx_sfdcode1.BindColVal =  gs_fdcode;
//	gclx_sfdcode1.index=0;
</script>

<script language="javascript" for="gcds_dept1" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	gcds_dept1.InsertRow(1);
	gcds_dept1.NameValue(1,"DEPTCD")="";
	gcds_dept1.NameValue(1,"DEPTNM")="";
	gclx_cadeptcd.BindColVal =  gs_deptcd;
//	gclx_cadeptcd.index=0;
</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/a070006_head.gif">
		</td>
		<td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;
		</td>
	</tr>
	<tr> 
		<td colspan=2 align=left style="position:relative;left:5px">
		</td>
	</tr>
	<tr> 
		<td COLSPAN=2>
			<table cellpadding="0" cellspacing="0" border="0" style="display:block">
				<tr>
					<td height="3px">
					</td>
				</tr>
				<tr>
					<td colspan=8 align=left style="position:relative;left:0px">
						<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
							<tr>
								<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr>
								</td>
								<td class="tab23" style="width:90px">
									<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
									<param name=ComboDataID			value="gcds_sfdcode1">
									<param name=CBDataColumns		value="FDCODE,FDNAME">
									<param name=SearchColumn		value="FDNAME">
									<param name=Sort						value="false">
									<param name=ListExprFormat	value="FDNAME^0^80">
									<param name=BindColumn			value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>�μ�</nobr>
								</td>
								<td class="tab23" style="width:120px">
								<comment id="__NSID__"><OBJECT id=gclx_cadeptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
									<param name=ComboDataID			value="gcds_dept1">
									<param name=CBDataColumns		value="DEPTCD,DEPTNM">
									<param name=SearchColumn		value="DEPTNM">
									<param name=Sort				value=false>
									<param name=ListExprFormat	    value="DEPTNM^0^110">
									<param name=BindColumn			value="DEPTCD">
									</OBJECT></comment><script>__ws__(__NSID__);</script> 	
								</td>
								<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>�Ա�����</nobr>
								</td>
								<td style="width:210px">
									<comment id="__NSID__"><object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										<param name=Enable				value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
									<comment id="__NSID__"><object id=gcem_sgetdateto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										<param name=Enable				value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
								<td align="right">&nbsp;<nobr>      
									<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
									<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
									<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
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
								<td style="width:460" ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
										<PARAM NAME="DataID"        VALUE="gcds_data1">
										<PARAM NAME="Editable"			VALUE="false">
										<PARAM NAME="BorderStyle"		VALUE="0">
										<PARAM NAME="IndWidth"			VALUE="0">
										<PARAM NAME="ColSizing"			VALUE="true">
										<param NAME="Fillarea"      VALUE="true">
										<PARAM NAME="viewSummary"		VALUE="1">
										<PARAM NAME="Format"        VALUE="  
											<C> Name='No.'			ID={CURROW}	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40	align=center	SumText=''		SumBgColor='#C3D0DB'	</C> 
											<C> Name='�Ա�����'		ID=ACDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center    SumText='��'	    SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'	SubSumText='�ϰ�'</C>
											<C> Name='�μ�'			ID=DEPTCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=320	align=left		SumText=''		SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_dept00:DEPTCD:DEPTNM' SubSumText=''</C>
											<C> Name='�Աݾ�'			ID=PYAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=right		SumText=@sum	SumBgColor='#C3D0DB' </C>
											<C> Name='����'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=280	align=left		SumText=''		SumBgColor='#C3D0DB' SubSumText=''</C>
											">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
									&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
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
	<param name="Format"			value="
	">
</object></comment><script>__ws__(__NSID__);</script> 
 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 