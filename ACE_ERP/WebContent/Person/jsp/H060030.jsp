<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�/�����Ű��ۼ�
+ ���α׷� ID	: h060030
+ �� �� �� ��	: 
+ �� �� �� ��	: ���ϳ�
+ �� �� �� ��	:
-----------------------------------------------------------------------------
+ �� �� �� �� :	
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------>
<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr  ">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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
get_cookdata();
lfn_init();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7); //+ gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

 var gs_empno = "";
//gs_date3=ln_trim(gs_date);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

  //gcem_evaym.text = gs_date;
	gcem_evaym.text = '200902';
	txt_empno.value = gusrid;
	txt_jobcode.value='AE03';
	ln_Query();

	gcds_manager.DataID = "/servlet/Person.hclcode_s2?v_str1=2061&v_str2="+gusrid;
	gcds_manager.Reset();	

	if(gcds_manager.countrow>0){ //������ ����
	//alert("������");
    txt_empno.readOnly= false;
		txt_jobcode.readOnly = false;
    txt_jobgrph.readOnly=false;
		txt_jobrr.readOnly = false;
		txt_jobkind.readOnly = false;
	} else {
	//alert("�����ھƴ�")
		txt_empno.readOnly= true;
		txt_jobcode.readOnly = true;
    txt_jobgrph.readOnly=true;
		txt_jobrr.readOnly = true;
		txt_jobkind.readOnly = true;
		}
}

/******************************************************************************
	Description :  �ʱ� ȭ�� �ε����� ��ȸ ( ��ü�� ��� ��� �μ��� �ƴ϶�...�޺��� ��Ÿ�� �μ��� ��ȸ�Ѵ�.)
******************************************************************************/
function ln_Query(){

  gs_empno = txt_empno.value;

 //�ʱ� ȭ�� �ε�����
  window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
  
  //�������׵� 
	gcds_mst.DataID = "/servlet/Person.h060030_s0?"
									+ "v_str1="+gcem_evaym.text
									+ "&v_str2="+gs_empno;
 // prompt('',gcds_mst.DataID);
	gcds_mst.Reset(); 
	if(gcds_mst.countrow<1){
		ln_Add();
	}else{
    ifrm.ln_Row_Clear(2); //�ʱ�ȭ
	}
	ifrm.ln_Query(); 

	txt_jobcode.value='AE03';
	//document.all.LowerFrame.style.visibility="hidden";
	} 


/*-----------------------------------------------------------------------------
		Description : ����ȸ ����
-----------------------------------------------------------------------------*/
function ln_Before(){

    //2008.11.12 JYS - ���ñٹ����� �μ� ������ ������ ���Ƿ� ������.
		/*
    gcds_data.DataID = "/servlet/Person.h060020_s2?"
		                + "v_str1="+gusrid;
		gcds_data.Reset();
    */
		//alert(gs_empno);

		gcds_data.DataID = "/servlet/Person.h060030_s22?"
		                + "v_str1="+gs_empno;
		gcds_data.Reset();
		//prompt('',gcds_data.DataID);
}

/*-----------------------------------------------------------------------------
		Description : �ʱ�����
-----------------------------------------------------------------------------*/
function ln_info(i) { 
    txt_evaym.value = gcem_evaym.text;
		txt_empno.value = gcds_data.namevalue(i,"EMPNO");
		txt_empnmk.value =gcds_data.namevalue(i,"EMPNMK");
		txt_deptcd.value =gcds_data.namevalue(i,"DEPTCD");
		txt_deptnm.value =gcds_data.namevalue(i,"DEPTNMK");
		txt_divcd.value  =gcds_data.namevalue(i,"DIVCD");
		txt_divnm.value  =gcds_data.namevalue(i,"DIVNM");
		txt_headcd.value =gcds_data.namevalue(i,"HEADCD");
		txt_headnm.value =gcds_data.namevalue(i,"HEADNM");
		txt_paygrd.value =gcds_data.namevalue(i,"PAYGRD");
		txt_paygrdnm.value =gcds_data.namevalue(i,"PAYGRDNM");
		txt_jobcode.value = 'AE03';//gcds_data.namevalue(i,"JOBCODE"); 
		txt_jobgrph.value = gcds_data.namevalue(i,"JOBGRPH"); 
		txt_jobrr.value = gcds_data.namevalue(i,"JOBRR"); 
		txt_jobkind.value = gcds_data.namevalue(i,"JOBKIND"); 

    if(gcds_data.namevalue(i,"DIVCD")!=""&&gcds_data.namevalue(i,"DIVCD")==gcds_data.namevalue(i,"DEPTCD")){
			txt_deptcd.value="";
			txt_deptnm.value="";
			gcds_data.namevalue(1,"DEPTCD")="";
			gcds_data.namevalue(1,"DEPTNMK")="";
		}

		if(gcds_data.namevalue(i,"HEADCD")!=""&&gcds_data.namevalue(i,"HEADCD")==gcds_data.namevalue(i,"DIVCD")){
			txt_divcd.value="";
			txt_divnm.value="";
			gcds_data.namevalue(1,"DIVCD")="";  
			gcds_data.namevalue(1,"DIVNM")="";  
		}	
}		
		

