<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	: ��Ÿ��ü�������
+ ���α׷� ID: a070025.jsp
+ �� �� �� ��	: ���¾�ü�������
+ ��  ��   ��  : �� �� ��
+ �� �� �� �� : 2017.11.17
-----------------------------------------------------------------------------
+ �� �� �� �� : 
+ ��   ��  ��  : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: a070025_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>��Ÿ��ü�������</title>

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
var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode= gfdcode;


<%
/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
  
	//�����ڵ�[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
	gclx_fdcode.bindcolval="02";

	gcem_actyymm.text =fnGetbyymm(gs_date2);
	gcem_actyymm_to.text =fnGetbyymm(gs_date2);		
	gcem_caldat.text = gs_date;
	gcem_paydat_fr.text = gs_date2+"01";
	gcem_paydat_to.text = gs_date;
	
	gcem_fuldat.text = "";
	
	gcrd_gubun.codevalue="1";
	gcrd_cash_bill_gb.codevalue="3";
	
	gcrd_view_gb.codevalue ="2";
	
	ln_gcrd_view_gb();
	
	ln_Button_Display();
	
	//gcds_code01.SubsumExpr = "1:VENDCD";
 }
 
 <%
 //****************************************************************************
// �������ϱ�
//****************************************************************************
%>
function fnGetbyymm(v_yyyymm) {

	var ls_yy = v_yyyymm.substring(0,4);
	var ls_mon = v_yyyymm.substring(4,6);
	var ls_bef_yyyymm="";
	var mm=0;
	
	if (ls_mon == "01") {
		ls_bef_yyyymm = parseInt(ls_yy,10)-1;
		ls_bef_yyyymm = ls_bef_yyyymm+"12";
	}else {
        mm =  parseInt(ls_mon,10)-1;
        if(mm<10){
        	ls_bef_yyyymm = ls_yy+"0"+mm;
        }else{
            ls_bef_yyyymm = ls_yy+mm;
        }
	}
	return(ls_bef_yyyymm);
}	

<%
/******************************************************************************
	Description : ������ư Display
******************************************************************************/
%>
function ln_Button_Display(){
	if(gcrd_gubun.codevalue=="1"){
		sp0.style.display = "none";
	}else if (gcrd_gubun.codevalue=="2"){
	    sp0.style.display = "";
	}
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

    //�ʼ��׸� üũ�ϱ� 
    //���� 
    if(gclx_fdcode.bindcolval==""){
    	alert("������ �Է��Ͻʽÿ�");
    	return false;
    }
    
    //ȸ����
    if(gcem_actyymm.text==""){
    	alert("ȸ������ �Է��Ͻʽÿ�");
    	return false;
    }
    
    if(gcrd_gubun.codevalue=="1"){            //������ 
    
    	//�������� üũ 
    	  if(gcem_caldat.text==""){
		    	alert("�������ڸ�  �Է��Ͻʽÿ�");
		    	return false;
		  }

        //GRID�� EDIT ǰ 
        gcgd_disp01.ColumnProp('PAYDAT', 'Edit')="Any";
        gcgd_disp01.ColumnProp('CHKCASH', 'Edit')="Any";
        gcgd_disp01.ColumnProp('CHKBILL', 'Edit')="Any";
        gcgd_disp01.ColumnProp('FULDAT', 'Edit')="Any";
    	
    	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070025_s1"
									     + "?v_str1="+gclx_fdcode.BindColVal     
									 	 + "&v_str2="+gcem_actyymm.text           
										 + "&v_str3="+gcem_actyymm_to.text
										 + "&v_str4="+gcem_caldat.text
										 + "&v_str5="+txt_vendcd.value             
		 								 + "&v_str6="+txt_vendnm.value;       	
		 // prompt('', gcds_code01.DataID);				
		gcds_code01.Reset();
	}else if (gcrd_gubun.codevalue=="2"){ //������
	
	   // �������� üũ  
    	  if(gcem_paydat_fr.text==""||gcem_paydat_to.text==""){
		    	alert("�������ڸ�  �Է��Ͻʽÿ�");
		    	return false;
		  }
		  
		//GRID�� EDIT ����   
		gcgd_disp01.ColumnProp('PAYDAT', 'Edit')="none";
        //gcgd_disp01.ColumnProp('CHKCASH', 'Edit')="none";
        //gcgd_disp01.ColumnProp('CHKBILL', 'Edit')="none";
        //gcgd_disp01.ColumnProp('FULDAT', 'Edit')="none";
		  
	    gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070025_s2"
									     + "?v_str1="+gclx_fdcode.BindColVal     
									 	 + "&v_str2="+gcem_actyymm.text           
										 + "&v_str3="+gcem_paydat_fr.text       
										 + "&v_str4="+gcem_paydat_to.text
										 + "&v_str5="+txt_vendcd.value
										 + "&v_str6="+txt_vendnm.value         
										 + "&v_str7="+gcrd_cash_bill_gb.codevalue
										 + "&v_str8="+gcem_fuldat.text
		 								 + "&v_str9="+gcem_actyymm_to.text;	    
		 // prompt('', gcds_code01.DataID);				
		 gcds_code01.Reset();
	}
}


