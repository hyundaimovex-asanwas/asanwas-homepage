<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�޿�������
+ ���α׷� ID	: H100011
+ �� �� �� ��	: ��ȸ|����|���|����|File Open
+ �� �� �� ��	: ���ϳ�
+ �� �� �� ��	: h100011_r1, h100011_s1, h100011_s2, h100011_s3,h100011_s4
							  h100011_t1, h100011_t2, h100011_t3
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>�޿�������</title>

<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>


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


var tab_gb=1;


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


  ln_init(tab_gb);
	chk_p01.checked = true;
  
}
	

function ln_init(param){
gcds_yymm.DataID = "/servlet/Contract.h100011_r1?tab_gb="+param;
//prompt(this,gcds_yymm.DataID);
gcds_yymm.Reset();

}


/******************************************************************************
 ��ȸ
******************************************************************************/
function ln_Query(){
  if(tab_gb==1){
	var v_str1 = gcem_htdt.text;
  gcds_health.UseChangeInfo = "true"; 
  if (ln_Trim(gcem_htdt.text) == "") {
		alert("�˻��� �ش� ����� �Է��Ͽ� �ֽʽÿ�.");
		gcem_htdt.text="";
		gcem_htdt.focus();
	} else {
		gcds_health.DataID = "/servlet/Contract.h100011_s1?v_str1=" + v_str1; 
	//	prompt(this,gcds_health.DataID);
		gcds_health.Reset();
		gcem_htapply.ReadOnly = true;
	  gcem_htempno.ReadOnly = true;
	}
 }else if(tab_gb==2){
	var v_str2 = gcem_gtdt.text;
  gcds_guarantee.UseChangeInfo = "true"; 
  if (ln_Trim(gcem_gtdt.text) == "") {
		alert("�˻��� �ش� ����� �Է��Ͽ� �ֽʽÿ�.");
		gcem_gtdt.text="";
		gcem_gtdt.focus();
	} else {
		gcds_guarantee.DataID = "/servlet/Contract.h100011_s2?v_str2=" + v_str2; 
	//	prompt(this,gcds_guarantee.DataID);
		gcds_guarantee.Reset();
		gcem_gtapply.ReadOnly = true;
	  gcem_gtempno.ReadOnly = true;
	}
 }else if(tab_gb==3){
	var v_str3 = gcem_ntdt.text;
  gcds_national.UseChangeInfo = "true"; 
  if (ln_Trim(gcem_ntdt.text) == "") {
		alert("�˻��� �ش� ����� �Է��Ͽ� �ֽʽÿ�.");
		gcem_ntdt.text="";
		gcem_ntdt.focus();
	} else {
		gcds_national.DataID = "/servlet/Contract.h100011_s3?v_str3=" + v_str3; 
		gcds_national.Reset();
		gcem_ntapply.ReadOnly = true;
	  gcem_ntempno.ReadOnly = true;
	}
 }
}


/******************************************************************************
	Description : �˻� �˾�
******************************************************************************/
function ln_Popup(gbn){
	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

	if(gbn=="1"){
	  if(gcds_health.SysStatus(gcds_health.rowposition)!=1){
			return false;
		}
	}
		if(gbn=="2"){
	  if(gcds_guarantee.SysStatus(gcds_guarantee.rowposition)!=1){
			return false;
		}
	}
		if(gbn=="3"){
	  if(gcds_national.SysStatus(gcds_national.rowposition)!=1){
			return false;
		}
	}
  arrSend[0]="H100011";
	strURL = "./H100011_popup.jsp"
	strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

	if(gbn=="1"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_htempno.text = arrParam[0];
			txt_empnmk_1.value = arrParam[1]; 
		} else {
			gcem_htempno.text="";
			txt_empnmk_1.value  ="";			//����
		}
	}
  else if(gbn=="2"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_gtempno.text = arrParam[0];  //���
			txt_empnmk_2.value = arrParam[1]; //����
		} else {
			gcem_gtempno.text ="";
			txt_empnmk_2.value ="";			//����
			
		}
	} 
	else if(gbn=="3"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_ntempno.text = arrParam[0];  //���
			txt_empnmk_3.value = arrParam[1]; //����
		} else {
	   	gcem_ntempno.text ="";
			txt_empnmk_3.value ="";			//����
	
		}
	}
}



