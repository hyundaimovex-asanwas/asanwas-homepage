<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ������� - �Ϲݰ������
+ ���α׷� ID	:  A080008.jsp
+ �� �� �� ��	:  
+ ��   ��  �� :  YS.JEONG
+ �� �� �� �� :  2012.01.17
-----------------------------------------------------------------------------
+ �� �� �� �� :	    
+ ��   ��  �� :  
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>


<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�Ϲݰ������</title>

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

var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7); //���
var gs_date3 = gcurdate.substring(0,4); //��
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	ln_Before();
	gclx_fdcode.bindcolval = gs_fdcode;

}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(){

   if(fn_trim(gcem_frdt.text)==""){
		alert("��ȸ���ڸ� �Է��Ͻʽÿ�1.");
		return false;
	}

   if(gcem_todt.text==""){
		alert("��ȸ���ڸ� �Է��Ͻʽÿ�2..");
		return false;
	}

	
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080008_s1?v_str1="+gclx_fdcode.bindcolval
																									 +"&v_str2="+gcem_frdt.text
																									 +"&v_str3="+gcem_todt.text
																									 +"&v_str4="+gcem_bgtdpt.text
																									 +"&v_str5="+gcem_bgtdptnm.text;
																									

	//prompt("",gcds_data01.DataID );																							
	gcds_data01.Reset();									

}

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : ����
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : ����
*****************************************************************************************/
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
	Description : Dataset Head ���� 
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(p){

}

/******************************************************************************
	Description : ��� - Header Set
******************************************************************************/
function ln_PrintHeader() {

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

	//gcgd_disp01.ExportFile('���м��Ͱ�꼭',true)
	gcgd_disp01.GridToExcel("�Ϲݰ������","",2);
	//gcgd_disp01.RunExcel("�Ϲݰ�������Ȳ")
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
  
	//���� 
	gcem_frdt.text = gs_date2+"01"; 
	gcem_todt.text = gs_date;
	
	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();


}

/******************************************************************************
	Description : ��ȸ�� ����Ÿ�� ������ �ٽ� ������.
	parameter   : gcds_disp01 -> gcds_temp01
******************************************************************************/
function ln_Data_Reset(p){

}

/******************************************************************************
  Description : ����μ��˾�
  parameter   : 
******************************************************************************/
function ln_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	
	arrParam[0]=gcem_bgtdptnm.text;
	arrParam[1]=gcem_bgtdpt.text;
	
	strURL = "./bgtdpt_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtdptnm.text = arrParam[1];
		gcem_bgtdpt.text = arrParam[0];
	} else {
		gcem_bgtdptnm.text = "";
		gcem_bgtdpt.text = "";
	}
	
	

    /**
    arrParam[0]='ATUSEYN';
	strURL = "./actcode_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_atcode.text = arrResult[0];
		gcem_atkornam.text = arrResult[1];
	}else{
       gcem_atcode.value="";
		gcem_atkornam.value="";
	}
	**/
}

/******************************************************************************
	Description : �����ʱ�ȭ
  parameter   : 
******************************************************************************/
function ln_Clear(){
	gcem_bgtdptnm.text="";
    gcem_bgtdpt.text="";
}



/***********************************************************************************************
	Description : �Ϲݰ�������Ȳ �˾�
	parameter   : sfdcode-�����ڵ�, sfdcodenm-�����ڵ�� 
	              sfrymd -fromȸ������, stoymd - toȸ������
								satcode-�����ڵ�, satcodenm-�����ڵ�� 
**********************************************************************************************/
function ln_Popup2(sfdcode,sfdcodenm,sfrymd,stoymd,satcode,satcodenm){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0] = sfdcode;			
	arrParam[1] = sfdcodenm;
	arrParam[2] = sfrymd;
	arrParam[3] = stoymd;
	arrParam[4] = satcode;	
	arrParam[5] = satcodenm;	
	arrParam[6] = gcem_bgtdpt.text;	
	arrParam[7] = gcem_bgtdptnm.text;	

	strURL = "./a080008_popup.jsp";
	strPos = "dialogWidth:810px;dialogHeight:450px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!--(��)������������ ��ȸ  -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--����  -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
  
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
  
  if(colid=="ATCODE"||colid=="PRTNAM"||colid=="SUM") return;

	//�������� 
	/**
	var endday ="";
	var intyyyy=0;
	var intchk=0;
 	if (gclx_tomonth.bindcolval=="01"||gclx_tomonth.bindcolval=="03"||gclx_tomonth.bindcolval=="05"||gclx_tomonth.bindcolval=="07"
	  ||gclx_tomonth.bindcolval=="08"||gclx_tomonth.bindcolval=="10"||gclx_tomonth.bindcolval=="12"){
		endday ="31";
	}else if(gclx_tomonth.bindcolval=="02") {
    endday ="28";
		intyyyy = gcem_yyyy.text;
    intchk=intyyyy%4;
		if(intchk==0) endday ="29";
  }else{
    endday ="30";
	}
	**/
	
	var sfdcode		 = gclx_fdcode.bindcolval;								  //�����ڵ�
    var sfdcodenm	= gclx_fdcode.text;                       //������
	//var sfrymd	  = gcem_yyyy.text+gclx_frmonth.text+"01";	//�˻����� fr
	//var stoymd	  = gcem_yyyy.text+gclx_tomonth.text+endday;  //�˻����� to
	
	var sfrymd	    = gcem_frdt.text;	//�˻����� fr
	var stoymd	    = gcem_todt.text;    //�˻����� to
	var satcode		= gcds_data01.namevalue(row,"ATCODE");	//�����ڵ�
	var satcodenm = gcds_data01.namevalue(row,"ATKORNAM");	//�����ڵ��
	
	ln_Popup2(sfdcode,sfdcodenm,sfrymd,stoymd,satcode,satcodenm);	
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a080008_1_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" width="685" align="right">&nbsp;
			<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------------------ ----------------------->
