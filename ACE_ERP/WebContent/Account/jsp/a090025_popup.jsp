<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �ڻ��̵� �� ��ü ����
+ ���α׷� ID	:  A090025_popup.html
+ �� �� �� ��	:  
+ ��   ��  �� :  ������
+ �� �� �� �� :  2011.04.18
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
<title>�ڻ��̵�(��ü)����</title>

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
var gs_deptcd="";
var gs_deptnm="";
var strParam = new Array();
strParam=window.dialogArguments;

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
	
  gclx_fdcode.bindcolval =strParam[0];
	gcem_astnbr.text= strParam[1];
	gcem_astnm.text = strParam[2];
	
	ln_Query();

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){ 

	var str1 = strParam[0]; //����
	var str2 = strParam[1]; //�ڻ��ȣ
	var str3 = strParam[2]; //�ڻ��
 
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090025_popup_s1"
									   + "?v_str1="+str1
										 + "&v_str2="+str2
									   + "&v_str3="+str3;

  //prompt('',gcds_code01.DataID);
	gcds_code01.Reset(); 
}

/******************************************************************************
	Description : üũ
******************************************************************************/
function ln_Chk(p1){

	if (p1=="01"){
		if(gclx_fdcode.BindColVal=""){
			alert("�Ҽ��ڵ带 �Է��ϼ���.");
			return false;
		}
		return true; 
	}
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ���� -->
<comment id="__NSID__"><OBJECT id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>


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
	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<!-- �����з� (�˻�)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	gclx_fdcode.BindColVal=strParam[0].substr(0,2);
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()" >
<table width="650" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a090025_popup_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif"  align=right>
			<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand" onClick="ln_Query()">
	</td>
  </tr>
  <tr>  
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:650px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="60px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee" class="tab21" align=center>����</td>
					<td class="tab12" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;width:130px;">&nbsp;
						<comment id="__NSID__">
							<object id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:-16px;top:1px;font-size:12px;width:90px;">
								<param name=ComboDataID			value="gcds_fdcode">
								<param name=CBDataColumns		value="FDCODE, FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				    value=false>
								<param name=ListExprFormat	value="FDNAME^0^80">
								<param name=BindColumn			value="FDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
					</td> 
					<td width="60px"  bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;"> �ڻ��ȣ</td>  
					<td class="tab22" style="width:130px;" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;">&nbsp;
						<comment id="__NSID__">
						<object id=gcem_astnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="########">
							<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab21" style="height:30px;width:60px;" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;">�ڻ��</td> 
				  <td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:30px;font-family:����;font-size:9pt; " width="130px;" >&nbsp;    
						<comment id="__NSID__">
						<object id=gcem_astnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							style="position:relative;top:2px;left:0px;width:110px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value="true">
							<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script>
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
					style="position:relative;left:3px;width:648px; height:300px; border:1 solid #708090;display:block;" viewastext>
						<param name="DataID"		value="gcds_code01">
						<param name="IndWidth"		value ='0'>
						<param name="BorderStyle"	value="0">
						<param name="Fillarea"		value="true">
						<param name="Sortview"		value="left">
						<param name="ColSizing"		value="true">
						<param name="Editable"		value="false"> 
						<param name="Format"		value="  
						<C> Name='�ڻ��ȣ'	   ID=ASTNBR 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=53	    align=center  </C> 
						<C> Name='�ڻ��'		   ID=ASTNM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=120    align=left  	</C> 
						<C> Name='����'   		 ID=ASTGUBUN  HeadAlign=Center HeadBgColor=#B9D4DC Width=35 	  align=center	  EditStyle=Combo Data='0:����,1:�Ű�,2:���,8:��ü,9:�̵�' </C> 
						<C> Name='�̵�����'    ID=MOVDATE   HeadAlign=Center HeadBgColor=#B9D4DC Width=67 	  align=center	  MASK='XXXX/XX/XX'</C> 
						<C> Name='���μ�'		 ID=AUSEDPTNM HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left   </C> 
						<C> Name='�����μ�'	   ID=AMNGDPTNM HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left   </C> 
						<C> Name='������'	     ID=ACOSTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left	 </C> 
						<C> Name='�����'	  	 ID=AUSERNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	  align=left   </C>
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