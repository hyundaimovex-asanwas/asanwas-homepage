<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	: �ڻ�����
+ ���α׷� ID	: A090034.jsp
+ �� �� �� ��	: �ڻ�� ��� 
+ ��  ��   �� : �� �� ��
+ �� �� �� �� : 2013.01.30
-----------------------------------------------------------------------------
+ �� �� �� �� : 
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: A090034_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ڻ����</title>

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

var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4);
var gs_fdcode = gfdcode;


   
/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
  
	//�Ҽ��ڵ�[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//�ڻ�з�[�˻�]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();
	gclx_fdcode.bindcolval = gs_fdcode;
	gcrd_gubun.codevalue=1;
	gclx_sys_fr.index=0; //���±���
	
	gcem_asq_fr.text = gcurdate.substring(0,4) + gcurdate.substring(5,7)  + "01";	    //������� from
	gcem_asq_to.text = gs_date;	            //������� to 
 }


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

  //ln_Find_ym();
   	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090034_s1"
									  + "?v_str1="+gclx_fdcode.BindColVal             //����
										+ "&v_str2="+gclx_asdivcod.BindColVal           //�ڻ�з�
										+ "&v_str3="+gcem_jasan.text                    //�ڻ���ڵ�									
										+ "&v_str4="+gcrd_gubun.codevalue               //���� 
										+ "&v_str5="+gclx_sys_fr.bindcolval             //����  
										+ "&v_str6="+txt_COSTCD.value                   //�����ڵ�
										+ "&v_str7="+gcem_asq_fr.text                   //������� fr 
										+ "&v_str8="+gcem_asq_to.text                   //�������to 
										+ "&v_str9="+txt_AUSEDPT.value;                  //�����ڵ�
										
										
										
//  prompt('', gcds_code01.DataID);				
	gcds_code01.Reset();
}


/******************************************************************************
	Description : �ڻ�� �˾�
******************************************************************************/
function ln_Popup3(e){

	if(e=='01'){           //�ڻ�� �˾�â
		var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL;	
		var strPos;

		arrParam[0]=gclx_asdivcod.bindcolval;
		
		//strURL = "./Atcode_popup_1.jsp";
        strURL = "./astname_popup.jsp";
		strPos = "dialogWidth:596px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_jasan.value = arrParam[1];  //�ڻ��
			gcem_jasan.text = arrParam[0];  //�ڻ��ڵ�
		} else {
			gcem_jasan.text = "";
			txt_jasan.value = "";
		}
	}
}


/******************************************************************************
	Description : ���� �˾�
	Parameter   : srow - grid�� row, strgb - 01: grid,  02:�˻�����
******************************************************************************/
function ln_Popup4(srow,strgb){

  var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0]="0030";//�����ڵ�
	arrParam[1]="";
	arrParam[2]="";
	arrParam[3]="";

  strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	arrResult = showModalDialog(strURL,arrParam,strPos);

 if(strgb=="02"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_COSTCD.value = ln_Trim(arrParam[0]);
			txt_COSTNM.value = ln_Trim(arrParam[1]); 
		}else{
			txt_COSTCD.value = "";	
			txt_COSTNM.value = "";
		}
	}
}


/******************************************************************************
	Description : �μ� �˾�
	Parameter   : 01-���μ�,  02-�����μ�
******************************************************************************/
function ln_Popup(){

     var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = "";

	strURL = "./hcdept_popup.jsp";
	strPos = "dialogWidth:500px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);


		if(arrResult != null) {
			arrParam = arrResult.split(";");       
  		    txt_AUSEDPT.value = ln_Trim(arrParam[0]);
			txt_AUSEDPTNM.value= ln_Trim(arrParam[1])
		} else {
			txt_AUSEDPT.value = "";
			txt_AUSEDPTNM.value = "";
		}
 
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("�ڻ����","",2);
}

