<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �渮ȸ�� - ��ǥ����	
+ ���α׷� ID	:  A020001.html
+ �� �� �� ��	:  ��ǥ�� �Է�/��ȸ �ϴ� ȭ���̴�
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��  :	 �������� ����   
+ ��   ��  ��  :  �̹���
+ �� �� �� ��  :  2006.11.1
-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�������������</title>
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

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var gs_InsGubun=""; //��ȸ�� ��� ����
var gs_dept2="";    //�渮���úμ�

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
 
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_dept.Reset();
	
	//gclx_fsstat.bindcolval="A";
	gcem_fsdat_fr.text=gs_date.substring(0,4)+"0101";
	gcem_fsdat_to.text=gs_date;
	
	//alert("gs_deptcd::::"+gs_deptcd);
	//�渮���úμ��� �������.
	//if(gf_Dept_Enable(gs_deptcd,gcds_dept2)){
	//    gclx_fdcode.bindcolval=gs_fdcode;
	//		gs_dept2="true";
	//	}else{
	//alert("gs_fdcode"+gs_fdcode);
	//	  gclx_fdcode.bindcolval=gs_fdcode;
	//		gclx_fdcode.Enable=false;
	//		gs_dept2="false";
	//}
}

/******************************************************************************
	Description : ��ȸ
	parameter   :��õ������ ����
  ����        : 
******************************************************************************/
function ln_Query(){
		var vcode = "";
		var vdate = "";
		vcode= gclx_fdcode.bindcolval;
		vdate1 = gcem_fsdat_fr.text;
		vdate2 = gcem_fsdat_to.text;

	//	vdate1 = "20060100"; //test
	//	vdate2 = "20060630"; //test

		ln_edit_init();
		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160002_s1?v_str1="+vcode
																		+"&v_str2="+vdate1+"&v_str3="+vdate2;
	//	prompt("",gcds_data01.DataID );																							
		gcds_data01.Reset();

		gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160002_s2?v_str1="+vcode
																		+"&v_str2="+vdate1+"&v_str3="+vdate2;
		gcds_data02.Reset();
	
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160002_s01?v_str1="+vcode+"&v_str2="+vdate1+"&v_str3="+vdate2;
		gcds_data1.Reset();
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160002_s02?v_str1="+vcode+"&v_str2="+vdate1+"&v_str3="+vdate2;
		gcds_data2.Reset();	
		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160002_s03?v_str1="+vcode+"&v_str2="+vdate1+"&v_str3="+vdate2;
		gcds_data3.Reset();	
		gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160002_s04?v_str1="+vcode+"&v_str2="+vdate1+"&v_str3="+vdate2;
		gcds_data4.Reset();	
		gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160002_s05?v_str1="+vcode+"&v_str2="+vdate1+"&v_str3="+vdate2;
		gcds_data5.Reset();	
		gcds_data6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160002_s06?v_str1="+vcode+"&v_str2="+vdate1+"&v_str3="+vdate2;
		gcds_data6.Reset();



}

function ln_edit_init(){
		gcem_amt1.text = 0;
		gcem_amt2.text = 0;
		gcem_amt3.text = 0;
		gcem_amt4.text = 0;
		gcem_amt5.text = 0;
		gcem_amt6.text = 0;
		gcem_amt7.text = 0;
		gcem_amt8.text = 0;
		gcem_amt9.text = 0;
		gcem_amt10.text =0;
		gcem_amt11.text =0;
		gcem_amt12.text =0;
		gcem_amt13.text =0;
		gcem_amt14.text =0;
		gcem_amt15.text =0;
		gcem_amt16.text =0;
		gcem_amt17.text =0;
		gcem_amt18.text =0;

}

function ln_Amtsum(){
  gcem_amt9.text = gcem_amt7
}