<%
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Excel(){
    var strTitle ="���¾�ü�������";

    //gcgd_disp01.SetExcelTitle(1, "value:"+strTitle+"; font-face:��������u; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:red;line-width:2pt; skiprow:1;");
	gcgd_disp01.GridToExcel(strTitle,"",1);
}

<%
/******************************************************************************
	Description : ����  
******************************************************************************/
%>
function ln_Save(){
	if(gcds_code01.IsUpdated){
		if(ln_Chk()){
		     if(confirm("���¾�ü ������� ������  �����Ͻðڽ��ϱ�?")){
					gctr_code01.KeyValue = "Account.a070025_t1(I:USER=gcds_code01)";
					gctr_code01.Action      = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070025_t1?";
					gctr_code01.Parameters="v_str1="+gusrid+",v_str2="+gcds_code01.namevalue(1,"GUBUN");
					//prompt('',gcds_code01.text);
					gctr_code01.post();
			}
		}
	}
}



<%
/******************************************************************************
	Description : ����� üũ   
******************************************************************************/
%>
function ln_Chk(){

   // alert("üũ���� ");
   // CHK :: �߰���
   
	
	for ( var i =1;i<=gcds_code01.countrow;i++){
	
		if(gcds_code01.RowLevel(i)==0){ //������ �Ұ�ƴ�. ...
	
			//������ 
			//�ʼ��׸� üũ 
			//��������, ����, ����, �������� 
			//�����ε� �������� ������ üũ 
			
			//alert("gcrd_gubun.codevalue:::"+gcrd_gubun.codevalue);
			if(gcrd_gubun.codevalue=="1"){
		
				if(gcds_code01.namevalue(i,"CHK")=="T"){
				   
					 if(gcds_code01.namevalue(i,"GUBUN")!="A"){
							alert("������ �����Ͱ� �ƴմϴ�. Ȯ�� �Ͻʽÿ�. ");
							return false;
					 }
					
					if(gcds_code01.namevalue(i,"PAYDAT")==""){
						alert( i+"���� �������ڸ� �Է� �Ͻʽÿ�. ");
						return false;
					}
					
					if(gcds_code01.namevalue(i,"CHKCASH")==""||gcds_code01.namevalue(i,"CHKCASH")=="F"){
						if(gcds_code01.namevalue(i,"CHKBILL")==""||gcds_code01.namevalue(i,"CHKBILL")=="F"){
							alert( i+"���� ���� �Ǵ� ������ üũ�Ͻʽÿ�. ");
							return false;
						}			
					}
					
					if(gcds_code01.namevalue(i,"CHKCASH")=="T"&&gcds_code01.namevalue(i,"CHKBILL")=="T"){
						alert( i+"���� ���ݰ�  ������ ��� üũ �Ǿ����ϴ�. Ȯ���Ͻʽÿ�. ");
						return false;
					}
					
					
					//������ �����͸� ������ ��� �������ڴ�  üũ ���� ����. 
					/** 
					if(gcds_code01.namevalue(i,"CHKBILL")=="T"){
						if(gcds_code01.namevalue(i,"FULDAT")==""){
							alert( i+"���� ������ ��� �������ڸ� �Է��Ͻʽÿ�. ");
							return false;
						}
					}
					**/
					
					if(gcds_code01.namevalue(i,"CHKCASH")=="T"){
						if(gcds_code01.namevalue(i,"FULDAT")!=""){
							alert( i+"���� ������ ��� �������ڰ� �������� �ʾƿ� �մϴ�. ");
							return false;
						}
					}
				}else{
					gcds_code01.Undo(i);
				}
			}
			
			//������ 
			//���� ��ư�� ȭ�鿡�� ���� ǥ�� �� ���� 
			if(gcrd_gubun.codevalue=="2"){
			
				if(gcds_code01.namevalue(i,"CHK")=="T"){
				    if(gcds_code01.namevalue(i,"GUBUN")!="B"){
						alert("������  �����Ͱ� �ƴմϴ�. Ȯ�� �Ͻʽÿ�. ");
						return false;
				    }			
				    
				    if(gcds_code01.namevalue(i,"CHKCASH")==""||gcds_code01.namevalue(i,"CHKCASH")=="F"){
						if(gcds_code01.namevalue(i,"CHKBILL")==""||gcds_code01.namevalue(i,"CHKBILL")=="F"){
							alert( i+"���� ���� �Ǵ� ������ üũ�Ͻʽÿ�. ");
							return false;
						}			
					}
					
					if(gcds_code01.namevalue(i,"CHKCASH")=="T"&&gcds_code01.namevalue(i,"CHKBILL")=="T"){
						alert( i+"���� ���ݰ�  ������ ��� üũ �Ǿ����ϴ�. Ȯ���Ͻʽÿ�. ");
						return false;
					}
				    
				    //�������� üũ 
				    if(gcds_code01.namevalue(i,"CHKBILL")=="T"){
						if(gcds_code01.namevalue(i,"FULDAT")==""){
							alert( i+"���� ������ ��� �������ڸ� �Է��Ͻʽÿ�. ");
							return false;
						}
					}
					
					if(gcds_code01.namevalue(i,"CHKCASH")=="T"){
						if(gcds_code01.namevalue(i,"FULDAT")!=""){
							alert( i+"���� ������ ��� �������ڰ� �������� �ʾƿ� �մϴ�. ");
							return false;
						}
					}
				}else{
					gcds_code01.Undo(i);
				}
			}
		}//RowLevel
    }//for
	return true;
}