/******************************************************************************
	Description : ��� 
******************************************************************************/
function ln_Print(){
        var j=0;
        var chkcnt = 0; 

        gcds_report00.clearAll();

        ln_SetDataHeader();
        
        for( var i = 1; i<=gcds_code01.countrow; i++){
        
			if (gcds_code01.namevalue(i,"CHK")=="T") { 
				chkcnt+=1;
            
	            if (chkcnt%3==1){ //
	                 gcds_report00.Addrow();
	                 j+=1;
	        		gcds_report00.namevalue(j, "ASTNM01")=gcds_code01.namevalue(i,"ASTNM");              //�ڻ��
	        		gcds_report00.namevalue(j, "ASAQSDAT01")=gcds_code01.namevalue(i,"ASAQSDAT");  //�������
	        		gcds_report00.namevalue(j, "ASTNBR01")=gcds_code01.namevalue(i,"ASTNBR");          //�ڻ��ȣ
	        		gcds_report00.namevalue(j, "BARCODE01")=gcds_code01.namevalue(i,"BARCODE");     //���ڵ� 
	        		
	        	}else if (chkcnt%3==2){ //Ȧ�� 
	        	    gcds_report00.namevalue(j, "ASTNM02")=gcds_code01.namevalue(i,"ASTNM");              //�ڻ��
	        		gcds_report00.namevalue(j, "ASAQSDAT02")=gcds_code01.namevalue(i,"ASAQSDAT");  //�������
	        		gcds_report00.namevalue(j, "ASTNBR02")=gcds_code01.namevalue(i,"ASTNBR");          //�ڻ��ȣ
	        		gcds_report00.namevalue(j, "BARCODE02")=gcds_code01.namevalue(i,"BARCODE");     //���ڵ� 
	        		
	        		
	        	}else if (chkcnt%3==0) { //¦��  
	        		gcds_report00.namevalue(j, "ASTNM03")=gcds_code01.namevalue(i,"ASTNM");              //�ڻ��
	        		gcds_report00.namevalue(j, "ASAQSDAT03")=gcds_code01.namevalue(i,"ASAQSDAT");  //�������
	        		gcds_report00.namevalue(j, "ASTNBR03")=gcds_code01.namevalue(i,"ASTNBR");          //�ڻ��ȣ
	        		gcds_report00.namevalue(j, "BARCODE03")=gcds_code01.namevalue(i,"BARCODE");     //���ڵ� 
	        	}
	        }
        }
	
		gcrp_barcode.preview();			
	
  
}


/******************************************************************************
	Description : ��� 
******************************************************************************/
function ln_Print2(){

    var j=0;
     gcds_report02.clearAll();
    
    ln_SetDataHeader2();

     for( var i = 1; i<=gcds_code01.countrow; i++){
        
			if (gcds_code01.namevalue(i,"CHK")=="T") { 
			        gcds_report02.Addrow();
			        j = gcds_report02.rowposition;
	        		gcds_report02.namevalue(j, "ASTNM")=gcds_code01.namevalue(i,"ASTNM");              //�ڻ��
	        		gcds_report02.namevalue(j, "ASAQSDAT")=gcds_code01.namevalue(i,"ASAQSDAT");  //�������
	        		gcds_report02.namevalue(j, "ASTNBR")=gcds_code01.namevalue(i,"ASTNBR");          //�ڻ��ȣ
	        		gcds_report02.namevalue(j, "BARCODE")=gcds_code01.namevalue(i,"BARCODE");     //���ڵ� 
	        		gcds_report02.namevalue(j, "ASTUSERNM")=gcds_code01.namevalue(i,"ASTUSERNM");     //���ڵ� 
	        	
	        }
        }
        
        //prompt('', gcds_report02.text);
	
		gcrp_barcode02.preview();				
}