/******************************************************************************
	 ���
******************************************************************************/
function ln_Add(){
  if(tab_gb==1){
		ln_SetDataHeader();
		gcem_htapply.ReadOnly = false;
		gcem_htempno.ReadOnly = false;
		gcds_health.addrow();
		gcem_htdt.enabled = true;
		gcem_htdt.focus();
		gcem_htapply.text=gcem_htdt.text;
	}else if(tab_gb==2){
		ln_SetDataHeader();
		gcem_gtapply.ReadOnly = false;
		gcem_gtempno.ReadOnly = false;
		gcds_guarantee.addrow();
		gcem_gtdt.enabled = true;
		gcem_gtdt.focus();
		gcem_gtapply.text=gcem_gtdt.text;
	}else if(tab_gb==3){
		ln_SetDataHeader();
		gcem_ntapply.ReadOnly = false;
		gcem_ntempno.ReadOnly = false;
		gcds_national.addrow();
		gcem_ntdt.enabled = true;
		gcem_ntdt.focus();
		gcem_ntapply.text=gcem_ntdt.text;
	}
}


/******************************************************************************
	 ����
******************************************************************************/
function ln_Save(){
  if(tab_gb==1){
		if(!ln_Chk_Save())return;
    //alert("gcds_health.SysStatus(i)::"+gcds_health.SysStatus(i));
		//alert("UseChangeInfo::"+gcds_health.UseChangeInfo);

		else if(gcds_health.UseChangeInfo==false){
			if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
				gctr_health.KeyValue = "h100011_t1(I:USER=gcds_health)";
				gctr_health.Action = "/servlet/Contract.h100011_t1";
			//	prompt('',gcds_health.text);
				gctr_health.post();
				return ln_Query();
				gcds_health.UseChangeInfo = "true"; 
			}
		}else if (gcds_health.IsUpdated) {	
				if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
					gctr_health.KeyValue = "h100011_t1(I:USER=gcds_health)";
					gctr_health.Action = "/servlet/Contract.h100011_t1";

				//	prompt('',gcds_health.text);
					gctr_health.post();
					return ln_Query();
					gcds_health.UseChangeInfo = "true";
				}
			}

		}else if(tab_gb==2){
			if(!ln_Chk_Save())return;
			//alert("UseChangeInfo::"+gcds_guarantee.UseChangeInfo);
			if(gcds_guarantee.UseChangeInfo==false){
			  if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
					gctr_guarantee.KeyValue = "h100011_t2(I:USER=gcds_guarantee)";
					gctr_guarantee.Action = "/servlet/Contract.h100011_t2";
					//prompt('',gcds_guarantee.text);
					gctr_guarantee.post();
					return ln_Query();
					gcds_guarantee.UseChangeInfo = "true"; 
				}
			}else if (gcds_guarantee.IsUpdated) {	
					if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
					gctr_guarantee.KeyValue = "h100011_t2(I:USER=gcds_guarantee)";
					gctr_guarantee.Action = "/servlet/Contract.h100011_t2";
					//prompt('',gcds_guarantee.text);
					gctr_guarantee.post();
					return ln_Query();	
					gcds_guarantee.UseChangeInfo = "true"; 
					} 
				}

		}else if(tab_gb==3){
			 if(!ln_Chk_Save())return;
  		  //alert("UseChangeInfo::"+gcds_national.UseChangeInfo);
				if(gcds_national.UseChangeInfo==false){
					if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
					gctr_national.KeyValue = "h100011_t3(I:USER=gcds_national)";
					gctr_national.Action = "/servlet/Contract.h100011_t3";
					//prompt('gcds_national',gcds_national.text);
					gctr_national.post();
					return ln_Query();
					gcds_national.UseChangeInfo = "true"; 
				}
			 }else if (gcds_national.IsUpdated) {
				if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
					gctr_national.KeyValue = "h100011_t3(I:USER=gcds_national)";
					gctr_national.Action = "/servlet/Contract.h100011_t3";
					//prompt('gcds_national',gcds_national.text);
					gctr_national.post();
					return ln_Query();
					gcds_national.UseChangeInfo = "true"; 
					}
				} 
		}
}