/******************************************************************************
	Description : ����
	parameter   : 
******************************************************************************/
function ln_Excel(){
	
//	gcgd_disp01.RunExcel("�������������");
gcgd_disp01.GridToExcel("�������������","",2);
}
/***********************************************************************************************
	Description : [�Ϻ�] - ��ǥ ã��
	parameter   : fcod - �����ڵ�, fsdt - ��ǥ����, fnbr - ��ǥ��ȣ
**********************************************************************************************/
function ln_Popup2(fcod,fsdt,fnbr){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;
	arrParam[1] = fsdt;
	arrParam[2] = fnbr;

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:610px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Master -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SubSumExpr          value="total , 1:ATCODE">
	<param name=SortExpr   value="+ATCODE+FSDAT">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";


</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row)">

	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (gcds_data01.countrow <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>


<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
	document.all.LowerFrame.style.visibility="hidden";

	if(row > 0){
		
		gcem_amt1.text = gcds_data02.namevalue(1,"DEAMT_B");
		gcem_amt2.text = gcds_data02.namevalue(1,"DEAMT_A");
		gcem_amt3.text = gcds_data02.namevalue(1,"DEAMT_A")+ gcds_data02.namevalue(1,"DEAMT_B");

		gcem_amt4.text = gcds_data02.namevalue(1,"DEAMT_B");
		gcem_amt5.text = gcds_data02.namevalue(1,"DEAMT_A");
		gcem_amt6.text = gcds_data02.namevalue(1,"DEAMT_A")+ gcds_data02.namevalue(1,"DEAMT_B");
/*
		gcem_amt7.text = gcds_data02.namevalue(2,"DEAMT_A");
		gcem_amt8.text = gcds_data02.namevalue(2,"DEAMT_A");
		gcem_amt9.text = gcds_data02.namevalue(2,"DEAMT_A")+ gcds_data02.namevalue(2,"DEAMT_B");

		gcem_amt10.text = gcds_data02.namevalue(3,"DEAMT_A");
		gcem_amt11.text = gcds_data02.namevalue(3,"DEAMT_A");
		gcem_amt12.text = gcds_data02.namevalue(3,"DEAMT_A")+ gcds_data02.namevalue(3,"DEAMT_B");

		gcem_amt13.text = 0;
		gcem_amt14.text = 0;
		gcem_amt15.text = 0;

		//gcem_amt16.text = gcds_data02.Sum(1,0,0);
		//gcem_amt17.text = gcds_data02.Sum(2,0,0);
		//gcem_amt18.text = gcds_data02.Sum(1,0,0)+gcds_data02.Sum(2,0,0);
		gcem_amt16.text = Number(gcem_amt7.text) + Number(gcem_amt13.text);
		gcem_amt17.text = Number(gcem_amt8.text) + Number(gcem_amt14.text);
		gcem_amt18.text = Number(gcem_amt9.text) + Number(gcem_amt15.text);
*/
	}else{

	}
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row)">
	gcem_amt7.text = gcds_data1.namevalue(1,"FSAMT1");
  gcem_amt9.text = eval(gcem_amt9.text) + eval(gcem_amt7.text);
  gcem_amt16.text = eval(gcem_amt16.text) + eval(gcem_amt7.text);
  gcem_amt18.text = eval(gcem_amt18.text) + eval(gcem_amt7.text);
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row)">
	gcem_amt10.text = gcds_data2.namevalue(1,"FSAMT2");
  gcem_amt12.text = eval(gcem_amt12.text) + eval(gcem_amt10.text);
  gcem_amt16.text = eval(gcem_amt16.text) + eval(gcem_amt10.text);
  gcem_amt18.text = eval(gcem_amt18.text) + eval(gcem_amt10.text);
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row)">
	gcem_amt13.text = gcds_data3.namevalue(1,"FSAMT3");
  gcem_amt15.text = eval(gcem_amt15.text) + eval(gcem_amt13.text);
  gcem_amt16.text = eval(gcem_amt16.text) + eval(gcem_amt13.text);
  gcem_amt18.text = eval(gcem_amt18.text) + eval(gcem_amt13.text);
</script>

<script language="javascript" for="gcds_data4" event="onloadCompleted(row)">
	gcem_amt8.text = gcds_data4.namevalue(1,"FSAMT4");
  gcem_amt9.text = eval(gcem_amt9.text) + eval(gcem_amt8.text);
  gcem_amt17.text = eval(gcem_amt17.text) + eval(gcem_amt8.text);
  gcem_amt18.text = eval(gcem_amt18.text) + eval(gcem_amt8.text);
</script>

<script language="javascript" for="gcds_data5" event="onloadCompleted(row)">
	gcem_amt11.text = gcds_data5.namevalue(1,"FSAMT5");
  gcem_amt12.text = eval(gcem_amt12.text) + eval(gcem_amt11.text);
  gcem_amt17.text = eval(gcem_amt17.text) + eval(gcem_amt11.text);
  gcem_amt18.text = eval(gcem_amt18.text) + eval(gcem_amt11.text);
