<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �ΰ������� - �����ڻ���Ժ�
+ ���α׷� ID	:  A050006.html
+ �� �� �� ��	:  
+ ��   ��  �� :  �̹���
+ �� �� �� �� :  2006.09.19
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
<title></title>
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
var g_date, g_time;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    ln_Before();
  
	var date = new Date();
	g_date = "������� : " + date.getFullYear() + "/" + date.getMonth() + "/"
											+ date.getDate();
	g_time = "��½ð� : " + date.getHours() + ":" + date.getMinutes();
	gclx_fdcode.bindcolval = gs_fdcode;
	
}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(){

  //gcds_data01.clearall();
	//gcds_temp01.clearall();
	gcgd_disp01.DataID="";
  
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050006_s1?v_str1="+gclx_fdcode.bindcolval
																									 +"&v_str2="+gcem_datefr.text
																									 +"&v_str3="+gcem_dateto.text
																									 +"&v_str4="+gclx_atcode_fr.bindcolval
																									 +"&v_str5="+gclx_atcode_to.bindcolval;
																									// +"&v_str6="+txt_costcd_fr.value
																									 //+"&v_str7="+txt_costcd_to.value;																											
	//prompt("",gcds_data01.DataID );								
	
//	alert(gclx_atcode_fr.bindcolval);
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

	var time = new Date();

	gcds_temp01.clearall();
	ln_PrintHeader();
	gcds_temp01.addrow();
	
	if(time.getMonth()+1<10)
		g_date = time.getFullYear()+"/0"+(time.getMonth()+1)+"/"+time.getDate();
	else
		g_date = time.getFullYear()+"/"+(time.getMonth()+1)+"/"+time.getDate();
	if(time.getHours()<10) {
		if(time.getMinutes()<10)
			g_time = "0"+time.getHours()+":0"+time.getMinutes()+" AM";
		else
			g_time = "0"+time.getHours()+":"+time.getMinutes()+" AM";
	} else if(time.getHours()>=10&&time.getHours()<12) {
		if(time.getMinutes()<10)
			g_time = ""+time.getHours()+":0"+time.getMinutes()+" AM";
		else
			g_time = ""+time.getHours()+":"+time.getMinutes()+" AM";
	} else if(time.getHours()==12) {
		if(time.getMinutes()<10)
			g_time = "12:0"+time.getMinutes()+" PM";
		else
			g_time = "12:"+time.getMinutes()+" PM";
	} else if(time.getHours()>12&&time.getHours()<22) {
		if(time.getMinutes()<10)
			g_time = "0"+(time.getHours()-12)+":0"+time.getMinutes()+" PM";
		else
			g_time = "0"+(time.getHours()-12)+":"+time.getMinutes()+" PM";
	} else {
		if(time.getMinutes()<10)
			g_time = ""+(time.getHours()-12)+":0"+time.getMinutes()+" PM";
		else
			g_time = ""+(time.getHours()-12)+":"+time.getMinutes()+" PM";
	}
	if(gcds_data01.countrow<1)
			alert("����� ������ �����ϴ�.");
	else {
		gcds_temp01.namevalue(1,"KISU1") =
				"( ȸ������ : "+gcem_datefr.text.substring(0,4)+"/"
				+gcem_datefr.text.substring(4,6)+"/"
				+gcem_datefr.text.substring(6,8)+" ~ "
				+gcem_dateto.text.substring(0,4)+"/"
				+gcem_dateto.text.substring(4,6)+"/"
				+gcem_dateto.text.substring(6,8)+" )";
		if(fn_trim(txt_costnm_fr.value)=="") {
			//gcds_temp01.namevalue(1,"COSTNM") = "����� : " + gclx_place.text;
		} else {
			//gcds_temp01.namevalue(1,"COSTNM") = "����� : " + txt_costnm_fr.value;
		}
		gcds_temp01.namevalue(1,"CURDT") = "������� : " + g_date;
		gcds_temp01.namevalue(1,"CURTM") = "��½ð� : " + g_time;
		gcrp_print1.preview();
	}
	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

//	gcgd_disp01.runexcel("������ ����������");
 gcgd_disp01.GridToExcel("������ ����������","",2);

//	if (eval("gcds_data"+e).countrow<1) alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
//	else eval("gcgd_disp"+e).runexcel("�λ���Ȳ");



}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
  
	//����
	gcem_datefr.text = gs_date2+"01"; //���
	gcem_dateto.text = gs_date;
	
	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();


	//����[�˻�]
	gcds_atcode_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2160";  
	gcds_atcode_fr.Reset();

	//����[�˻�]
	gcds_atcode_to.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2160";  
	gcds_atcode_to.Reset();

	//gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";  

}