<%
/******************************************************************************
	Description : ����  
******************************************************************************/
%>
function ln_Delete(){
	
	//���� üũ 
	if(gcds_code01.namevalue(1,"GUBUN")!="B"){
		alert("���� �ĸ� ���� �����մϴ�.");
		return false;
	}
		
	if(gcds_code01.RowLevel(gcds_code01.rowposition)!=0){ 
		alert(gcds_code01.rowposition+ " ���� ���� ���ɰ��� �ƴմϴ�.");
		return false;
	}
	
	gcds_code01.DeleteRow(gcds_code01.rowposition);

	if(gcds_code01.IsUpdated){
		if(confirm(" ���� �Ͻðڽ��ϱ�?")){
			gctr_code01.KeyValue   =  "Account.a070025_t1(I:USER=gcds_code01)";
			gctr_code01.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070025_t1?";
			//prompt('',gcds_code01.text);
			gctr_code01.post();
		}
	}
}


<%
/******************************************************************************
	Description : �������� �ϰ�����   
******************************************************************************/
%>
function ln_ChgDate_Batch(){
   
    //���������� üũ 
    //���� üũ 
	if(gcds_code01.namevalue(1,"GUBUN")!="A"){
		alert("���� �������� �������� �ϰ� ���� �����մϴ�.");
		return false;
	}
   
	if(gcem_paydat_0.text==""){
		gcem_paydat_0.focus();
		alert("������ �������ڸ� �Է��Ͻʽÿ�");
		return;
	}
	
	//alert(":::::::::::::::"+gcem_paydat_0.text+"::::::::::::::::::::::"+gcem_paydat_0.text.length);
	
	var str = gcem_paydat_0.text;
	str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
	gcem_paydat_0.text = str;
	
	if(gcem_paydat_0.text.length!=8){
		gcem_paydat_0.focus();
		alert("������ �������ڸ� Ȯ���Ͻʽÿ�");
		return;
	}
		
	
	for (var i=1;i<=gcds_code01.countrow;i++){
		//������ ���������� üũ 
		//if(gcds_code01){	
		//}
		
		gcds_code01.namevalue(i,"PAYDAT") = gcem_paydat_0.text;
	
	}
}