</script>

<script language="javascript" for="gcds_data6" event="onloadCompleted(row)">
	gcem_amt14.text = gcds_data6.namevalue(1,"FSAMT6");
  gcem_amt15.text = eval(gcem_amt15.text) + eval(gcem_amt14.text);
  gcem_amt17.text = eval(gcem_amt17.text) + eval(gcem_amt14.text);
  gcem_amt18.text = eval(gcem_amt18.text) + eval(gcem_amt14.text);
</script>


<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"FDCODE")="";
	gcds_dept.NameValue(1,"FDNAME")="��ü";
	if(gs_userid=="ACCOUNT"){
		gcds_dept.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
	}
</script>
<script language="javascript" for="gcgd_disp01" event="OnDblClick()">
	var row = gcds_data01.rowposition;
	var p_fcod = gcds_data01.namevalue(row,"FDCODE");

	
	var p_fsdt = gcds_data01.namevalue(row,"FSDAT");
	var p_fnbr = gcds_data01.namevalue(row,"FSNBR");


	ln_Popup2(p_fcod,p_fsdt,p_fnbr);	//��ǥ Popup
</script>
</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
		<td>
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td><img src="../img/a160002_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
					  <!-- <img src="../../common/img/btn/com_b_trans.gif"   style="cursor:hand" onclick="ln_Popup('00')"> -->
					  <!--   <img src="../../common/img/btn/com_b_trans.gif"   style="cursor:hand" onclick="ln_Popup('01')">
					  <!-- 	<img src="../../common/img/btn/com_b_slipsts.gif"   style="cursor:hand" onclick="ln_Popup('09')">	
					  <!-- 	<img src="../../common/img/btn/com_b_sanctionreq.gif"	style="cursor:hand" onClick="ln_Multi_Confirm()" --> 
					  <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
					  <img src="../../Common/img/btn/com_b_excel.gif"	style="cursor:hand" onClick="ln_Excel()" >
						<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr> 
								<td width="80px" bgcolor="#eeeeee" class="tab15" align=center >
									<nobr>&nbsp;&nbsp;��������&nbsp;</nobr></td>
								<td class="tab18" style="width:90px;" align=center><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
											<param name=ComboDataID    value="gcds_dept">
											<param name=CBDataColumns		value="FDCODE, FDNAME">
											<param name=SearchColumn		value=FDNAME>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="FDNAME^0^140">
											<param name=BindColumn			value=FDCODE>
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
								<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;ȸ��⵵</nobr></td>
								<td class="tab18" style="width:180px;"><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gcem_fsdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;~&nbsp; 
									<comment id="__NSID__"><object  id=gcem_fsdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> 						
									</nobr>
								</td>
								<td width="600" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;</nobr></td>
							</tr>
					 </table>
					</td>
				</tr>  	
			</table>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
				<tr> 			
					<td style="width:280" ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
							style="position:relative;left:3px;width:875px; height:200px; border:1 solid #708090;display:block;" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data01">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<param name="ViewSummary"	value=1>
								<param name="ColSizing"   value="true">
								<param name="Editable"    value="false">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='�����ڵ�'	ID=ATCODE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center  sort=false SumBgColor=#C3D0DB SumText='��   ��' show=false</C> 
								<C> Name='�����ڵ�'	ID=ATKORNAM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=160	  align=left  sort=false SumBgColor=#C3D0DB SumText='��   ��' Suppress =1</C> 
								<C> Name='����'		ID=CDNAM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left	 edit=none sort=true SumBgColor=#C3D0DB </C> 
								<C> Name='�ŷ�ó�ڵ�'		ID=FSREFVAL 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center	 edit=none sort=true SumBgColor=#C3D0DB show=false</C> 
								<C> Name='�ŷ�ó'		ID=VEND_NM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	  align=left	 edit=none sort=true SumBgColor=#C3D0DB </C> 
								<C> Name='�ݾ�'		  ID=DEAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=rigth	 edit=none sort=true SumBgColor=#C3D0DB </C> 
								<C> Name='����'		  ID=REMARK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=195	  align=left	 edit=none sort=true SumBgColor=#C3D0DB </C>
								<G> name='��ǥ��ȣ' , HeadbgColor=#B9D4DC  ,align=CENTER
								<C> Name='ȸ������'	 ID=ACTDAT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center edit=none sort=true SumBgColor=#C3D0DB mask='XXXX/XX/XX' Suppress =2</C> 
								<C> Name='������ȣ'	 ID=SSNBR 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center edit=none sort=true SumBgColor=#C3D0DB </C> 
								<C> Name='���ȣ'			 ID=FSSEQ  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right	 edit=none sort=true SumBgColor=#C3D0DB show=false</C> 
								</G>
								">
						</object></comment><script>__ws__(__NSID__);</script>   
						<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>

