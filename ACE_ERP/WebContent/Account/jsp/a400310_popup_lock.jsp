<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �����û - �ŷ�ó�� ���¹�ȣ ��ȸ
+ ���α׷� ID	:  a400310_popup_lock.jsp
+ �� �� �� ��	:  �ŷ�ó�� ���¹�ȣ ��ȸ 
+ ��   ��  �� :  ������
+ �� �� �� �� :  2017.10.17
-----------------------------------------------------------------------------
+ �� �� �� �� : 
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: a300060_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ŷ�ó�� ���¹�ȣ ��ȸ</title>
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
var gs_hisdat = gs_date;

var gs_deptcd="";
var gs_deptnm="";

var strParam = new Array();

strParam=window.dialogArguments;

alert("strParam[0]::"+strParam[0]);



/******************************************************************************
	Description : �� ��ȸ
******************************************************************************/
function ln_Before() {
	 txt_vendnm.value = strParam[0];	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){ 
		
   
    
 
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_popup_s1"
									   							+"?v_str1="+txt_vendnm.value;
	gcds_code01.Reset(); 
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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
	
	//document.all.LowerFrame.style.visibility="visible";
	
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	
	//document.all.LowerFrame.style.visibility="hidden";
	
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
	
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnDblClick()">

		var row = gcds_code01.rowposition;
		
		window.returnValue =  gcds_code01.namevalue(row,"VEND_CD") + ";" 
			                + gcds_code01.namevalue(row,"VEND_NM") + ";" 
	                   	 	+ gcds_code01.namevalue(row,"ACCT_NO") + ";"
	                   	    + gcds_code01.namevalue(row,"VEND_ID") + ";"
	                     	+ gcds_code01.namevalue(row,"ACCT_AUTH") +";";
	                   	 		                   	 	
		window.close();

</script>


<script language=JavaScript for="gcgd_disp01" event=OnKeyPress(kcode)>

	if (kcode==13){
		var row = gcds_code01.rowposition;
		window.returnValue = gcds_code01.namevalue(row,"VEND_NM") + ";" 
	                   	   + gcds_code01.namevalue(row,"ACCT_NO")+";";
		window.close();		
	} 

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Before()" >

<table width="670" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"  align=right style="padding-top:10px;">
		<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand" onClick="ln_Query()">
	</td>
  </tr>
  <tr><td>&nbsp;</td></tr>
    
  <tr>  
    <td>
		<table  cellpadding="1" cellspacing="0" style='width:670px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
					<td class="tab21" style="height:30px;width:60px;" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;">��Ϲ�ȣ</td> 
				  	<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:30px;font-family:����;font-size:9pt;">&nbsp;    
						<input id="txt_vendnm" type="text"  style= "position:relative;top:-1px;left:-1px; width:150px; height:20px;" readOnly="true" class="txtbox" onkeydown="if(event.keyCode==13) ln_Query();">			
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
					style="position:relative;left:3px;width:670px; height:290px; border:1 solid #708090;display:block;" viewastext>
						<param name="DataID"		value="gcds_code01">
						<param name="IndWidth"		value ='0'>
						<param name="BorderStyle"	value="0">
						<param name="Fillarea"		value="true">
						<param name="Sortview"		value="left">
						<param name="ViewSummary"	value="1">
						<param name="ColSizing"		value="true">
						<param name="Editable"		value="false"> 
						<param name="Format"		value="  
						<C> Name='No'	     	    ID={CURROW}    HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=center  SumBgColor='#C3D0DB'	</C> 
						<C> Name='�ŷ�ó��'		    ID=VEND_NM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=160	  align=left  	SumBgColor='#C3D0DB'	</C> 
						<C> Name='���¹�ȣ'		   	ID=ACCT_NO     HeadAlign=Center HeadBgColor=#B9D4DC Width=145	  align=left    SumBgColor='#C3D0DB'	</C>
						<C> Name='����ڹ�ȣ'		   	ID=VEND_ID     HeadAlign=Center HeadBgColor=#B9D4DC Width=98	  align=center  SumBgColor='#C3D0DB'  mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XX****X')}	</C>
						<C> Name='������'		        ID=ACCT_AUTH   HeadAlign=Center HeadBgColor=#B9D4DC Width=160	  align=left  	SumBgColor='#C3D0DB'	</C> 
						">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script>

				<fieldset style="position:relative;left:3px;width:690px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
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