<table cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:3px;width:877px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>�����ڵ�</td>
				<td class="tab18" style="width:120px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				        value=false>
						<param name=ListExprFormat	    value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
						<param name=enable			        value="false">

					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>����</td>
				<td class="tab18" style="height:30px;width:400px;" >&nbsp;<nobr>
					<comment id="__NSID__">
						<object  id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:60px; height:20px;" class="txtbox">
							<param name=Alignment	     value=0>
							<param name=Border	         value=true>
							<param name=Format	         value="YYYYMMDD">
							<param name=PromptChar	  value="_">
							<param name=Enable		      value="true">
						</object>~
						
						<object  id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:60px; height:20px;" class="txtbox">
							<param name=Alignment	     value=0>
							<param name=Border	         value=true>
							<param name=Format	         value="YYYYMMDD">
							<param name=PromptChar	  value="_">
							<param name=Enable		      value="true">
						</object>
					</comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			
			<tr>
				<td class="tab17" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>����μ�</td>
				<td class="tab19" style="width:120px" colspan=3><nobr>				
					<comment id="__NSID__">
					<object  id=gcem_bgtdptnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:5px;" onkeydown="ln_Onblur('02','fr','gcem_atkornam')";">
			      		<param name=Text				value="">
						<param name=Alignment      value=0>
						<param name=Border          value=true>
						<param name=Numeric        value=false>
						<param name=PromptChar   value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=false>
						<param name=GeneralEdit   value="true">
					</object>
				    </comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="����μ��ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:0px" align=center onclick="ln_Popup();">
					<comment id="__NSID__">
					<object  id=gcem_bgtdpt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:5px;">
			      		<param name=Text			   value="">
						<param name=Alignment     value=0>
						<param name=Border         value=true>
						<param name=Numeric       value=false>
						<param name=Format          value="#######">
						<param name=PromptChar  value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=false>
					</object>
					</comment><script>__ws__(__NSID__);</script> 
					&nbsp;
					<img SRC="../../Common/img/btn/com_b_clear.gif" BORDER="0" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Clear();">
					</nobr>
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>  
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:877px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data01">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle"   VALUE="0">
							<PARAM NAME="Fillarea"		    VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
             				 <param name="Editable"          value="false">
							<param name=ColSizing           value="true">
							<param name=ViewSummary   value="1">
							<PARAM NAME="Format"			VALUE="  
								<C> ID=ATCODE         name='�����ڵ�'   HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=center SumBgColor=#C3D0DB  sort=true </C> 
								<C> ID=ATKORNAM    name='��������'   HeadAlign=Center HeadBgColor=#B9D4DC Width=400   align=left       SumBgColor=#C3D0DB  sort=true   sumtext='�հ�'</C> 
								<C> ID=AMT	             name='�ݾ�'	      HeadAlign=Center HeadBgColor=#B9D4DC width=300   align=right    	SumBgColor=#C3D0DB  sumtext='@sum' </C>
								">
					</object></comment><script>__ws__(__NSID__);</script> 
					
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
					</fieldset>
			</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_temp01">
	<param name="DetailDataID"			value="gcds_temp01">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"					value="false">
  <param name="PrintSetupDlgFlag" value="true">
	<param name="Format"						value="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=558 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=71 ,top=402 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=74 ,top=556 ,right=1942 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��������' ,left=82 ,top=415 ,right=553 ,bottom=550 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=71 ,top=402 ,right=71 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=402 ,right=564 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=402 ,right=1249 ,bottom=558 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=402 ,right=1942 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURKISU', left=640, top=407, right=1201, bottom=474 ,mask='�� XX(��)��', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PREKISU', left=1323, top=407, right=1881, bottom=474 ,mask='�� XX(��)��', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=564 ,top=479 ,right=1942 ,bottom=479 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�� ��' ,left=640 ,top=492 ,right=1201 ,bottom=540 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=1328 ,top=492 ,right=1879 ,bottom=540 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='KISU1', left=503, top=191, right=1564, bottom=233, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='KISU2', left=503, top=238, right=1564, bottom=280, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='(���� : ��)' ,left=1722 ,top=349 ,right=1934 ,bottom=394 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=71, top=347, right=566, bottom=392, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='XRTTOT', left=918, top=0, right=1244, bottom=48, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='XLTTOT', left=572, top=0, right=902, bottom=48, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='YLTTOT', left=1259, top=3, right=1588, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRTNAM', left=85, top=5, right=553, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=0 ,right=71 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=0 ,right=564 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=910 ,top=0 ,right=910 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=0 ,right=1249 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='YRTTOT', left=1606, top=0, right=1931, bottom=48, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='PRTTIME', left=71, top=11, right=849, bottom=56, align='left' ,mask='������� : XXXX/XX/XX   ��½ð� : XX:XX XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='#p / #t' ,left=873 ,top=53 ,right=1140 ,bottom=101 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 