<!---- ����� �ش�ݾ�---->
			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" border="0"  style="width:876px;height:30px;border:1 solid #708090;">
								<tr width="876px"> 								
									<td width="876px" colspan=5 bgcolor="#eeeeee" class="tab13">
										<nobr>����� �ش�ݾ�</nobr></td>
								</tr>
								<tr> 
									<td width="336px" colspan=2 bgcolor="#eeeeee" class="tab11">
										<nobr>��������</nobr></td>
									<td width="180px" bgcolor="#eeeeee" class="tab11">
										<nobr>�����(�ǰ���)</nobr></td>
									<td width="180px" bgcolor="#eeeeee" class="tab11">
										<nobr>�����(�������)</nobr></td>
									<td width="180px" bgcolor="#eeeeee" class="tab13">
										<nobr>�հ�</nobr></td>
								</tr>
								<tr> 
									<td colspan=2 bgcolor="#eeeeee" class="tab11">
										<nobr>�����ݾ�</nobr></td>
									<td class="tab11"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=Numeric value="true">
														<!-- <param name=Enable				value=false> -->
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
								<td class="tab11"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=Numeric value="true">
														<param name=BackColor     value="#CCCCCC">
														<param name=Enable				value=false>
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
								<td class="tab13"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Numeric value="true">
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=Enable				value=false>
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
							</tr>
							<tr> 	
								<td colspan=2 bgcolor="#eeeeee" class="tab11">
									<nobr>&nbsp;&nbsp;������ش�ݾ� &nbsp;</nobr></td>
								<td class="tab11">
									<nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=Numeric value="true">
														<param name=Enable				value=false>
													<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
								<td class="tab11"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=Numeric value="true">
														<param name=BackColor     value="#CCCCCC">
														<param name=Enable				value=false>
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
								<td class="tab13"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Numeric value="true">
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=Enable				value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
							</tr>
							<tr> 
								<td width="168px" rowspan=4 bgcolor="#eeeeee" class="tab12">
									<nobr>�ſ�ī��� ���ݾ�</nobr></td>
								<td width="168px" rowspan=2 bgcolor="#eeeeee" class="tab11">
									<nobr>5�����ʰ�������</nobr></td>
								<td class="tab11" >
									<nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt7 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=Numeric value="true">
														<param name=InheritColor  value=false>
														<param name=Enable				value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									</nobr>
								</td>
								<td class="tab11"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt8 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=Numeric value="true">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=Enable				value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
								<td class="tab13"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt9 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Numeric value="true">
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=Enable				value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
							</tr>
							<tr> 
								<td class="tab11"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt10 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=Numeric value="true">
														<param name=Enable				value=false>
													<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
								<td class="tab11"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=Numeric value="true">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=Enable				value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
								<td class="tab13"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt12 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Numeric value="true">
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=Enable				value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
							</tr>
							<tr> 	
								<td bgcolor="#eeeeee" class="tab11" align=center>
									<nobr>��Ÿ</nobr></td>
								<td class="tab11">
									<nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt13 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=Numeric value="true">
													<param name=InheritColor  value=false>
														<param name=Enable				value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
								<td class="tab11"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt14 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=Numeric value="true">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
								<td class="tab13"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt15 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Numeric value="true">
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
							</tr>
							<tr>
								<td bgcolor="#eeeeee" class="tab12" align=center >
									<nobr>�հ�</nobr></td>
								<td class="tab12"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt16 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=Numeric value="true">
													<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									</nobr>
								</td>
								<td class="tab12"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt17 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=Numeric value="true">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
								<td class="tab13" style="border:0 solid #708090;border-bottom-width:0px;"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_amt18 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:120px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=2>
														<param name=Border        value=false>
														<param name=Numeric value="true">
														<param name=Format        value="YYYY">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										</nobr>
								</td>
						</tr>
					 </table>
					</td>
				</tr>  	
			</table>
		</td>
	</tr>
</table>	

<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 