/******************************************************************************
	Description : File open �˾� 
******************************************************************************/


function Open_File() {
      if(tab_gb==1){
				if (chk_p01.checked == false) { 
				//alert("chk_p01.value::"+chk_p01.checked);
				gcds_health.UseChangeInfo = "false"; 
				tb_InputFile.Open();
			//tb_DataSet.AddRow();	
			//tb_DataSet.ColumnValue(tb_DataSet.CountRow,1) = tb_DataSet.CountRow;
			//gcds_data.ColumnString(tb_DataSet.CountRow,2) = tb_InputFile.Value;

			//alert("file:::"+tb_InputFile.Value);
				gcds_health.DataId = tb_InputFile.Value;
			  gcds_health.Reset();
				} else if(chk_p01.checked == true) {
				gcds_health.UseChangeInfo = "true";
				alert("file open ��뿩�θ� Ȯ���Ͽ� �ֽʽÿ�.");
				}
			}else if (tab_gb==2){
				if(chk_p01.checked==false) { 	
					gcds_guarantee.UseChangeInfo = "false"; 
					tb_InputFile.Open();
					gcds_guarantee.DataId = tb_InputFile.Value;
					gcds_guarantee.Reset();
				} else if (chk_p01.checked==true){
					gcds_guarantee.UseChangeInfo = "true"; 
					alert("file open ��뿩�θ� Ȯ���Ͽ� �ֽʽÿ�.");
					}
				}else if (tab_gb==3){
			     if (chk_p01.checked==false){ 
					gcds_national.UseChangeInfo = "false"; 
					tb_InputFile.Open();
					gcds_national.DataId = tb_InputFile.Value;
				  gcds_national.Reset();
					}else if (chk_p01.checked==true){
					gcds_national.UseChangeInfo = "true"; 
					alert("file open ��뿩�θ� Ȯ���Ͽ� �ֽʽÿ�.");
					}
				}
			}


/******************************************************************************
	Description :  ����
******************************************************************************/
function ln_Delete(){
if(tab_gb==1){
	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_health.deleterow(gcds_health.rowposition);
		gctr_health.KeyValue = "h100011_t1(I:USER=gcds_health)";
		gctr_health.Action = "/servlet/Contract.h100011_t1";
		gctr_health.post();
		return ln_Query();
	}else gcds_health.undo(gcds_health.rowposition);
}else if(tab_gb==2){
if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_guarantee.deleterow(gcds_guarantee.rowposition);
		gctr_guarantee.KeyValue = "h100011_t2(I:USER=gcds_guarantee)";
		gctr_guarantee.Action = "/servlet/Contract.h100011_t2";
		gctr_guarantee.post();
		return ln_Query();
	}else gcds_guarantee.undo(gcds_guarantee.rowposition);		
}else if(tab_gb==3){
	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_national.deleterow(gcds_national.rowposition);
		gctr_national.KeyValue = "h100011_t3(I:USER=gcds_national)";
		gctr_national.Action = "/servlet/Contract.h100011_t3";
		gctr_national.post();
		return ln_Query();
	}else gcds_national.undo(gcds_national.rowposition);		
 }
}