/******************************************************************************
	Description : ���߰�
******************************************************************************/
function ln_Add(){
  
	// ���߿� ���ƾ���.
  //if(gusrid=="6070001"||gusrid=="2040011"||gusrid=="2070037"||gusrid=="2040067"||gusrid=="2050018"||gusrid=="2070033"||gusrid=="2040001"||gusrid=="2050046"||gusrid=="6050005"){
  
	/****
	2008.11.11 JYS ���Ƿ� ����
 	if(gusrid=="6070001"){

	}else{
	  alert("�����Ű� �Է±Ⱓ�� ���� �Է��� �Ұ��մϴ�.");
	  if(gcds_data.rowposition>1){
			return false;
		}
	}
	****/

	//alert(gs_empno);
  
	if(gcem_evaym.text!='200902'){
		alert("�Է³���� Ȯ�� �Ͻʽÿ�.");
		return false;
	}
	
	if(!ln_Add_Chk()) false;

  ln_Before();
  i = gcds_data.rowposition;
  ln_SetDataHeader();
  gcds_mst.Addrow();
	txt_evaym.value = gcem_evaym.text;
	gcds_mst.namevalue(gcds_mst.rowposition,"EVAYM")=txt_evaym.value;
	gcds_mst.namevalue(gcds_mst.rowposition,"EMPNO")  =gcds_data.namevalue(i,"EMPNO");   
	gcds_mst.namevalue(gcds_mst.rowposition,"EMPNMK") =gcds_data.namevalue(i,"EMPNMK");  
	gcds_mst.namevalue(gcds_mst.rowposition,"DEPTCD") =gcds_data.namevalue(i,"DEPTCD");  
	gcds_mst.namevalue(gcds_mst.rowposition,"DEPTNMK")=gcds_data.namevalue(i,"DEPTNMK"); 
	gcds_mst.namevalue(gcds_mst.rowposition,"DIVCD")  =gcds_data.namevalue(i,"DIVCD");   
	gcds_mst.namevalue(gcds_mst.rowposition,"DIVNM")  =gcds_data.namevalue(i,"DIVNM");   
	gcds_mst.namevalue(gcds_mst.rowposition,"HEADCD") =gcds_data.namevalue(i,"HEADCD");  
	gcds_mst.namevalue(gcds_mst.rowposition,"HEADNM") =gcds_data.namevalue(i,"HEADNM");  
	gcds_mst.namevalue(gcds_mst.rowposition,"PAYGRD") =gcds_data.namevalue(i,"PAYGRD");  
	gcds_mst.namevalue(gcds_mst.rowposition,"PAYGRDNM")= gcds_data.namevalue(i,"PAYGRDNM");
	gcds_mst.namevalue(gcds_mst.rowposition,"JOBCODE")= 'AE03';//gcds_data.namevalue(i,"JOBCODE"); 
	gcds_mst.namevalue(gcds_mst.rowposition,"JOBGRPH")= gcds_data.namevalue(i,"JOBGRPH"); 
	gcds_mst.namevalue(gcds_mst.rowposition,"JOBRR")= gcds_data.namevalue(i,"JOBRR"); 
	gcds_mst.namevalue(gcds_mst.rowposition,"JOBKIND")= gcds_data.namevalue(i,"JOBKIND"); 	
	gcds_mst.namevalue(gcds_mst.rowposition,"I_EMPNO") =gusrid;  
	gcds_mst.namevalue(gcds_mst.rowposition,"U_EMPNO") =gusrid;  

	ifrm.ln_Row_Clear(2); //�ʱ�ȭ
	}


