<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	: ä�ǰ��з���ȸ 
+ ���α׷� ID: a070024.jsp
+ �� �� �� ��	: ä�ǰ��з���ȸ 
+ ��  ��   ��  : �� �� ��
+ �� �� �� �� : 2017.03.15
-----------------------------------------------------------------------------
+ �� �� �� ��	: a070024_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>ä�ǰ��з���ȸ</title>

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

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode = gfdcode;

<%
/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	gcra_usegb_0.codevalue ="1";
	//gcem_recdat_fr.text = gs_date2+"01";
	//gcem_recdat_to.text = gs_date;	
 }
 
<%
/******************************************************************************
	Description : ��ȸ
	//�˻�����
    //������ -   ����, ȸ����, ��������
    //������ -   ����, ȸ����, ��������  
******************************************************************************/
%>
function ln_Query(){ 
 
  	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070024_s1"
								     + "?v_str1=1" 
								 	 + "&v_str2="+txt_vend_nm_0.value   
								 	 + "&v_str3="+txt_vend_cd_0.value     
									 + "&v_str4="+gcem_vend_id_0.text;       
									     
	 //prompt('', gcds_code01.DataID);				
	gcds_code01.Reset();
}


<%
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Excel(){

}


<%
/******************************************************************************
	Description : ���  
******************************************************************************/
%>
function ln_Print(){
	  
}


<%
/******************************************************************************
	Description : �ŷ�ó (��ȸ)
******************************************************************************/
%>
function ln_Popup_Vendcd(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]="";
	arrParam[1]=txt_vend_nm_0.value;
	
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		 arrParam = arrResult.split(";");
		 txt_vend_cd_0.value = arrParam[0];
		 txt_vend_nm_0.value = arrParam[1];
		 ln_usegb_format(arrParam[5],"0");
	} else {
		 txt_vend_cd_0.value = "";
		 txt_vend_nm_0.value = "";
    }
}

<%
/******************************************************************************
Description :
******************************************************************************/
%>
function ln_usegb_format(strVendid,strGB){

	intChk = strVendid.length;
	
	if(strGB=="0"){
		
		if(intChk==10){ //
			gcem_vend_id_0.Format= "000-00-00000";    //���� 
			gcra_usegb_0.codevalue="1";
		}else if(intChk==13){
			gcem_vend_id_0.Format= "000000-0000000";  //���� 
			gcra_usegb_0.codevalue="2";
		}
		
		gcem_vend_id_0.text = strVendid;
		
	}else{
		
		if(intChk==10){ //
			gcem_vend_id.Format= "000-00-00000";    //���� 
		}else if(intChk==13){
			gcem_vend_id.Format= "000000-0000000";  //���� 
		}
		
		gcem_vend_id.text = strVendid;
		
	}
}


<%
/******************************************************************************
	Description : �߰�  
******************************************************************************/
%>
function ln_Add(){
	
}

<%
/******************************************************************************
	Description : ��� DataSet head
******************************************************************************/
%>

function ln_SetDataHeader(){

}



<%
/******************************************************************************
	Description : üũ  
******************************************************************************/
%>
function ln_Chk(){

 
}

<%
/******************************************************************************
	Description : ���� 
******************************************************************************/
%>
function ln_Save(){
}


<%
/******************************************************************************
	Description : ��Ź, ������ üũ 
	���� : 2017.03.03 ä��(��)�з� - 1, 2 �� ��� ��Ź���� �Է°���  by ������
	
******************************************************************************/
%>
function ln_Chk_Credgb(){

}

<%
/******************************************************************************
	Description : ���� 
******************************************************************************/
%>
function ln_Delete(){


}





</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<!-- ���з���Ȳ ��ȸ  -->
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"    VALUE="false">
	<param name=SubSumExpr    value="1:VEND_CD">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
     ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
   	 document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
    var icnt=0;

   	if(gcds_code01.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}else {
	  	ft_cnt01.innerText = "��ȸ�Ǽ� : " + gcds_code01.RealCount(1,row) + " ��";
	}
 
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>
 

<!-----------------------------------------------------------------------------
    	G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";        //���� 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";  //���� 
	}
	
</script>

<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
		T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td width="860px" align="right" style="padding-top:4px;"> 
			<img src="../../Common/img/btn/com_b_query.gif"	   style="cursor:hand;position:relative;top:-2px"  onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">

	<tr> 
		<td width="100px;" class="tab25"  bgcolor="#eeeeee" align=center>�ŷ�ó��(ä����)</td> 
		<td class="tab24" >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_nm_0" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:180px;height:20px;" maxlength="36" >
			<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd();">
			<input id="txt_vend_cd_0" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
			</comment><script>__ws__(__NSID__);</script>
		</td>
		<td class="tab18" width="90px;" bgcolor="#eeeeee" align="center">��ȣ����</td>
		<td class="tab18" width="160px"  ><comment id="__NSID__">
			<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
				<param name=Cols	value="2">
				<param name=Format	value="1^����ڹ�ȣ,2^�ֹι�ȣ">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab18" width="60px;" bgcolor="#eeeeee" align="center">��ȣ</td>
		<td class="tab18" width="90px"  Style="height:20px;;"><nobr>&nbsp;<comment id="__NSID__">
			<object  id=gcem_vend_id_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:3px">		
				<param name=Text		   value="">
				<param name=Alignment      value=0>
				<param name=Border         value=true>
				<param name=Numeric        value=false>
				<param name=Format         value="000-00-00000">
				<param name=PromptChar     value="">
				<param name=BackColor      value="#CCCCCC">
				<param name=InheritColor   value=false>
				<param name=readOnly       value=false>
		   </object></comment><script>__ws__(__NSID__);</script>
		</td>
		
	</tr>
</table>

<table id="div_disp1"  width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			  style="position:relative;left:0px;top:2px;width:858px; height:430px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		  value='0'>
					<param name="BorderStyle"     value="0">
					<param name="Fillarea"		  value="true">
					<param name="Sortview"		  value="false">
					<param name="ColSizing"	      value="true">
					<param name="Editable"		  value="true"> 
					<param name=TitleHeight       value="30">
					<param name="Format"		  value=" 			
					<C> Name='�ŷ�ó'	              ID=VEND_CD	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50	    align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}  show =false</C>
					<C> Name='�ŷ�ó��(ä����)'      ID=VEND_NM		  HeadAlign=Center HeadBgColor=#B9D4DC Width=150    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='����ڹ�ȣ'		      ID=VEND_ID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} MASK='XXX-XX-XXXXX'</C>
					<C> Name='ä���� '			  ID=CREDITOR	  HeadAlign=Center HeadBgColor=#B9D4DC Width=130    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} Value={Decode(curlevel,1,'��  ��',CREDITOR)}</C>
					<C> Name='û���ݾ�'             ID=DEMAMT       HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=right	  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='��������'             ID=RECDAT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} MASK='XXXX/XX/XX' </C>
					<C> Name='��Ź����'             ID=DEPDAT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} MASK='XXXX/XX/XX'  </C>
					<C> Name='ä�Ǳ���'	          ID=CREDGB   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=125    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} EditStyle=Combo  Data='1:ä�ǰ��з�,2:ä�Ǿз� �� �߽ɸ��,3:��Ź,4:����'</C>
					<C> Name='���'	        	  ID=REMARK   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=110    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>




<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 