/******************************************************************************
	Description : �� ����
******************************************************************************/
function ln_Tabset(index){

	var div_cm=new Array("div_health","div_guarantee","div_national");

	for(var i=0;i<=2;i++){
	 
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}	else 	{
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}


/******************************************************************************
	Description : Dataset Head ���� -
  parameter   :
******************************************************************************/
function ln_SetDataHeader(){
	if(tab_gb==1){ //�ǰ�����
		if (gcds_health.countrow<1){  
		  var s_temp = "STDYM:STRING(6),EMPNO:STRING(7),EMPNMK:STRING(20),STDAMT:DECIMAL(9.0),INSAMT1:DECIMAL(9.0)";
			gcds_health.SetDataHeader(s_temp);
		}
	}else{
	if(tab_gb==2){ //��������
		if (gcds_guarantee.countrow<1){
		  var s_temp = "APPYM:STRING(6),EMPNO:STRING(7),EMPNMK:STRING(20),SUPAMT:DECIMAL(9.0),PERAMT:DECIMAL(9.0)";
			gcds_guarantee.SetDataHeader(s_temp);
		}
	}else{
	if(tab_gb==3){ //���ο���
		if (gcds_national.countrow<1){
		  var s_temp = "STDYM:STRING(6),EMPNO:STRING(7),EMPNMK:STRING(20),STDAMT:DECIMAL(9.0),PWPENB1:DECIMAL(9.0)";
			gcds_national.SetDataHeader(s_temp);
			}
		}
	}
}
}
/******************************************************************************
	Description : ����� üũ
	prameter    : 
******************************************************************************/
function ln_Chk_Save(){
		if(tab_gb==1){
			for(i=1;i<=gcds_health.countrow;i++){
			 // alert("gcds_health.SysStatus(i)::"+gcds_health.SysStatus(i));
				if(gcds_health.SysStatus(i)==1||gcds_health.SysStatus(i)==3){

				if(gcds_health.namevalue(i,"STDYM") == ""){ //�ش���				
	      	alert("�������� �Է��ϼ���.");
					return false;
					}
					if(gcds_health.namevalue(i,"EMPNO") == ""){//���
					alert("����� �Է��ϼ���.");
					return false;
					}
				}
		 }
	}

		else if(tab_gb==2){
			for(i=1;i<=gcds_guarantee.countrow;i++){
				if(gcds_guarantee.SysStatus(i)==1||gcds_guarantee.SysStatus(i)==3){
					if(gcds_guarantee.namevalue(i,"APPYM") == ""){//�ش���
					alert("�������� �Է��ϼ���.");
					return false;
					}
					if(gcds_guarantee.namevalue(i,"EMPNO") == ""){//���
					alert("����� �Է��ϼ���.");
					return false;
					}
				}
		 }
	}

		else if(tab_gb==3){
			for(i=1;i<=gcds_national.countrow;i++){
				if(gcds_national.SysStatus(i)==1||gcds_national.SysStatus(i)==3){
					if(gcds_national.namevalue(i,"STDYM") == ""){//�ش���
					alert("�������� �Է��ϼ���.");
					return false;
					}
					if(gcds_national.namevalue(i,"EMPNO") == ""){//���
					alert("����� �Է��ϼ���.");
					return false;
					}
				}
		 }
	}
		return true;
}


/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_Clear(){

		gcem_htapply.text = "";
		gcem_htempno.text = "";
		txt_empnmk_1.value = "" ;
		gcem_htpay.text = "";
		gcem_htbdg.text = "";
	
		gcem_gtapply.text = "";
		gcem_gtempno.text = "";
		txt_empnmk_2.value = "" ;
		gcem_gtpay.text = "";
		gcem_gtbdg.text = "";

		gcem_ntapply.text = "";
		gcem_ntempno.text = "";
		txt_empnmk_3.value = "" ;
		gcem_ntpay.text = "";
		gcem_ntbdg.text = "";

}

/******************************************************************************
	Description : �����ڵ� ��ȸ
******************************************************************************/

/******************************************************************************
	Description : ��������
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__"><object id="gcds_health" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="true"><!--�ǰ�����-->
		<param name=UseChangeInfo    value=true>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_guarantee" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true"><!--��������-->
	<param name=UseChangeInfo    value=true>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_national" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true"><!--���ο���-->
	<param name=UseChangeInfo    value=true>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_yymm" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true"><!--�ʱ� �ִ밪 �˻�-->
</object></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__"><OBJECT id=gctr_health classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ǰ�����-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_guarantee classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--��������-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_national classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--���ο���-->
</OBJECT></comment><script>__ws__(__NSID__);</script>



<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript  for=gcds_yymm event=OnLoadCompleted(rowcount)>	//�ǰ����� �ʱ� �ִ� ��
if(tab_gb==1) gcem_htdt.text=gcds_yymm.namevalue(gcds_yymm.rowposition,"STDYM");
if(tab_gb==2) gcem_gtdt.text=gcds_yymm.namevalue(gcds_yymm.rowposition,"STDYM");
if(tab_gb==3) gcem_ntdt.text=gcds_yymm.namevalue(gcds_yymm.rowposition,"STDYM");
</script>




<script language=JavaScript  for=gcds_health event=OnLoadCompleted(rowcount)>	//�ǰ����� �� �˻� �Ǽ�
  
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search1.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<script language=JavaScript  for=gcds_guarantee event=OnLoadCompleted(rowcount)>	//�������� �� �˻� �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search2.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>



<script language=JavaScript  for=gcds_national event=OnLoadCompleted(rowcount)>	//���ο��� �� �˻� �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search3.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>


<script language="javascript" for="gcds_health" event=OnLoadStarted()>	//�����ȣ
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>


<script language="javascript" for="gcds_guarantee" event=OnLoadStarted()>	//�����ȣ
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>


<script language="javascript" for="gcds_national" event=OnLoadStarted()>	//�����ȣ
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gs_tab event=OnSelChanged(index)>
	ln_Tabset((index-1));

	tab_gb=index;

	ln_init(tab_gb);

  ln_Clear();
  gcds_health.ClearAll();
	gcds_guarantee.ClearAll();
  gcds_national.ClearAll();
</script>


<script language="javascript"  for=gcgd_health event=OnClick(Row,Colid)>
	if(tab_gb==1){
	if(gcds_health.SysStatus(Row)==1){
		gcem_htapply.ReadOnly = false;
		gcem_htempno.ReadOnly = false;
	}else {    	
		gcem_htapply.ReadOnly = true;
		gcem_htempno.ReadOnly = true;
	}
}
</script>

<script language="javascript"  for=gcgd_guarantee event=OnClick(Row,Colid)>
	if(tab_gb==2){
	if(gcds_guarantee.SysStatus(gcds_guarantee.rowposition)==1){
		gcem_gtapply.ReadOnly = false;
		gcem_gtempno.ReadOnly = false;
	}else {    	
		gcem_gtapply.ReadOnly = true;
    gcem_gtempno.ReadOnly = true;
	}
}
</script>

<script language="javascript"  for=gcgd_national event=OnClick(Row,Colid)>
	if(tab_gb==3){
	if(gcds_national.SysStatus(gcds_national.rowposition)==1){
    gcem_ntapply.ReadOnly = false;
    gcem_ntempno.ReadOnly = false;
	}else {    	
		gcem_ntapply.ReadOnly = true;
   	gcem_ntempno.ReadOnly = true;
	}
}
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_health" event="OnSuccess()">//�ǰ�����
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_health" event="onFail()">
	alert("Error Code : " + gctr_health.ErrorCode + "\n" + "Error Message : " + gctr_health.ErrorMsg + "\n");

	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_guarantee" event="OnSuccess()">//��������
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_guarantee" event="onFail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");

	alert("Error Code : " + gctr_guarantee.ErrorCode + "\n" + "Error Message : " + gctr_guarantee.ErrorMsg + "\n");

</script>

<script language="javascript" for="gctr_national" event="OnSuccess()">//���ο���
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_national" event="onFail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");

	alert("Error Code : " + gctr_national.ErrorCode + "\n" + "Error Message : " + gctr_national.ErrorMsg + "\n");
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
   <td background="../../Common/img/com_t_bg.gif" ><img src="../img/h100011_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<nobr>
			<table>
				<tr>
						<td style="position:relative;left:-100px;"><B>File open����</td> 
            <td width="200px">
						<nobr> 
				    <input type="checkbox" id=chk_p01   value="F" style="position:relative;top:-4px;left:-90px">
			  	 	<input type="text"     id=chk_p01nm value="�̻��" style="position:relative;top:-4px;border-width:0;width:42px;left:-85px">
<!-- 			  	 	<input type="checkbox" id=chk_p02   value="T" style="position:relative;top:-4px;left:-80px;">
			  		<input type="text"     id=chk_p02nm value="���" style="position:relative;top:-4px;border-width:0;width:52px;left:-75px"> -->
            <object id=tb_InputFile classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="position:absolute;left:300;top=20; width=0; height=0;">
						<param name="Text"		value='FileOpen'>
						</object>
            <input type=button value="FileOpen" style="position:absolute;left:604;top=12;" onClick="Open_File()">
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete()">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add()">
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save()">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onClick="ln_Query()"> 
						</nobr> 
					</td>
				</tr>
			</table>
  </td>
  </tr>
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
							<T>divid=div_health  title=�ǰ�����</T>                                  
              <T>divid=div_guarantee title=��������</T>
              <T>divid=div_national  title=���ο���</T>                                
              ">
            </OBJECT></comment><script>__ws__(__NSID__);</script></NOBR>
					</td>
        </tr>
      </table>
		</td>
  </tr>

	<tr> 
    <td COLSPAN=2><div id="div_health" style="display:block">
  <table width="875" cellpadding="1" cellspacing="0" border="0"> <!--�ǰ�����-->
		<tr><td height=13></td></tr>
    <tr> 
			<td colspan=8 align=center>                       
				<table width="846" cellpadding="1" cellspacing="0" border="0" style='position:relative;top:-3px;width:846px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; �ش���&nbsp;&nbsp;</nobr></td>
						<td width="0" align=LEFT ><nobr>
							<comment id="__NSID__"><object id=gcem_htdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="1"
                style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1
                validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true> 
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM">
										<param name=MaxLength     value=6>
										<param name=PromptChar    value="_">
										<param name=IsComma   3    value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
							&nbsp;</td>
						</td>
          </tr>
        </table>
      </td>
    </tr>

    <tr><td align=center valign=middle>
      <table width="847" cellpadding="1" cellspacing="0" border="0" style='position:relative;top:-3px;'>
        <tr> 
          <td style="width:847" align=center>
            <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_health  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"        VALUE="gcds_health">
              <PARAM NAME="Editable"			VALUE="false">
              <PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM name="Fillarea"      VALUE="true">
              <PARAM NAME="Format"        VALUE="    
                <C> Name='������'	ID=STDYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=CENTER	Mask='XXXX/XX'</C> 
                <C> Name='���'			ID=EMPNO	 HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=CENTER,		sort = true</C>
								<C> Name='����'     ID=EMPNMK   HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=CENTER,		sort = true</C>
                <C> Name='��������'	ID=STDAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right,		sort = true</C>
                <C> Name='���κδ��'			ID=INSAMT1	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right,		sort = true</C>
              ">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
          </td>
          <TD align=left>
            
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;������</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_htapply classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM">
										<param name=MaxLength     value=8>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=ReadOnly      value=false> 											
										<param name=ReadOnlyBackColor   value="#CCFFCC">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;				
								</td>
              </tr>
             <tr>
							 <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td> 
               <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
				    		<comment id="__NSID__">
				    		<object id=gcem_htempno  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
								class=txtboxvalidFeatures="ignoreStatus=yes" validExp="" >
									<param name=Text          value="">
									<param name=Alignment	    value=0>
									<param name=Border	      value=True>
									<param name=Format	      value="0000000">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value=false>
									<param name=ReadOnlyBackColor   value="#CCFFCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;
						<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-3px;top:2px;" onclick="ln_Popup('1')" >
						<input id="txt_empnmk_1" type="text" class="txt21" style="position:relative;left:-5px;top:-3px;width:70px;"  ReadOnly> 
						</nobr>
						</td>
					</tr>
					<tr>
								<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >��������</td>   
               <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_htpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
								class=txtboxvalidFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
									  <param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=MaxLength     value=9>
										<param name=UpperFlag			value=1>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
              </tr>
							<tr>
								<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >���κδ��</td>   
               <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_htbdg classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
								class=txtboxvalidFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=MaxLength     value=9>
										<param name=UpperFlag			value=1>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
              </tr>
              <tr>
                <td colspan=4 style="height:100%;border:0 solid #708090;" >&nbsp;
                </td>
              </tr>
            </table>
          </TD>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=875>
	<tr><td height=10></td></tr>
	 <tr>
		<td height="24">��ȸ�Ǽ� : <label id="lbl_search1"></label></td>
	 </tr>
</table>
</div>

<div id="div_guarantee" style="display:none"> <!--�������� -->
  <table width="875" cellpadding="1" cellspacing="0" border="0">
		<tr><td height=13></td></tr>
    <tr> 
			<td colspan=8 align=center>
				<table width="846" cellpadding="1" cellspacing="0" border="0" style='position:relative;top:-3px;width:846px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; �ش���&nbsp;&nbsp;</nobr></td>
						<td width="0" align=LEFT ><nobr>
							<comment id="__NSID__"><object id=gcem_gtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="2"
                style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1
                validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true> 
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM">
										<param name=MaxLength     value=6>
										<param name=PromptChar    value="_">
										<param name=IsComma   3    value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
							&nbsp;</td>
						</td>
          </tr>
        </table>
      </td>
    </tr>

    <tr><td align=center valign=middle>
      <table width="847" cellpadding="1" cellspacing="0" border="0" style='position:relative;top:-3px;'>
        <tr> 
          <td style="width:847" align=center>
            <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_guarantee  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"        VALUE="gcds_guarantee">
              <PARAM NAME="Editable"			VALUE="false">
              <PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM name="Fillarea"      VALUE="true"> 
              <PARAM NAME="Format"        VALUE="    
                <C> Name='������'	ID=APPYM	HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=CENTER	Mask='XXXX/XX'</C> 
                <C> Name='���'			ID=EMPNO	 HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=CENTER,		sort = true</C>
								<C> Name='����'     ID=EMPNMK   HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=CENTER,		sort = true</C>
                <C> Name='��������'	ID=SUPAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=LEFT,		sort = true</C>
                <C> Name='���κδ��'		ID=PERAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT,		sort = true</C>
              ">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
          </td>
          <TD align=left>
            
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;������</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_gtapply classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="2" style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM">
										<param name=MaxLength     value=8>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=ReadOnly      value=false> 											
										<param name=ReadOnlyBackColor   value="#CCFFCC">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;				
								</td>
              </tr>
              <tr>
							 <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td> 
               <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
				    		<comment id="__NSID__">
				    		<object id=gcem_gtempno  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="2" style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
								class=txtboxvalidFeatures="ignoreStatus=yes" validExp="" >
									<param name=Text          value="">
									<param name=Alignment	    value=0>
									<param name=Border	      value=True>
									<param name=Format	      value="0000000">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value=false>
									<param name=ReadOnlyBackColor   value="#CCFFCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;
						<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-3px;top:2px;" onclick="ln_Popup('2')" >
						<input id="txt_empnmk_2" type="text" class="txt21" style="position:relative;left:-5px;top:-3px;width:70px;"  ReadOnly> 
						</nobr>
						</td>
					 </tr>
              <tr>
								<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >��������</td>   
               <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_gtpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="2"
                style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
								class=txtboxvalidFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
									  <param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=MaxLength     value=9>
										<param name=UpperFlag			value=1>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
              </tr>
							<tr>
								<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >���κδ��</td>   
               <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_gtbdg classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="2"
                style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
								class=txtboxvalidFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=MaxLength     value=9>
										<param name=UpperFlag			value=1>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
              </tr>
              <tr>
                <td colspan=4 style="height:100%;border:0 solid #708090;" >&nbsp;
                </td>
              </tr>
            </table>
          </TD>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=875>
	<tr><td height=10></td></tr>
	 <tr>
		<td height="24">��ȸ�Ǽ� : <label id="lbl_search2"></label></td>
	 </tr>
</table>
</div>

<div id="div_national" style="display:none"> <!--���ο���-->
  <table width="875" cellpadding="1" cellspacing="0" border="0">
		<tr><td height=13></td></tr>
    <tr> 
			<td colspan=8 align=center>
				<table width="846" cellpadding="1" cellspacing="0" border="0" style='position:relative;top:-3px;width:846px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; �ش���&nbsp;&nbsp;</nobr></td>
						<td width="0" align=LEFT ><nobr>
							<comment id="__NSID__"><object id=gcem_ntdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="3"
                style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1
                validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true> 
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM">
										<param name=MaxLength     value=6>
										<param name=PromptChar    value="_">
										<param name=IsComma   3    value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
							&nbsp;</td>
						</td>
          </tr>
        </table>
      </td>
    </tr>

    <tr><td align=center valign=middle>
      <table width="847" cellpadding="1" cellspacing="0" border="0" style='position:relative;top:-3px;'>
        <tr> 
          <td style="width:847" align=center>
           <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_national  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"        VALUE="gcds_national">
              <PARAM NAME="Editable"			VALUE="false">
              <PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM name="Fillarea"      VALUE="true">
              <PARAM NAME="Format"        VALUE="   
                <C> Name='������ '	ID=STDYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=CENTER	Mask='XXXX/XX'</C> 
                <C> Name='���'			  ID=EMPNO    HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=CENTER,		sort = true</C>
								<C> Name='����'       ID=EMPNMK   HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=CENTER,		sort = true</C>
                <C> Name='��������' 	ID=STDAMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=LEFT,		sort = true</C>
                <C> Name='���κδ��'	ID=PWPENB1	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT,		sort = true</C>
              ">
            </OBJECT></comment><script>__ws__(__NSID__);</script>

          </td>
          <TD align=left>
            
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;������</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_ntapply classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="3" style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM">
										<param name=MaxLength     value=8>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=ReadOnly      value=false>											
										<param name=ReadOnlyBackColor   value="#CCFFCC">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;				
								</td>
              </tr>
              <tr>
							 <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td> 
               <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
				    		<comment id="__NSID__">
				    		<object id=gcem_ntempno  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="3" style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
								class=txtboxvalidFeatures="ignoreStatus=yes" validExp="" >
									<param name=Text          value="">
									<param name=Alignment	    value=0>
									<param name=Border	      value=True>
									<param name=Format	      value="0000000">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value=false>
									<param name=ReadOnlyBackColor   value="#CCFFCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;
						<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-3px;top:2px;" onclick="ln_Popup('3')" >
						<input id="txt_empnmk_3" type="text" class="txt21" style="position:relative;left:-5px;top:-3px;width:70px;"  ReadOnly> 
						 </nobr>
						 </td>
					  </tr>							                    
					  <tr>
								<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >��������</td>   
               <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_ntpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="3"
                style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
								class=txtboxvalidFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
									  <param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=MaxLength     value=9>
										<param name=UpperFlag			value=1>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
              </tr>
							<tr>
								<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >���κδ��</td>   
               <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_ntbdg classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="3"
                style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
								class=txtboxvalidFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=MaxLength     value=9>
										<param name=UpperFlag			value=1>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
              </tr>
              <tr>
                <td colspan=4 style="height:100%;border:0 solid #708090;" >&nbsp;
                </td>
              </tr>
            </table>
          </TD>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=875>
	<tr><td height=10></td></tr>
	 <tr>
		<td height="24">��ȸ�Ǽ� : <label id="lbl_search3"></label></td>
	 </tr>
</table>
</div>
  <td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
											B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_health classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_health>
	<param name=BindInfo  value='
		<C>Col=STDYM			Ctrl=gcem_htapply      Param=text			</C>
		<C>Col=EMPNO	   	Ctrl=gcem_htempno     Param=text			</C>
		<C>Col=EMPNMK	   	Ctrl=txt_empnmk_1     Param=value			</C>
		<C>Col=STDAMT		  Ctrl=gcem_htpay        Param=text			</C>
		<C>Col=INSAMT1	  Ctrl=gcem_htbdg        Param=text			</C>
  '> 
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcbn_guarantee classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_guarantee>
	<param name=BindInfo  value='  
		<C>Col=APPYM			Ctrl=gcem_gtapply       Param=text			</C>
		<C>Col=EMPNO	   	Ctrl=gcem_gtempno       Param=text			</C>
		<C>Col=EMPNMK	   	Ctrl=txt_empnmk_2     Param=value			</C>
		<C>Col=SUPAMT	  	Ctrl=gcem_gtpay         Param=text			</C>
		<C>Col=PERAMT	  	Ctrl=gcem_gtbdg         Param=text			</C>
  '> 
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcbn_national classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_national>
	<param name=BindInfo  value='  
		<C>Col=STDYM			Ctrl=gcem_ntapply      Param=text			</C>
		<C>Col=EMPNO	   	Ctrl=gcem_ntempno      Param=text			</C>
		<C>Col=EMPNMK	   	Ctrl=txt_empnmk_3     Param=value		</C>
		<C>Col=STDAMT		  Ctrl=gcem_ntpay        Param=text			</C>
		<C>Col=PWPENB1	  Ctrl=gcem_ntbdg        Param=text			</C>
  '> 
</object></comment><script>__ws__(__NSID__);</script>


<div class=page id="out_line" style="position:absolute; left:173; top:155; width:875; height:438;z-index:-1;">&nbsp;</div>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	