<%
/******************************************************************************
	Description : ���ݾ������� 
******************************************************************************/
%>
function ln_CashBill_Sel(row, colid){
	if(colid == "CHKCASH"){
	    gcds_code01.namevalue(row, "CHKCASH") ="T";
		gcds_code01.namevalue(row, "CHKBILL") ="F";
	}else if(colid == "CHKBILL"){
	    gcds_code01.namevalue(row, "CHKBILL") ="T";
		gcds_code01.namevalue(row, "CHKCASH") ="F";
	}
}

<%
/******************************************************************************
	Description : �ŷ�ó 
******************************************************************************/
%>
function ln_Popup_Vendcd(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]="";
	arrParam[1]=txt_vendnm.value;
	
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		 arrParam = arrResult.split(";");
		 txt_vendcd.value = arrParam[0];
		 txt_vendnm.value = arrParam[1];
	} else {
		 txt_vendcd.value = "";
		 txt_vendnm.value = "";
    }
}


function ln_gcrd_view_gb(){
	if(gcrd_view_gb.CodeValue=="1"){
		gcds_code01.SubsumExpr = "1:VENDCD";
	}else if(gcrd_view_gb.CodeValue=="2"){
	    gcds_code01.SubsumExpr = "";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!-- ������� -->
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>



<!-- ���� -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a0900033_t1(I:USER=gcds_code01)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
  
    ft_cnt01.innerText = "��ȸ�Ǽ� : " + gcds_code01.RealCount(1,row) + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_code01.countrow<=0)
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>


<!-- �����з� (�˻�)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
   /*
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	gclx_fdcode.index=0;
	*/
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcrd_gubun  event=OnSelChange()>
	ln_Button_Display();
</script>


<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>

     if(gcds_code01.namevalue(1,"GUBUN")=="A"){
	    if(row>0){
	    	ln_CashBill_Sel(row,colid);
	    }else if (row==0){
	    	if(colid=="CHKCASH"){
	    		for(var i=1;i<=gcds_code01.countrow;i++){
	    			 gcds_code01.namevalue(i, "CHKBILL") ="F";
					 gcds_code01.namevalue(i, "CHKCASH") ="T";
	    		}
	        }else if(colid=="CHKBILL"){
	        	for(var i=1;i<=gcds_code01.countrow;i++){
	    			 gcds_code01.namevalue(i, "CHKBILL") ="T";
					 gcds_code01.namevalue(i, "CHKCASH") ="F";
	    		}
	        }
	    }
	 }
    
    

 </script>


<script language=JavaScript for=gcgd_disp01 event=onKeyPress(keycode)>

    /**
    alert("gcds_code01.Countindex:"+gcds_code01.Countindex);
    alert(gcds_code01.ColumnInex(gcds_code01.Countindex) );

	if(keycode==32) { //�����̽��� 
		var row = gcds_code01.rowposition;
		//var colid = gcds_code01.rowposition  
		//ln_CashBill_Sel(row);
	}
	**/
 </script>
 

<script language=JavaScript for=gcrd_view_gb event=OnSelChange()>

		ln_gcrd_view_gb();
		
</script>

<script language=JavaScript for=gcrd_cash_bill_gb event=OnSelChange()>

		if(gcrd_cash_bill_gb.CodeValue=="1"){
			gcem_fuldat.text = "";
		}
		
</script>



 
<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
    alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif" height="40px" align=left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		    <img src="../../Common/img/btn/com_b_excel.gif"	   style="cursor:hand;" onclick="ln_Excel()"> 
		    <img src="../../Common/img/btn/com_b_save.gif"	   style="cursor:hand"  onClick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"	   style="cursor:hand"  onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  class="tab25" bgcolor="#eeeeee" align=center>����</td>
		<td width="160px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID		 value="gcds_fdcode">
				<param name=CBDataColumns	 value="FDCODE, FDNAME">
				<param name=SearchColumn	 value=FDNAME>
				<param name=ListExprFormat	 value="FDNAME^0^120">
				<param name=BindColumn		 value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center> ȸ����</td>  
	    <td width="250px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object id=gcem_actyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
				<param name=Text		   value="">
				<param name=Alignment      value=0>
				<param name=Border         value=true>
				<param name=Format         value="YYYY/MM">
				<param name=PromptChar     value="_">
				<param name=BackColor      value="#CCCCCC">
				<param name=InheritColor   value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_actyymm', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
			~
			<comment id="__NSID__">
			<object id=gcem_actyymm_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
				<param name=Text			value="">
				<param name=Alignment       value=0>
				<param name=Border          value=true>
				<param name=Format          value="YYYY/MM">
				<param name=PromptChar      value="_">
				<param name=BackColor       value="#CCCCCC">
				<param name=InheritColor    value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_actyymm_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  

		</td>
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>�ŷ�ó</td> 
		<td class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vendnm" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:120px;height:20px;" maxlength="36" >
			<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd();">
			<input id="txt_vendcd" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
			</comment><script>__ws__(__NSID__);</script>
			
		</td>
	</tr>
	
	<tr> 
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >����</td>
		<td class="tab28"  >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:120">
					<param name=Cols	    value="2">
					<param name=Format	value="1^������ ,2^��">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center >��������</td>
		<td class="tab28"  >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_caldat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	      value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_caldat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td> 
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>��������</td> 
		<td class="tab28" >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_paydat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	      value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_paydat_fr', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">~
			<comment id="__NSID__">
			<OBJECT id=gcem_paydat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		 value=0>
			<param name=Border	         value=true>
			<param name=Format	         value="YYYY/MM/DD">
			<param name=PromptChar	 value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_paydat_to', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
			<span id=sp0 style="display:none;">
				<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:2px;left:90px;>"       onClick="ln_Delete()">
			</span>
		</td>
	</tr>
	<tr> 
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >���ޱ���</td>
		<td class="tab28"   >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_cash_bill_gb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:140">
					<param name=Cols	    value="3">
					<param name=Format	    value="1^����,2^����,3^��ü">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center >������������</td>
		<td class="tab28"  >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_fuldat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	      value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fuldat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center >SubSum View </td>
		<td class="tab28"   >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_view_gb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:180">
					<param name=Cols	    value="2">
					<param name=Format	    value="1^Display,2^NonDisplay">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	
	<tr>
		<td colspan =8  align="right">
			 <font style="position:relative;top:-4px;left:0px">�ϰ����� ��������</font>&nbsp;
				 <comment id="__NSID__">&nbsp;
				 <object id=gcem_paydat_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">		
				 <param name=Text				 value="">
				 <param name=Alignment       value=0>
				 <param name=Border          value=true>
				 <param name=Format          value="YYYY/MM/DD">
				 <param name=BackColor       value="#CCCCCC">
				 <param name=InheritColor    value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
			  <img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_paydat_0', 'Text')" style="position:relative;width:20px;left:0px;cursor:hand;">
			 <img src="../../Common/img/btn/com_b_total.gif"		style="cursor:hand;position:relative;top:2px;left:0px" onClick="ln_ChgDate_Batch()">
		</td>
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			  style="position:relative;left:0px;width:998px; height:450px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		  value='0'>
					<param name="BorderStyle"     value="0">
					<param name="Fillarea"		  value="true">
					<param name="Sortview"		  value="false">
					<param name="ColSizing"	      value="true">
					<param name="Editable"		  value="true"> 
					<param name=TitleHeight       value="20">
					<param name=UsingOneClick     value="1">
					<param name=ViewSummary       value="1">
					<param name="Format"		  value=" 			
					<C> Name='LV'			      	ID=CurLevel			HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center   SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  Value={CurLevel} show=false</C>
					<C> Name='����'          	  	ID=CHK      	    HeadAlign=Center HeadBgColor=#B9D4DC Width=28   align=center   SumBgColor=#C3D0DB sumtext=''      sort=true    EditStyle=CheckBox   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='����'			      	ID=Currow		    HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center   SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  Value={CurRow}  BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}   </C>
					<C> Name='����'			      	ID=GUBUN		    HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center   SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  show=false</C>
					<C> Name='�����ڵ�'			  	ID=ATCODE		    HeadAlign=Center HeadBgColor=#B9D4DC Width=53 	align=center   SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  show=false</C>
					<C> Name='������' 			  	ID=ATKORNAM		    HeadAlign=Center HeadBgColor=#B9D4DC Width=65 	align=left     SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  show=false </C>
					<C> Name='�ŷ�ó'	                ID=VENDCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center   SumBgColor=#C3D0DB sumtext=''      sort=true    edit=none   SumTextAlign=center  Value={Decode(CurLevel,2,'',0,VENDCD)}  BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))} Color={Decode(CREDGB,1,'red',2,'red','black')}  </C>
					<C> Name='�ŷ�ó��'			  	ID=VENDNM		    HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=left     SumBgColor=#C3D0DB sumtext=''      sort=true     edit=none  BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}  Color={Decode(CREDGB,1,'red',2,'red','black')} </C>
					<C> Name='���ޱݾ�'               ID=JANAMT      	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90   align=right	   SumBgColor=#C3D0DB sumtext='@sum'  sort=true    edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}  Color={Decode(CREDGB,1,'red',2,'red','black')}  </C>
					<C> Name='ȸ������'	          	ID=ACTDAT			HeadAlign=Center HeadBgColor=#B9D4DC Width=69 	align=center   SumBgColor=#C3D0DB sumtext=''   edit=none   MASK='XXXX/XX/XX'  BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='���ݰ�꼭'     		    ID=TAXDAT			HeadAlign=Center HeadBgColor=#B9D4DC Width=69	align=center   SumBgColor=#C3D0DB sumtext=''   edit=none   MASK='XXXX/XX/XX'  BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='��������'               ID=PAYDAT			HeadAlign=Center HeadBgColor=#B9D4DC Width=69	align=center   SumBgColor=#C3D0DB sumtext=''   MASK='XXXX/XX/XX'      HeadCheck=true   HeadCheckShow=true     BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='����'	        	  	ID=REMARK   		HeadAlign=Center HeadBgColor=#B9D4DC Width=280  align=left     SumBgColor=#C3D0DB sumtext=''   sort=true    BgColor={IF(CurLevel=1, '#5FB404', IF(FSLOCK='T','YELLOW', '#FAFAFA'))} Color={Decode(CREDGB,1,'red',2,'red','black')} </C>
					<C> Name='����'          	  	ID=CHKCASH    	    HeadAlign=Center HeadBgColor=#B9D4DC Width=28   align=center   SumBgColor=#C3D0DB sumtext=''   sort=true   EditStyle=CheckBox   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='����'          	  	ID=CHKBILL      	HeadAlign=Center HeadBgColor=#B9D4DC Width=28   align=center   SumBgColor=#C3D0DB sumtext=''   sort=true   EditStyle=CheckBox   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='��������'		      	ID=FULDAT     		HeadAlign=Center HeadBgColor=#B9D4DC Width=69   align=center   SumBgColor=#C3D0DB sumtext=''   sort=true   MASK='XXXX/XX/XX'    BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='��������'			  	ID=FSDAT 			HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))} show=false</C>
					<C> Name='������ȣ'			  	ID=FSNBR			HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))} show=false</C>
					<C> Name='����'		    	  	ID=FSSTAT           HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   EditStyle=Combo Data='Y:����Ϸ�,R:�����û,N:������,C:�������,B:�ݼ�' BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))} show=false</C>
					<C> Name='�����'		        	ID=EMPNMK           HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='���'		        	ID=FSLOCK           HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='�����ǥ����'		    ID=SSDAT            HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='�����ǥ��ȣ'		    ID=SSNBR            HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 