/******************************************************************************
	Description : ��ȸ�� ����Ÿ�� ������ �ٽ� ������.
	parameter   :  
******************************************************************************/
function ln_Data_Reset(p){

	//�׸��忡 ���
  var strno="";
  var dblDEMMSum=0;//��������
	var dblCRMMSum=0;//�뺯����
	var dblDEATSum=0; //���������� ����
	var dblCRATSum=0; //�뺯������ ����
	var dblDECTSum=0; //���������ڵ庰 ��
	var dblCRCTSum=0; //�뺯�����ڵ庰 ��
	var dblJanSum=0; //�뺯�����ڵ庰 ��

	
	//����Ÿ�� ����
	//ln_SetDataHeader("01");
	
	//���� ����
  for(i=1;i<=gcds_data01.countrow;i++){
		dblDEMMSum = dblDEMMSum + gcds_data01.namevalue(i,"DETOT");
		dblCRMMSum = dblCRMMSum + gcds_data01.namevalue(i,"CRTOT");
		if(gcds_data01.namevalue(i,"GUBUN")=="M"){       //����
		   gcds_data01.namevalue(i,"SSDAT") = "�� ��"
       gcds_data01.namevalue(i,"DETOT") = dblDEMMSum;
			 gcds_data01.namevalue(i,"CRTOT") = dblCRMMSum;
			 gcds_data01.namevalue(i,"JANAMT") = dblJanSum;
       dblDEATSum = dblDEATSum +dblDEMMSum;
       dblCRATSum = dblCRATSum +dblCRMMSum;
       dblDEMMSum=0;
       dblCRMMSum=0;
		}else if(gcds_data01.namevalue(i,"GUBUN")=="T"){ //����
		   gcds_data01.namevalue(i,"SSDAT") = "�� ��"
		   gcds_data01.namevalue(i,"DETOT") = dblDEATSum;
			 gcds_data01.namevalue(i,"CRTOT") = dblCRATSum;
			 gcds_data01.namevalue(i,"JANAMT") = dblJanSum;
		   dblDECTSum=dblDECTSum + dblDEATSum; //���������ڵ庰 ��
	     dblCRCTSum=dblCRCTSum + dblCRATSum; //�뺯�����ڵ庰 ��
       dblDEATSum =0;
       dblCRATSum =0 ;
		}else if(gcds_data01.namevalue(i,"GUBUN")=="C"){  //������
		   gcds_data01.namevalue(i,"SSDAT") = "������"
       gcds_data01.namevalue(i,"DETOT") = dblDECTSum;
			 gcds_data01.namevalue(i,"CRTOT") = dblCRCTSum;
			 gcds_data01.namevalue(i,"JANAMT") = dblJanSum;
			 dblDECTSum=0;
			 dblCRCTSum=0;
			 dblJanSum =0;
		}else{ 
			 dblJanSum = dblJanSum + gcds_data01.namevalue(i,"DETOT") ;
			 gcds_data01.namevalue(i,"JANAMT") = dblJanSum;
		}
	
	}
   gcgd_disp01.DataID = "gcds_data01";
	
}