/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Row_Add(){
 	ifrm.ln_Add();
}

/******************************************************************************
	Description : �߰��� üũ ���� ����Ÿ ����� �߰� ����.
******************************************************************************/
function ln_Add_Chk(){


//	alert(gs_empno);

	gcds_chk.DataID = "/servlet/Person.h060030_s3?"
		               + "v_str1="+gcem_evaym.text
									 + "&v_str2="+gs_empno;
	//prompt('dtl::ln_Query',gcds_dtl.DataID);									
  gcds_chk.Reset();

	if(gcds_chk.namevalue(1,"CNT")>0){
		alert("�̹� ����Ÿ�� �����մϴ�. ��ȸ �� �����Ͻʽÿ�.");
		return false;
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
 
  
	// ���߿� ���ƾ���.
	//if(gusrid=="6070001"||gusrid=="2040011"||gusrid=="2070037"||gusrid=="2040067"||gusrid=="2050018"||gusrid=="2070033"||gusrid=="2040001"||gusrid=="2050046"||gusrid=="6050005"){
  /*******
	if(gusrid=="6070001"){

	}else{
		alert("�����Ű� �Է±Ⱓ�� ���� �Է��� �Ұ��մϴ�.");
		return false;
	}
	********/	


  if(!ln_Save_Chk()) return;

	ifrm.ln_Save();

}


/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Save_Chk() {
  //�ʼ��׸� üũ
	if(gcem_evaym.text!='200902'){
		alert("�Է³���� Ȯ�� �Ͻʽÿ�.");
		return false;
	}
 
  return true;
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Row_Delete(){
	ifrm.ln_Delete();
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
	ifrm.ln_Print();
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : �˾�
******************************************************************************/
function ln_Popup(gbn){

}

/******************************************************************************
	Description : ��뿩��
  parameter   :
******************************************************************************/
function ln_Enable(gbn){

}

/******************************************************************************
	Description : ��������
******************************************************************************/
function ln_Trim(str){
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
}


/******************************************************************************
	Description : ����Ÿ�� ��� ���� (mst)
  parameter   :
******************************************************************************/
function ln_SetDataHeader(){
  
      //��������,��������,��������
	if (gcds_mst.countrow<1){
		var s_temp = " EVAYM:STRING(6),EMPNO:STRING(7),EMPNMK:STRING(30),HEADCD:STRING(4),HEADNM:STRING(50),"
							 + " DIVCD:STRING(4),DIVNM:STRING(50),DEPTCD:STRING(4),DEPTNMK:STRING(50),PAYGRD:STRING(4),PAYGRDNM:STRING(50), "
							 + " JOBCODE:STRING(4),JOBGRPH:STRING(20),JOBRR:STRING(20),JOBKIND:STRING(20),JOBNAME:STRING(50),"
							 + " JOBSM:STRING(2000),"
							 + " EDU:STRING(1),MAJOR:STRING(40),SEX:STRING(1),ETC:STRING(20),EXP:STRING(100),CERTIFICATE:STRING(100),"
							 + " ENGLVL:STRING(1),JPLVL:STRING(1),CHINALVL:STRING(1),ETCLVL:STRING(20),HWGRDCD:STRING(1),EXGRDCD:STRING(1), "
							 + " PWGRDCD:STRING(1),OAGRDCD:STRING(20),ABILITY:STRING(100),TECHNIQUE:STRING(400),STUDY:STRING(100),"
							 + " STUDY2:STRING(100),STUDY3:STRING(100), I_EMPNO:STRING(10) ,U_EMPNO:STRING(10)";
	  gcds_mst.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : ��ȸ�� Loading bar start
  parameter   :
******************************************************************************/
function ln_Loading_Start(){
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.1";
	//document.all.LowerFrame.style.visibility="visible";
}
/******************************************************************************
	Description : ��ȸ�� Loading bar end
  parameter   :
******************************************************************************/
function ln_Loading_End(row){
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	lbl_search.innerText = "( " + row + " �� )";
	//document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
}

/******************************************************************************
	Description : �� ����
******************************************************************************/
function ln_Tabset(index){

	var div_cm=new Array("div_task","div_jobspec");

	for(var i=0;i<=1;i++){
	 
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}	else 	{
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}
							
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<OBJECT id=gcds_manager classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �����ڱ��� -->
</OBJECT>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h060030_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gs_tab event=OnSelChanged(index)>
	ln_Tabset((index-1));

//	tab_gb=index;

	//ln_init(tab_gb);

 // ln_Clear();
 // gcds_health.ClearAll();
</script>


<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
  if(row>=1){
		ln_info(row);
	}
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
  alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
	alert("������ �߻� �߽��ϴ�.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data2" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>
</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h060030_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
	    <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand" onclick="ln_Print()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
		  <img src="../../Common/img/btn/com_b_save.gif" 		style="cursor:hand" onclick="ln_Save()">
		</td>
  </tr>

	<tr>
		<td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="120px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;�Է³��&nbsp;</nobr></td>
					<td class="tab18"  style="width:100px;"  ><nobr>&nbsp;
					<comment id="__NSID__">
						<object  id=gcem_evaym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
											<param name=readOnly      value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
						 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_evaym', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
						 
						 <td align=center > <font color="blue"><b> &nbsp; ���� �Է½�, �ݵ�� ��� ��ư�� ������ �� �Է��Ͻñ� �ٶ��ϴ�. </b></font></td>
				</tr>
      </table>
		</td>
	</tr>

	<tr> 
    <td colspan=2 style="height:25px;position:relative;top:3px"><font color="blue"><b>1.���� ������ ��������</b></font></td>
	</tr>
	<tr>
		<td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="80px" height="20"  style="" bgcolor="#eeeeee" class="tab15" align=center rowspan=2><nobr>���</nobr></td>
					<td class="tab18" width="60" style="" ><nobr>
						<input id="txt_empno" name="txt_empno" type="text"     class="txtbox"   style= "position:relative;left:3px;top:0px;width:55px;height:20px;" >			
					</td>
					<td width="80px" height="20"  style="" bgcolor="#eeeeee" class="tab18" align=center rowspan=2><nobr>�Ҽ�</nobr></td>
					<td class="tab18" width="365" style="" >	
					  <input id="txt_evaym"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_headcd"  type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_divcd"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_deptcd"  type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_headnm"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
						<input id="txt_divnm"   type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
						<input id="txt_deptnm"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
					</td>
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center rowspan=2><nobr>����</nobr></td>
						<td class="tab18" style=""><nobr>
					  <input id="txt_paygrd"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width5px;height:20px;" ReadOnly>
						<input id="txt_paygrdnm" type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:55px;height:20px;" ReadOnly>
					</nobr></td>				
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center rowspan=2><nobr>����</nobr></td>
					<td class="tab18" style=""><nobr>
				<!--		<input id="txt_empno1"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly> -->
						<input id="txt_empnmk"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:55px;height:20px;" ReadOnly>
					</nobr></td>					
				</tr>
      </table>
		</td>
	</tr>

	<tr> 
    <td colspan=2 style="height:25px;position:relative;top:3px"><font color="blue"><b>2.�����з�</b></font></td>
	</tr>
	<tr>
		<td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="80px" height="20"  style="" bgcolor="#eeeeee" class="tab15" align=center rowspan=2><nobr>�����ڵ�</nobr></td>
					<td class="tab18" width="60" style="" ><nobr>
						<input id="txt_jobcode"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:55px;height:20px;"  >					
					</td>
					<td width="80px" height="20"  style="" bgcolor="#eeeeee" class="tab18" align=center rowspan=2><nobr>����</nobr></td>
					<td class="tab18" width="66" style="" >	
						<input id="txt_jobgrph"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:55px;height:20px;" >
					</td>
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center rowspan=2><nobr>����</nobr></td>
						<td class="tab18" width="66" style=""><nobr>
						<input id="txt_jobrr" type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:55px;height:20px;" >
					</nobr></td>				
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center rowspan=2><nobr>����</nobr></td>
					<td class="tab18"  width="66" style=""><nobr>
						<input id="txt_jobkind"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:55px;height:20px;" >
					</nobr></td>	
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center rowspan=2><nobr>������</nobr></td>
					<td class="tab18" style=""><nobr>
						<input id="txt_jobname"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:200px;height:20px;" >
					</nobr></td>						
				</tr>
      </table>
		</td>
	</tr>

	<tr> 
    <td colspan=2 style="height:25px;position:relative;top:3px"><font color="blue"><b>3.��������</b></font></td>
	</tr>
	<tr>
		<td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td class="tab15" style="" ><nobr>	
						<textarea id="txt_jobsm" style="font-size:9pt;width:876px;height:52px;border:0 solid #708090" onBlur="bytelength(this,this.value,2000);"></textarea>						
					</td>					
				</tr>
      </table>
		</td>
	</tr>

<tr><td height=13></td></tr>
 <tr> 
    <td COLSPAN=2 ALING=LEFT>
		  <table width="0" cellpadding="1" cellspacing="0" border="0">
				<tr> 
					<td width="0" align=RIGHT><NOBR>
					  <comment id="__NSID__"><OBJECT id=gs_tab classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;cursor:hand;">
              <PARAM NAME="BackColor" VALUE="#cccccc">
              <PARAM NAME="titleHeight" VALUE="20px">
              <PARAM NAME="DisableBackColor" VALUE="#eeeeee">
              <PARAM NAME="Format" VALUE="
									<T>divid=div_task  title='�������(�������)'</T>									
									<T>divid=div_jobspec  title='������'</T>                              
              ">
            </OBJECT></comment><script>__ws__(__NSID__);</script></NOBR>
					</td>
        </tr>
      </table>
		</td>
  </tr>

<tr> 
	<td COLSPAN=2>
	 <div id="div_task" style="display:block" >
	<table width="875" cellpadding="1" cellspacing="0" border="0">
	
	<tr><td height=13></td></tr>
	<tr><td colspan=2> * ������ �����ϴ� ������ ����Ư������ �з��Ͽ� �ۼ��Ͻñ� �ٶ��ϴ� </td></tr>
	<tr><td colspan=2> * ���߰� ��ư�� ������ ��, ����: ����ġ�� �Ѱ谡 100%�� �ǵ���, ���̵�: ��/��/��, �߻���: ��/��/��/�ݱ�/�б��߿� �Է��Ͽ� �ֽñ� �ٶ��ϴ� </td></tr>
			<td width="855" align="right" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_rowadd.gif"		style="cursor:hand" onclick="ln_Row_Add()">
		  <img src="../../Common/img/btn/com_b_rowdel.gif"		style="cursor:hand" onclick="ln_Row_Delete()">
			</td>
	</tr>
  <tr>
  <td COLSPAN=2>
		<table  cellpadding=0 cellspacing=0 style=width:855px;height:30px;font-size:9pt;background-color:#ffffff;>
		<tr> 
			<td width=40px  style='' bgcolor='#eeeeee'  class='tab15' align=center ><nobr>��</nobr></td>					
			<td width=120px  style='' bgcolor='#eeeeee'  class='tab18' align=center ><nobr>����</nobr></td>	
			<td width=150px  style='' bgcolor='#eeeeee'  class='tab18' align=center ><nobr>����</nobr></td>			
			<td width=325px style='' bgcolor='#eeeeee' class='tab18' align=center ><nobr>���� ����</nobr></td>
			<td width=60px  style='' bgcolor='#eeeeee' class='tab18' align=center ><nobr>����(%)</nobr></td>
			<td width=60px  style='' bgcolor='#eeeeee' class='tab18' align=center ><nobr>���̵�(��/��/��)</nobr></td>				
			<td width=100px  style='' bgcolor='#eeeeee' class='tab18' align=center ><nobr>�߻���</nobr></td>					
		</tr>
		</table>
	</td>
	</tr>
	<tr>
	 <td colspan=2>
		<iframe id="ifrm" name="ifrm" src="../../Person/html/h060030_ifrm.html" frameborder=0 style="position:relative;top:1px;width:872;height:330px;border:1 solid #708090;"></iframe>
	 </td>
	</tr>

</table>
</div>

 <div id="div_jobspec" style="display:none" >
  <table width="875" cellpadding="1" cellspacing="0" border="0">
		<tr><td height=13></td></tr>
		<tr><td colspan=2> * �� ���������� ���� �ʿ��� �Ϲ��� �ڰݿ���� ����Ͻñ� �ٶ��ϴ� (������ ����� ����ϴ� ���� �ƴմϴ�) </td></tr>

  <tr>
  <td COLSPAN=2>
		<table width="876" style="position:relative;top:4px;border:1 solid #708090;border-bottom-width:0px;" cellpadding=0 cellspacing=0 border=0 >
			<tr>
				<td class="tab11" rowspan=2 width="161px" bgcolor="#eeeeee" align="center">�Ϲ� �ڰݿ��</td>
				<td class="tab11" width="130px" bgcolor="#eeeeee">�з�</td>
				<td class="tab21" colspan=3 width="195px">
					<comment id="__NSID__"><OBJECT id=gclx_edu classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
					style="position:relative;left:8px;top:0px;font-size:12px;width:100px;">
					<param name=CBData					value="1^����,4^�ʴ���,2^����,3^���п���">
					<param name=CBDataColumns		value="Code, Parm">
					<param name=SearchColumn		value="Parm">
					<param name=Sort						value="false">
					<param name=ListExprFormat	value="Parm^0^80">
					<param name=BindColumn			value="Code">
					</OBJECT></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" colspan=2 width="130px" bgcolor="#eeeeee">����</td>
				<td class="tab22" colspan=3 width="260px"> <input type="text" id=txt_major class="txt11" style="width:150px;" maxlength="40" onBlur="bytelength(this,this.value,40);"></td> 
					</nobr></td>	
			</tr>
			<tr>
				<td class="tab11" width="px" bgcolor="#eeeeee">����</td>
				<td class="tab21" colspan=3 width="px">
					<comment id="__NSID__"><OBJECT id=gclx_sex classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
					style="position:relative;left:8px;top:0px;font-size:12px;width:100px;">
					<param name=CBData					value="1^��,2^��,3^����">
					<param name=CBDataColumns		value="Code, Parm">
					<param name=SearchColumn		value="Parm">
					<param name=Sort						value="false">
					<param name=ListExprFormat	value="Parm^0^80">
					<param name=BindColumn			value="Code">
					</OBJECT></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" colspan=2 width="px" bgcolor="#eeeeee">��Ÿ</td>
				<td class="tab22" colspan=3 width="px"><input type="text" id=txt_etc class="txt11" style="width:150px;" maxlength="20" onBlur="bytelength(this,this.value,20);"></td>
		</tr>

					<tr>
						<td class="tab11" rowspan=6  bgcolor="#eeeeee" align="center">�ҿ俪��</td>
						<td class="tab11"  bgcolor="#eeeeee">�ش�о߰���</td>
						<td class="tab22" colspan=8 width="px"> <input type="text" id=txt_exp class="txt11" style="width:450px;" maxlength="100" onBlur="bytelength(this,this.value,100);"></td> 
					</nobr></td>
					</tr>
					<tr>
						<td class="tab11" bgcolor="#eeeeee">�ҿ� �ڰ�/������</td>
						<td class="tab22" colspan=8 width="px"> <input type="text" id=txt_certi class="txt11" style="width:450px;" maxlength="100" onBlur="bytelength(this,this.value,100);"></td> 
					</nobr></td>
					</tr>
					<tr>
						<td class="tab11"  bgcolor="#eeeeee">�ܱ��� �ɷ�</td>
						<td class="tab11" width="65px" bgcolor="#eeeeee">����</td>
						<td class="tab21" width="65px">
							<comment id="__NSID__"><OBJECT id=gclx_eng classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:0px;font-size:12px;width:50px;">
							<param name=CBData					value="1^��,2^��,3^��">
							<param name=CBDataColumns		value="Code, Parm">
							<param name=SearchColumn		value="Parm">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="Parm^0^80">
							<param name=BindColumn			value="Code">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="65px" bgcolor="#eeeeee">�Ͼ�</td>
						<td class="tab21" width="65x">
							<comment id="__NSID__"><OBJECT id=gclx_japan classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:0px;font-size:12px;width:50px;">
							<param name=CBData					value="1^��,2^��,3^��">
							<param name=CBDataColumns		value="Code, Parm">
							<param name=SearchColumn		value="Parm">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="Parm^0^80">
							<param name=BindColumn			value="Code">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="65px" bgcolor="#eeeeee">�߱���</td>
						<td class="tab21" width="65px">
							<comment id="__NSID__"><OBJECT id=gclx_china classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:0px;font-size:12px;width:50px;">
							<param name=CBData					value="1^��,2^��,3^��">
							<param name=CBDataColumns		value="Code, Parm">
							<param name=SearchColumn		value="Parm">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="Parm^0^80">
							<param name=BindColumn			value="Code">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="65px" bgcolor="#eeeeee">��Ÿ</td>
						<td class="tab22" width="130 px"><input type="text" id=txt_etclvl class="txt11" style="width:80px;" maxlength="20" onBlur="bytelength(this,this.value,20);"></td>
				</tr>
					<tr>
						<td class="tab11" width="px" bgcolor="#eeeeee">OA �ɷ�</td>
						<td class="tab11" width="px" bgcolor="#eeeeee">����/�ѱ�</td>
						<td class="tab21" width="px">
							<comment id="__NSID__"><OBJECT id=gclx_word classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:0px;font-size:12px;width:50px;">
							<param name=CBData					value="1^��,2^��,3^��">
							<param name=CBDataColumns		value="Code, Parm">
							<param name=SearchColumn		value="Parm">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="Parm^0^80">
							<param name=BindColumn			value="Code">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="px" bgcolor="#eeeeee">����</td>
						<td class="tab21" width="px">
							<comment id="__NSID__"><OBJECT id=gclx_excel classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:0px;font-size:12px;width:50px;">
							<param name=CBData					value="1^��,2^��,3^��">
							<param name=CBDataColumns		value="Code, Parm">
							<param name=SearchColumn		value="Parm">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="Parm^0^80">
							<param name=BindColumn			value="Code">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="px" bgcolor="#eeeeee">�Ŀ�����Ʈ</td>
						<td class="tab21" width="px">
							<comment id="__NSID__"><OBJECT id=gclx_pw classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:0px;font-size:12px;width:50px;">
							<param name=CBData					value="1^��,2^��,3^��">
							<param name=CBDataColumns		value="Code, Parm">
							<param name=SearchColumn		value="Parm">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="Parm^0^80">
							<param name=BindColumn			value="Code">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="px" bgcolor="#eeeeee">��Ÿ</td>
						<td class="tab22" width="px"><input type="text" id=txt_etcoa class="txt11" style="width:80px;" maxlength="20" onBlur="bytelength(this,this.value,20);"></td>
				</tr>
					<tr>
						<td class="tab11" width="px" bgcolor="#eeeeee">���δɷ�</td>
				<td class="tab22" colspan=8 width="px"> <input type="text" id=txt_ability class="txt11" style="width:450px;" maxlength="100" onBlur="bytelength(this,this.value,100);"></td> 
					</nobr></td>	
			</tr>
					<tr>
						<td class="tab11"  width="px" bgcolor="#eeeeee">����/���</td>
				<td class="tab22" colspan=8 width="px"> <input type="text" id=txt_tech class="txt11" style="width:450px;" maxlength="400" onBlur="bytelength(this,this.value,400);"></td> 
					</nobr></td>	
			</tr>


			<tr>
				<td class="tab11" rowspan=3 width="px" bgcolor="#eeeeee" align="center">���������� ���� �ҿ䱳��</td>
				<td class="tab11" width="px" bgcolor="#eeeeee">������</td>
				<td class="tab22" colspan=8 width="px"> <input type="text" id=txt_study class="txt11" style="width:450px;" maxlength="100" onBlur="bytelength(this,this.value,100);"></td> 
					</nobr></td>	
			</tr>
			<tr>
				<td class="tab11" width="px" bgcolor="#eeeeee">������</td>
				<td class="tab22" colspan=8 width="px"> <input type="text" id=txt_study2 class="txt11" style="width:450px;" maxlength="100" onBlur="bytelength(this,this.value,100);"></td> 
					</nobr></td>	
			</tr>
			<tr>
				<td class="tab11" width="px" bgcolor="#eeeeee">������</td>
				<td class="tab22" colspan=8 width="px"> <input type="text" id=txt_study3 class="txt11" style="width:450px;" maxlength="100" onBlur="bytelength(this,this.value,100);"></td> 
					</nobr></td>	
			</tr>

</td></tr>
	</table>
 </div>

</td>
</tr>
</table>

<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>
    <param name=DataID    value=gcds_mst>
    <param name=BindInfo  value='
        <C>Col=EMPNO      ctrl=txt_empno          param=value    </C>
        <C>Col=EVAYM      ctrl=txt_evaym          param=value    </C>
        <C>Col=HEADCD     ctrl=txt_headcd         param=value    </C>
        <C>Col=DIVCD      ctrl=txt_divcd          param=value    </C>
        <C>Col=DEPTCD     ctrl=txt_deptcd         param=value    </C>
        <C>Col=HEADNM     ctrl=txt_headnm         param=value    </C>
        <C>Col=DIVNM      ctrl=txt_divnm          param=value    </C>
        <C>Col=DEPTNMK    ctrl=txt_deptnm         param=value    </C>
        <C>Col=PAYGRD     ctrl=txt_paygrd         param=value    </C>
        <C>Col=PAYGRDNM   ctrl=txt_paygrdnm       param=value    </C>
        <C>Col=EMPNMK     ctrl=txt_empnmk         param=value    </C>
        <C>Col=JOBCODE    ctrl=txt_jobcode        param=value    </C>
        <C>Col=JOBGRPH    ctrl=txt_jobgrph        param=value    </C>
        <C>Col=JOBRR      ctrl=txt_jobrr          param=value    </C>
        <C>Col=JOBKIND    ctrl=txt_jobkind        param=value    </C>
        <C>Col=JOBNAME    ctrl=txt_jobname        param=value    </C>
        <C>Col=JOBSM      ctrl=txt_jobsm          param=value    </C>
        <C>Col=EDU					ctrl=gclx_edu         param=BindColVal   </C>
        <C>Col=MAJOR				ctrl=txt_major        param=value				 </C>
        <C>Col=SEX					ctrl=gclx_sex					param=BindColVal   </C>
        <C>Col=ETC					ctrl=txt_etc          param=value				 </C>
        <C>Col=EXP					ctrl=txt_exp					param=value				 </C>
        <C>Col=CERTIFICATE  ctrl=txt_certi        param=value				 </C>
        <C>Col=ENGLVL				ctrl=gclx_eng         param=BindColVal   </C>
        <C>Col=JPLVL				ctrl=gclx_japan       param=BindColVal   </C>
        <C>Col=CHINALVL     ctrl=gclx_china       param=BindColVal   </C>
        <C>Col=ETCLVL				ctrl=txt_etclvl       param=value				 </C>
        <C>Col=HWGRDCD			ctrl=gclx_word        param=BindColVal   </C>
        <C>Col=EXGRDCD			ctrl=gclx_excel       param=BindColVal   </C>
        <C>Col=PWGRDCD			ctrl=gclx_pw					param=BindColVal   </C>
        <C>Col=OAGRDCD      ctrl=txt_etcoa        param=value				 </C>
        <C>Col=ABILITY			ctrl=txt_ability      param=value				 </C>
        <C>Col=TECHNIQUE        ctrl=txt_tech					param=value				 </C>
        <C>Col=STUDY				ctrl=txt_study        param=value				 </C>
        <C>Col=STUDY2       ctrl=txt_study2       param=value				 </C>
        <C>Col=STUDY3				ctrl=txt_study3       param=value				 </C>
    '>
</object></comment><script>__ws__(__NSID__);</script>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	