/******************************************************************************
	Description : ��� DataSet head
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_report00.countrow<1){
		var s_temp = "ASTNM01:STRING(100),ASAQSDAT01:STRING(8),ASTNBR01:STRING(8),BARCODE01:STRING(30),"
		                  + "ASTNM02:STRING(100),ASAQSDAT02:STRING(8),ASTNBR02:STRING(8),BARCODE02:STRING(30),"
		                  + "ASTNM03:STRING(100),ASAQSDAT03:STRING(8),ASTNBR03:STRING(8),BARCODE03:STRING(30),";
		gcds_report00.SetDataHeader(s_temp);
	}
}



function ln_SetDataHeader2(){
	if (gcds_report02.countrow<1){
		var s_temp = "ASTNM:STRING(100),ASAQSDAT:STRING(8),ASTNBR:STRING(8),BARCODE:STRING(30),ASTUSERNM:STRING(20)";
		gcds_report02.SetDataHeader(s_temp);
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- ���� -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- �ڻ�з� -->
<object  id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object>

<!-- ���������ã�� -->
<object  id="gcds_astym" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object>

<!-- Report Head -->
<object  id=gcds_report00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<!-- Report Head -->
<object  id=gcds_report02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
  
  ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

//	gcgd_disp01.Editable =true;

	if(gcds_code01.countrow<=0)
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>


<!-- �����з� (�˻�)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	gclx_fdcode.index=0;
</script>

<!-- �ڻ�з� (�˻�)-->
<script language="javascript" for="gcds_asdivcod" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	document.all.LowerFrame.style.visibility="hidden";    
	gcds_asdivcod.InsertRow(1);
	gcds_asdivcod.NameValue(1,"CDCODE")="";
	gcds_asdivcod.NameValue(1,"CDNAM")="��ü";
	gclx_asdivcod.index=0;
</script>

<script language=JavaScript for=gcgd_disp01  event=OnClick(row,colid)>
	
	if (colid =="CHK"&&row==0){
		if(gcds_code01.namevalue(1,"CHK")=="T"){
			for(var i=1;i<=gcds_code01.countrow;i++){
				gcds_code01.namevalue(i,"CHK")="F";
			}
		}else{
			for(var i=1;i<=gcds_code01.countrow;i++){
				gcds_code01.namevalue(i,"CHK")="T";
			}
		}
	}
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090034_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  
		    <img src="../../Common/img/btn/com_b_barcode_print.gif"	style="cursor:hand" onClick="ln_Print2()"> 
		    <img src="../../Common/img/btn/com_b_label_print.gif"	        style="cursor:hand" onClick="ln_Print()">
		    <img src="../../Common/img/btn/com_b_excel.gif"	                style="cursor:hand;" onclick="ln_Excel()"> 
			<img src="../../Common/img/btn/com_b_query.gif"		            style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  class="tab25" bgcolor="#eeeeee" align=center>����</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=ListExprFormat	value="FDNAME^0^120">
				<param name=BindColumn			value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center> �ڻ�з�</td>  
	  <td width="120px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=ListExprFormat	value="CDNAM^0^120">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>�ڻ��</td> 
		<td class="tab24" >&nbsp;
			<input id="txt_jasan" type="text" class="txtbox"  style= "width:190px;height:20px;position:relative;left:-2px;top:-2px;" MaxLength=30>
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup3(01)">
			<comment id="__NSID__">
			<OBJECT id=gcem_jasan classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:50px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=Format			value="#######">
				<param name=PromptChar	value="_">
				<param name=Enable			value="false">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
	</tr>
	
	<tr> 
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >����</td>
		<td class="tab28" >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:100">
					<param name=Cols	  value="2">
					<param name=Format	value="1^��ȭ,2^��ȭ">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 

		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center> ����</td>  
	  <td width="120px" class="tab28">&nbsp;
			<comment id="__NSID__">
				<OBJECT id=gclx_sys_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
					<param name=CBData					value="^��ü,0^����,1^�Ű�,2^���,8^��ü">
					<param name=CBDataColumns		value="Code, Parm">
					<param name=SearchColumn		value="Parm">
					<param name=Sort						value="false">
					<param name=ListExprFormat	value="Parm^0^120">
					<param name=BindColumn			value="Code">
					<param name=XPStyle         value=true>
				</OBJECT></comment><script>__ws__(__NSID__);</script> 						
		</td>
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>������</td> 
		<td class="tab28" >&nbsp;
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup4('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
	<tr> 
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >������� </td>
		<td class="tab28" colspan=3 >&nbsp;
			<comment id="__NSID__">
				<OBJECT id=gcem_asq_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:-3px;width:70px;height:20px;">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
				</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_asq_fr', 'Text')" style="position:relative;width:20px;left:-9px;top:1px;cursor:hand;">~&nbsp;
				<comment id="__NSID__">
				<OBJECT id=gcem_asq_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:-3px;width:70px;height:20px;">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
				</OBJECT></comment><script>__ws__(__NSID__);</script> 
		    <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_asq_to', 'Text')" style="position:relative;width:20px;left:1px;top:1px;cursor:hand;">
		</td> 
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>���μ�</td> 
		<td class="tab28" >&nbsp;
			<input id="txt_AUSEDPTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup()">
			<input id=txt_AUSEDPT   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:350px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		    value="gcds_code01">
					<param name="IndWidth"		    value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		    value="true">
					<param name="Sortview"		    value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		    value="true"> 
					<param name=TitleHeight         value="30">
					<param name=UsingOneClick  value="1">				 
					<param name=ViewSummary   value="1">
					<param name="Format"		    value=" 
					<FC> Name='����'			    ID=CHK            	HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=center   SumBgColor=#C3D0DB sumtext=''   EditStyle = CheckBox  </FC>
					<FC> Name='�ڻ�з�'			ID=AST2NDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left	      edit = none  SumBgColor=#C3D0DB sumtext=''   sort=true  </FC>
					<FC> Name='�ڻ��ȣ'			ID=ASTNBR			HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=center   edit = none  SumBgColor=#C3D0DB sumtext=''       sort=true  </FC>
					<FC> Name='�ڻ��'			    ID=ASTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left	      edit = none  SumBgColor=#C3D0DB sumtext='��'   sort=true  SumTextAlign=center </FC>
					<C> Name='�������'			ID=ASAQSDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center   edit = none  SumBgColor=#C3D0DB sumtext=''       sort=true    MASK='XXXX/XX/XX'</C>
					<C> Name='���ݾ�'			ID=ASTAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80    align=right	   edit = none   SumBgColor=#C3D0DB sumtext='@sum'  sort=true </C>
					<C> Name='������'				ID=COSTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left	      edit = none   SumBgColor=#C3D0DB sumtext=''   sort=true </C>
					<C> Name='����'		    	    ID=ASTSTATNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center   edit = none  SumBgColor=#C3D0DB sumtext=''   sort=true </C>
					<C> Name='�����'		    	ID=ASTUSER	    HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center   edit = none  SumBgColor=#C3D0DB sumtext=''   sort=true </C>
					<C> Name='�����'		    	ID=ASTUSERNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center   edit = none  SumBgColor=#C3D0DB sumtext=''   sort=true </C>
					<C> Name='���μ�'		  	ID=USEDPT	        HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left   edit = none  SumBgColor=#C3D0DB sumtext=''   sort=true  show=false</C>
					<C> Name='���μ�'		   	ID=DEPTNM     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left   edit = none  SumBgColor=#C3D0DB sumtext=''   sort=true </C>
				
		
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>

<!-- ���ڵ� -->
<comment id="__NSID__"><OBJECT id=gcrp_barcode  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="DetailDataID"           value="gcds_report00"> 
	<param name="LandScape"            value="false">
	<param name="PaperSize"	            value="A4">
	<param name="PrintSetupDlgFlag"	value=true>
	<param name="MargineX"               value=5>
	<param name="MargineY"              value=5>	

	<PARAM NAME="Format" VALUE="


<B>id=default ,left=0,top=0 ,right=2000 ,bottom=299 ,face='����ü' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=45 ,top=34 ,right=246 ,bottom=77</I>
	<L> left=34 ,top=3 ,right=635 ,bottom=3 </L>
	<L> left=34 ,top=101 ,right=635 ,bottom=101 </L>
	<C>id='BARCODE01', left=265, top=19, right=585, bottom=95, face='WASP 39 M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTNM01', left=265, top=116, right=630, bottom=167, align='left', face='����ü', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='ASAQSDAT01', left=265, top=172, right=630, bottom=222, align='left' ,mask='XXXX-XX-XX', face='����ü', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='ASTNBR01', left=265, top=228, right=630, bottom=278, align='left', face='����ü', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='�ڻ��ڵ� :' ,left=45 ,top=228 ,right=257 ,bottom=278 ,face='����ü' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :' ,left=45 ,top=172 ,right=257 ,bottom=222 ,face='����ü' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� :' ,left=45 ,top=116 ,right=257 ,bottom=167 ,face='����ü' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=34 ,top=3 ,right=34 ,bottom=288 </L>
	<L> left=635 ,top=3 ,right=635 ,bottom=288 </L>
	<L> left=672 ,top=3 ,right=672 ,bottom=288 </L>
	<T>id='�� �� �� :' ,left=683 ,top=116 ,right=894 ,bottom=167 ,face='����ü' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :' ,left=683 ,top=172 ,right=894 ,bottom=222 ,face='����ü' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڻ��ڵ� :' ,left=683 ,top=228 ,right=894 ,bottom=278 ,face='����ü' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ASTNBR02', left=902, top=228, right=1267, bottom=278, align='left', face='����ü', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='ASAQSDAT02', left=902, top=172, right=1267, bottom=222, align='left' ,mask='XXXX-XX-XX', face='����ü', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='ASTNM02', left=902, top=116, right=1267, bottom=167, align='left', face='����ü', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='BARCODE02', left=902, top=19, right=1222, bottom=95, face='WASP 39 M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=672 ,top=101 ,right=1273 ,bottom=101 </L>
	<L> left=672 ,top=3 ,right=1273 ,bottom=3 </L>
	<I>id='../../Common/img/icon.jpg' ,left=683 ,top=34 ,right=884 ,bottom=77</I>
	<I>id='../../Common/img/icon.jpg' ,left=1331 ,top=34 ,right=1532 ,bottom=77</I>
	<L> left=1320 ,top=3 ,right=1921 ,bottom=3 </L>
	<L> left=1320 ,top=101 ,right=1921 ,bottom=101 </L>
	<C>id='BARCODE03', left=1550, top=19, right=1871, bottom=95, face='WASP 39 M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTNM03', left=1550, top=116, right=1916, bottom=167, align='left', face='����ü', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='ASAQSDAT03', left=1550, top=172, right=1916, bottom=222, align='left' ,mask='XXXX-XX-XX', face='����ü', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='ASTNBR03', left=1550, top=228, right=1916, bottom=278, align='left', face='����ü', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='�ڻ��ڵ� :' ,left=1331 ,top=228 ,right=1543 ,bottom=278 ,face='����ü' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :' ,left=1331 ,top=172 ,right=1543 ,bottom=222 ,face='����ü' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� :' ,left=1331 ,top=116 ,right=1543 ,bottom=167 ,face='����ü' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1320 ,top=3 ,right=1320 ,bottom=288 </L>
	<L> left=1921 ,top=3 ,right=1921 ,bottom=288 </L>
	<L> left=1270 ,top=3 ,right=1270 ,bottom=288 </L>
	<L> left=34 ,top=288 ,right=635 ,bottom=288 </L>
	<L> left=672 ,top=288 ,right=1273 ,bottom=288 </L>
	<L> left=1320 ,top=288 ,right=1921 ,bottom=288 </L>
</B>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>	

<!-- ���ڵ� -->
<comment id="__NSID__"><OBJECT id=gcrp_barcode02  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="DetailDataID"           value="gcds_report02"> 
	<PARAM NAME="PaperSize"						VALUE="user">	
	<PARAM NAME="PaperWidth"					VALUE="500">
	<PARAM NAME="PaperLength"					VALUE="550">
	<PARAM NAME="FixPaperSize"				VALUE="true">
	<PARAM NAME="PrintMargine"				    VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"		    VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="LandScape"				    VALUE="false">

	<PARAM NAME="Format" VALUE="


<B>id=default ,left=0,top=0 ,right=2000 ,bottom=434 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='ASTNBR', left=138, top=159, right=442, bottom=201, face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASAQSDAT', left=138, top=111, right=442, bottom=151 ,mask='XXXX/XX/XX', face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTUSERNM', left=138, top=323, right=442, bottom=360, face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BARCODE', left=8, top=373, right=397, bottom=418, face='Free 3 of 9 Extended Regular', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����������' ,left=138 ,top=273 ,right=442 ,bottom=312 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ASTNM', left=138, top=56, right=442, bottom=98, face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>



	">
</OBJECT></comment><script>__ws__(__NSID__);</script>	


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 