/******************************************************************************
	Description : ��� - Header Set
******************************************************************************/
function ln_PrintHeader() {
		if(gcds_temp01.countrow<1){
	   var s_temp = "KISU1:STRING,COSTNM:STRING,CURDT:STRING,CURTM:STRING";
		 gcds_temp01.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : Dataset Head ���� 
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(p){
	//if(p=='01'){
	//	if(gcds_temp01.countrow<1){
	//	   var s_temp = "GUBUN:STRING,FSREFVAL:STRING,COSTNM:STRING,ATCODE:STRING,ATKORNAM:STRING,"
	//		            + "PRTSEQ:STRING,SSDAT:STRING,SSNBR:STRING,FSSEQ:STRING,"
	//		            + "DETOT:DECIMAL,CRTOT:DECIMAL,JANAMT:DECIMAL,REMARK:STRING";
	//		 gcds_temp01.SetDataHeader(s_temp);
	//	}
  //}
}


/******************************************************************************
	Description : �����˾�
  parameter   : 
******************************************************************************/
function ln_Popup(p){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  arrParam[0]="0030";//�����ڵ�
	arrParam[1]="";

  if(p=="fr"){
		if(txt_costnm_fr.value==""){
			 arrParam[2]="";
		}else{
			 arrParam[2]=txt_costnm_fr.value;
		}

		if(txt_costcd_fr.value==""){
			 arrParam[3]="";
		}else{
			 arrParam[3]=txt_costcd_fr.value;
		}
	}else if(p=="to"){
		if(txt_costnm_to.value==""){
			 arrParam[2]="";
		}else{
			 arrParam[2]=txt_costnm_to.value;
		}
		if(txt_costcd_to.value==""){
			 arrParam[3]="";
		}else{
			 arrParam[3]=txt_costcd_to.value;
		}
	}

	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		if(p=="fr"){
			txt_costcd_fr.value =arrResult[0];
			txt_costnm_fr.value = arrResult[1];
		}else if(p=="to"){
			txt_costcd_to.value =arrResult[0];
			txt_costnm_to.value = arrResult[1];
		}
	}else{
    if(p=="fr"){
			txt_costcd_fr.value ="";
			txt_costnm_fr.value ="";
		}else if(p=="to"){
			txt_costcd_to.value ="";
			txt_costnm_to.value ="";
		}
	}
}

/******************************************************************************
	Description : �����˾�
  parameter   : 
******************************************************************************/
function ln_Popup_Atcode(p){
		var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup_cost.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(arrResult != null) {
		 arrParam = arrResult.split(";");
		 if(p=="fr") {
				txt_atcode_fr.value = arrParam[0];
				txt_atkornam_fr.value = arrParam[1];
		 }else if(p=="to"){
				txt_atcode_to.value = arrParam[0];
				txt_atkornam_to.value = arrParam[1];
		 }
	}else{
		 if(p=="fr") {
				txt_atcode_fr.value = "";
				txt_atkornam_fr.value = "";
		 }else if(p=="to"){
				txt_atcode_to.text = "";
				txt_atkornam_to.value = "";					
		 }
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ��ȸ  -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr	value="-FSREFVAL+PRTSEQ+SSDAT+SSNBR+FSSEQ">
</object></comment><script>__ws__(__NSID__);</script> 

<!--����  -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--����  -->
<comment id="__NSID__"><object  id=gcds_atcode_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--����  -->
<comment id="__NSID__"><object  id=gcds_atcode_to classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 


<!--����Ʈ  -->
<comment id="__NSID__"><object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
    ln_Data_Reset("00"); //����Ÿ �缳��

	}
</script>


<!-- ���� (�˻�)-->
<script language="javascript" for="gcds_atcode_fr" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	document.all.LowerFrame.style.visibility="hidden";    
	gcds_atcode_fr.InsertRow(1);
	gcds_atcode_fr.NameValue(1,"CDCODE")="";
	gcds_atcode_fr.NameValue(1,"CDNAM")="��ü";
	gclx_atcode_fr.index=0;
</script>

<!-- ���� (�˻�)-->
<script language="javascript" for="gcds_atcode_to" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	document.all.LowerFrame.style.visibility="hidden";    
	gcds_atcode_to.InsertRow(1);
	gcds_atcode_to.NameValue(1,"CDCODE")="";
	gcds_atcode_to.NameValue(1,"CDNAM")="��ü";
	gclx_atcode_to.index=0;
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gclx_atcode_fr event=OnSelChange2()>

var ls_aa = "";
var ls_aaaa="";

 
ls_aaaa =  gclx_atcode_fr.BindColVal;
//alert(ls_aaaa);
gclx_atcode_to.BindColVal = ls_aaaa ; 

//alert(ls_aaaa);

</script>





<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a050006_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
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
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab31" style="height:30px;width:360px;" >&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_datefr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				  <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_datefr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
					~&nbsp;
					<comment id="__NSID__"><object  id=gcem_dateto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative;left:-1px;top:3px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dateto', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
				</td>
				<td class="tab18" width="237px" align=right colspan=4 ><nobr>
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
					</nobr>
				</td>
			</tr>
			<tr>
        <td class="tab17" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab19" width="690px" colspan=7>
				  <nobr>
					<comment id="__NSID__"><OBJECT id=gclx_atcode_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:6px;top:2px;font-size:12px;width:145px;">
							<param name=ComboDataID         value="gcds_atcode_fr">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort						value=false>
										<param name=ListExprFormat	value="CDNAM^0^130">
										<param name=BindColumn			value="CDCODE">	
							</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;

 		~	&nbsp;

							<comment id="__NSID__"><OBJECT id=gclx_atcode_to classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:145px;">
							<param name=ComboDataID         value="gcds_atcode_to">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort						value=false>
										<param name=ListExprFormat	value="CDNAM^0^130">
										<param name=BindColumn			value="CDCODE">	
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
	

					<!-- <input id="txt_atkornam_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode('fr');"> -->
					<!-- <input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_atkornam_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode('to');">
					<input id="txt_atcode_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:50px;height:20px;" maxlength="6" >		 -->		
					</nobr>
				</td>
			</tr>
			<!-- <tr>
        <td class="tab17" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab19" width="690px" colspan=7>
				  <nobr>
					<input id="txt_costnm_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup('fr');">
					<input id="txt_costcd_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_costnm_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup('to');">
					<input id="txt_costcd_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>
			</tr> -->
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
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<param name=ColSizing     value="true">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
							  <FC> Name='��ǥ��¥'		ID=SSDAT HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left sort=false show=TRUE</FC>
								<FC> Name='��ǥ��ȣ'	  ID=SSNBR   HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left sort=false show=TRUE </FC>
								<FC> Name='���ް���'		ID=ATCODE   HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left sort=false show=TRUE</FC>
								<FC> Name='�ΰ���'			ID=FSSEQ HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left sort=false </FC>
								<C> Name='����'					ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=200  align=left sort=TRUE</C>
								<C> Name='����'					ID=CD_NAM    HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left sort=TRUE</C>
								<C> Name='��ȣ'   				ID=CDNAM    HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left sort=false show=TRUE</C>
								<C> Name='����ڹ�ȣ'	ID=VEND_ID    HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center mask='XXX-XX-XXXXX'</C>
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
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
			B I N D   D E F I N I T I O N 
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_data01">
	<param name="DetailDataID"			value="gcds_data01">
	<param name="PaperSize"					value="A4">
	<!-- <param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false"> -->
	<param name="LandScape"					value="true">
	<param name="PrintSetupDlgFlag" value="true">
	<param name="SuppressColumns"   value="2:pageskip,COSTNM; 1:ATKORNAM">
	<param name="Format"						value="
	<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=228 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1042 ,top=21 ,right=1879 ,bottom=98 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1032 ,top=11 ,right=1868 ,bottom=87 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='KISU1', left=1013, top=124, right=1892, bottom=175, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='������ ����������' ,left=1037 ,top=29 ,right=1860 ,bottom=90 ,face='HY�߰��' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=180 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='COSTNM', left=79, top=26, right=717, bottom=69, align='left', supplevel=1, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=93 ,right=2807 ,bottom=93 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��ǥ��ȣ' ,left=968 ,top=116 ,right=1183 ,bottom=164 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ��ȣ' ,left=728 ,top=114 ,right=942 ,bottom=161 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1217 ,top=116 ,right=1484 ,bottom=159 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�뺯' ,left=1535 ,top=116 ,right=1802 ,bottom=159 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ܾ�' ,left=1852 ,top=114 ,right=2119 ,bottom=159 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2154 ,top=114 ,right=2807 ,bottom=159 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=529 ,top=114 ,right=664 ,bottom=161 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=79 ,top=114 ,right=479 ,bottom=159 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=71 ,top=180 ,right=2807 ,bottom=180 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=55 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='ATKORNAM', left=79, top=8, right=479, bottom=50, align='left', supplevel=1, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SSNBR', left=714, top=8, right=955, bottom=50, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETOT', left=1199, top=8, right=1503, bottom=50, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CRTOT', left=1516, top=8, right=1818, bottom=50, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JANAMT', left=1831, top=8, right=2138, bottom=50, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=2154, top=8, right=2807, bottom=50, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=476 ,top=56 ,right=2135 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SSDAT', left=476, top=8, right=717, bottom=50, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SSNBR', left=953, top=8, right=1193, bottom=50, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=114 ,top=56 ,right=476 ,bottom=56 ,supplevel=1 </L>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2418 ,top=3 ,right=2797 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=2805 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p / #t' ,left=1244 ,top=53 ,right=1667 ,bottom=95 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='CURTM' ,left=423 ,top=13 ,right=770 ,bottom=61 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='CURDT' ,left=79 ,top=13 ,right=426 ,bottom=61 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 