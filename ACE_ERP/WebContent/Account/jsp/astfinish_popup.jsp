<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �������ó��ȭ��
+ ���α׷� ID	:  AstFinish_popup.html
+ �� �� �� ��	:  �����󰢰�� ����ó��
+ ��   ��  �� :  ������
+ �� �� �� �� :  2009.10.29
-----------------------------------------------------------------------------
+ �� �� �� �� : 
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>������ ����ó��</title>

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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
  
	ln_Before();
}

/******************************************************************************
	Description : �� ��ȸ
******************************************************************************/
function ln_Before() {

	//�����ڵ�[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//������ 
  gcrd_finish.codevalue='1';
	gcem_yyyy.text = gcurdate.substring(0,4);
	gclx_mm.bindcolval = gcurdate.substring(5,7);
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){ 

  if(gcem_yyyy.text==""){
		alert("��ȸ �⵵�� �Է��Ͻʽÿ�.");
		return false;
  }

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>astFinish_popup_s1"
									 + "?v_str1="+gclx_fdcode.bindcolval+"&v_str2="+gcrd_finish.codevalue
									 + "&v_str3="+gcem_yyyy.text;
	gcds_data.Reset(); 
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Finish(){ 
  var strTemp="";

  if(!ln_Chk()) return 

  gcds_insert.clearAll();
	ln_SetDataHeader();
	gcds_insert.Addrow();

  gcds_insert.namevalue(gcds_insert.rowposition,"FDCODE")=gclx_fdcode.bindcolval;
	gcds_insert.namevalue(gcds_insert.rowposition,"YEAR")=gcem_yyyy.text;

	if(gcrd_finish.codevalue=="1"){ //������
		gcds_insert.namevalue(gcds_insert.rowposition,"MONTH")=gclx_mm.bindcolval;
    strTemp = gcem_yyyy.text+"�� "+ gclx_mm.bindcolval+"�� �������� �Ͻðڽ��ϱ�?";

	}else{ //�⸶��
    gcds_insert.namevalue(gcds_insert.rowposition,"MONTH")='00';
		strTemp = gcem_yyyy.text+"�� �⸶���� �Ͻðڽ��ϱ�?";
	}
	gcds_insert.namevalue(gcds_insert.rowposition,"GUBUN")=gcrd_finish.codevalue;
	gcds_insert.namevalue(gcds_insert.rowposition,"CLOSEYN")='Y'
	gcds_insert.namevalue(gcds_insert.rowposition,"WRID")=gs_userid;
	gcds_insert.namevalue(gcds_insert.rowposition,"UPID")=gs_userid;

	if(confirm(strTemp)){
		gctr_data.KeyValue   = "Account.AstFinish_popup_t1(I:USER=gcds_insert)";
		gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>astFinish_popup_t1";
	  gctr_data.post(); 
	}
}

/******************************************************************************
	Description : üũ
******************************************************************************/
function ln_Chk(){

	if(gclx_fdcode.BindColVal==""){
		alert("������ �Է��Ͻʽÿ�.");
		return false;
	}

  if(gcrd_finish.codevalue==""){
		alert("���������� �Է��Ͻʽÿ�.");
		return false;
	}

  if(gcrd_finish.codevalue=="1"){  //������
		if(gcem_yyyy.text=="" ){
			alert("��������� �Է��Ͻʽÿ�.");
			return false;
		}

    if(gclx_mm.bindcolval==""||gclx_mm.bindcolval=="00"){
			alert("�������� �Է��Ͻʽÿ�.");
			return false;
		}

	}else if(gcrd_finish.codevalue=="2"){ //�⸶��
		if(gcem_yyyy.text=="" ){
			alert("��������� �Է��Ͻʽÿ�.");
			return false;
		}
	}

	return true;
}

/******************************************************************************
	Description : Head ����
******************************************************************************/
function ln_SetDataHeader(){

	var s_temp = "FDCODE:STRING(2),YEAR:STRING(4),MONTH:STRING(2),GUBUN:STRING(1),CLOSEYN:STRING(1),"
						 + "WRID:STRING(10),UPID:STRING(10)";
	gcds_insert.SetDataHeader(s_temp);
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</OBJECT>

	<OBJECT id=gcds_insert classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</OBJECT>

	<!-- ���� -->
	<OBJECT id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<param name="KeyName"			value="toinb_dataid4">
	</OBJECT>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<!-- �����з� (�˻�)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	gclx_fdcode.BindColVal=gfdcode;
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcrd_finish event=OnSelChange()>

	if(gcrd_finish.codevalue=="1"){  //������
		//alert("1");
    gcem_yyyy.text = gcurdate.substring(0,4);
	  gclx_mm.bindcolval = gcurdate.substring(5,7);
    gclx_mm.enable2 = true;

	}else if(gcrd_finish.codevalue=="2"){ //�⸶��

	  gcem_yyyy.text = gcurdate.substring(0,4);
		gclx_mm.bindcolval ="00";
		gclx_mm.enable2 = false;
	}
</script>
 
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
  alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>




</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()" >
<table width="650" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/asetdep_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif"  align=right>
		  <img src="../../Common/img/btn/com_b_finish.gif"  style="cursor:hand" onclick="ln_Finish()">
			<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand" onClick="ln_Query()">
	</td>
  </tr>
  <tr>  
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:650px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="60px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee" class="tab21" align=center>����</td>
					<td class="tab12" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;width:90px;">&nbsp;
						<comment id="__NSID__">
							<object id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:80px;">
								<param name=ComboDataID			value="gcds_fdcode">
								<param name=CBDataColumns		value="FDCODE, FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				    value=false>
								<param name=ListExprFormat	value="FDNAME^0^80">
								<param name=BindColumn			value="FDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
					</td> 
					<td width="60px"  bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;">��������</td>  
					<td class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;width:140px;">&nbsp;
						<comment id="__NSID__">
						<object id=gcrd_finish classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:120">
							<param name=Cols	  value="2">
							<param name=Format	value="1^������,2^�⸶��">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab21" style="height:30px;width:60px;" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;">�������</td> 
				  <td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:30px;font-family:����;font-size:9pt; " width="160px;" >&nbsp;    
						<comment id="__NSID__">
						<object id=gcem_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							style="position:relative;top:2px;left:0px;width:35px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
						</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;

						<comment id="__NSID__">
						<object id=gclx_mm classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;top:2px;left:0px;width:50px;height:200px;">
							<param name=CBData			    value="01^01��,02^02��,03^03��,04^04��,05^05��,06^06��,07^07��,08^08��,09^09��,10^10��,11^11��,12^12��">
							<param name=CBDataColumns	  value="MINORCD,MINORNM">
							<param name=CBDataColumns	  value="MINORCD,MINORNM">
							<param name=Sort			      value=True>
							<param name=ListExprFormat	value="MINORNM^0^50">		
							<param name=BindColumn			value="MINORCD">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>  
							
	<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;top:3px;width:280px;border:0 solid #708090;">
		<tr> 			
			<td style="width:280" ALIGN=LEFT VALIGN=TOP>
				<comment id="__NSID__">
				<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
					style="position:relative;left:3px;width:648px; height:280px; border:1 solid #708090;display:block;" viewastext>
						<param name="DataID"		  value="gcds_data">
						<param name="IndWidth"		value ='0'>
						<param name="BorderStyle"	value="0">
						<param name="Fillarea"		value="true">
						<param name="Sortview"		value="left">
						<param name="ColSizing"		value="true">
						<param name="Editable"		value="false"> 
						<param name="Format"		  value="  
						<C> Name='����'	       ID=FDCODE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center  EditStyle=Lookup	Data='gcds_fdcode:FDCODE:FDNAME'</C> 
						<C> Name='�����⵵'	   ID=YEAR  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center	</C> 
						<C> Name='������'		   ID=MONTH     HeadAlign=Center HeadBgColor=#B9D4DC Width=60  	align=center	</C> 
						<C> Name='��������'		 ID=GUBUN     HeadAlign=Center HeadBgColor=#B9D4DC Width=90   align=center	EditStyle=Combo Data='1:������,2:�⸶��'</C> 
						<C> Name='��������'		 ID=CLOSEYN   HeadAlign=Center HeadBgColor=#B9D4DC Width=90   align=center	EditStyle=Combo Data='Y:�����Ϸ�,N:�������'</C> 
						<C> Name='�۾���'		   ID=EMPNMK    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=center  </C> 
						<C> Name='�۾��Ͻ�'	   ID=UPDT      HeadAlign=Center HeadBgColor=#B9D4DC Width=170  align=center  </C> 
						">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script>

				<fieldset style="position:relative;left:3px;width:650px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</table>		

<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
==================================================================================================================
-->
<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 