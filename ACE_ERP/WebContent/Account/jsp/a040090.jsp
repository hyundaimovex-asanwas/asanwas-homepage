<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �о翬��   
+ ���α׷� ID: a040090.jsp
+ �� �� �� ��	: �ŷ�ó �ϰ���� 
+ �� �� �� ��	: 2013.05.06 
+ �� �� �� ��	: 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ �� �� �� ��  :
+ ��   ��  ��  : 
+ �� �� �� ��  :
-----------------------------------------------------------------------------
+ �� �� �� ��	: a040090_s1, a040090_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

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

var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_gubun=""; //chk �� click����



/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    
    gclx_ingb_0.bindcolval ="0";
    gclx_seqno_0.bindcolval="0";
    gclx_regsts_0.bindcolval="0";
   
    
    //txt_empno.value =gusrid;
	//txt_empnmk.value = gusrnm;
  
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040090_s1?v_str1="+gclx_ingb_0.bindcolval
	                                                                                                                              +"&v_str2="+gclx_seqno_0.bindcolval
	                                                                                                                              +"&v_str3="+gclx_regsts_0.bindcolval;
	                                                                                                                               	                                                                                                                                                                                                                                           
   // prompt('',gcds_data.DataID);
	gcds_data.Reset();
}

/******************************************************************************
	Description : �̰� ��� ����
******************************************************************************/
function ln_Save(){

   gcds_data2.clearall();
   ln_SetDataHeader();
     
   //���°� ���� 
   for(var i =1; i<=gcds_data.countrow; i++){
   	 	if (gcds_data.namevalue(i,"CHK")=="T"&&gcds_data.namevalue(i,"VEND_STS")=="N"){ //�̵�ϰ�
   	 	    gcds_data2.addrow();
   	 	    gcds_data2.namevalue(gcds_data2.rowposition,"BS_ID")= gcds_data.namevalue(i,"BS_ID");
			gcds_data2.namevalue(gcds_data2.rowposition,"VEND_ID")= gcds_data.namevalue(i,"VEND_ID");
			gcds_data2.namevalue(gcds_data2.rowposition,"VEND_CD")= gcds_data.namevalue(i,"VEND_CD");
			gcds_data2.namevalue(gcds_data2.rowposition,"VEND_NM")= gcds_data.namevalue(i,"VEND_NM");
			gcds_data2.namevalue(gcds_data2.rowposition,"VD_DIRECT")= gcds_data.namevalue(i,"VD_DIRECT");
			gcds_data2.namevalue(gcds_data2.rowposition,"BSNS_CND")= gcds_data.namevalue(i,"BSNS_CND");
			gcds_data2.namevalue(gcds_data2.rowposition,"BSNS_KND")= gcds_data.namevalue(i,"BSNS_KND");
			gcds_data2.namevalue(gcds_data2.rowposition,"VD_TELNO")= gcds_data.namevalue(i,"VD_TELNO");
			gcds_data2.namevalue(gcds_data2.rowposition,"VD_FAXNO")= gcds_data.namevalue(i,"VD_FAXNO");
			gcds_data2.namevalue(gcds_data2.rowposition,"POST_NO1")= gcds_data.namevalue(i,"POST_NO1");
			gcds_data2.namevalue(gcds_data2.rowposition,"POST_NO2")= gcds_data.namevalue(i,"POST_NO2");
			gcds_data2.namevalue(gcds_data2.rowposition,"ADDRESS1")= gcds_data.namevalue(i,"ADDRESS1");
			gcds_data2.namevalue(gcds_data2.rowposition,"ADDRESS2")= gcds_data.namevalue(i,"ADDRESS2");
			gcds_data2.namevalue(gcds_data2.rowposition,"COCOMYN")= gcds_data.namevalue(i,"COCOMYN");
			gcds_data2.namevalue(gcds_data2.rowposition,"USE_TAG")= gcds_data.namevalue(i,"USE_TAG");
			gcds_data2.namevalue(gcds_data2.rowposition,"WRID")= gcds_data.namevalue(i,"WRID");
			gcds_data2.namevalue(gcds_data2.rowposition,"WRDT")= gcds_data.namevalue(i,"WRDT");
   	 	}
   }
   
	if(!ln_Chk_Save())return;
	//else if (gcds_data.IsUpdated) {
	   // if(!ln_Chk_Save_Status())return;
	   

	   if(gcds_data2.isupdated){
	
			if (confirm("�ش� �ŷ�ó�� ����Ͻðڽ��ϱ�?")){	
				gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040090_t1";
				gctr_pyo.Parameters = "v_str1="+gs_userid;
				
				//prompt(this, gcds_data2.text);
				gctr_pyo.post();
				
			}	
	  }
}

/******************************************************************************
	Description : �Է°� üũ
	//���°��� ����� ��츸 ���� ���� 
	//����ڹ�ȣ �� �ֹι�ȣ üũ�ؾ��ұ�????
******************************************************************************/
function ln_Chk_Save() {

  var strVendid="";
  var intVendid_length=0;
  var strVendid_chk="";
  

  //���°��� ��� �ϰ�츸 ���� 
  //prompt(this, gcds_data2.text);
   for(i=1;i<=gcds_data2.countrow;i++){
   		if(gcds_data.SysStatus(i)=="1"||gcds_data.SysStatus(i)=="3"){
   			if(gcds_data2.namevalue(i,"VEND_ID") == ""){//����ڵ�Ϲ�ȣ
				alert(i+" ���� ��Ϲ�ȣ�� �Է��ϼ���.");
				return false;
			}else{
			    strVendid = gcds_data2.namevalue(i,"VEND_ID");
			    //alert("strVendid.length::"+strVendid.length);
				//����� ��Ϲ�ȣ �Ǵ� �ֹι�ȣ üũ 
				if (strVendid.length==10){          //����� ��Ϲ�ȣ
					if(!fnWkresino(i,strVendid)) return false;
				}else if(strVendid.length==13){  //�ֹι�ȣ üũ 
				    strVendid_chk = strVendid.substring(6,7);
				    //alert("strVendid_chk::"+strVendid_chk);
				    if (strVendid_chk=="1"||strVendid_chk=="2"||strVendid_chk=="3"||strVendid_chk=="4"){
				    	 if(!fnResino(i, strVendid)) return false;
				    }else if (strVendid_chk=="5"||strVendid_chk=="6"||strVendid_chk=="7"||strVendid_chk=="8"){
				         if(!fnFgResino(i, strVendid)) return false;
				    }
				}else{
				
				}
			}
			
			if(gcds_data2.namevalue(i,"VEND_NM") == ""){//�ŷ�ó��
				alert(i+" ���� ���ü���� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data2.namevalue(i,"VD_DIRECT") == ""){//��ǥ�ڸ�
				alert(i+" ���� ��ǥ�ڸ��� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data2.namevalue(i,"BSNS_CND") == ""){//����
				alert(i+" ���� ���¸� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data2.namevalue(i,"BSNS_KND") == ""){//����
				alert(i+" ���� ������ �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data2.namevalue(i,"BSNS_KND") == ""){//����
				alert(i+" ���� ������ �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data2.namevalue(i,"ADDRESS1") == ""){//�ּ�
				alert(i+" ���� �ּҸ� �� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data2.namevalue(i,"COCOMYN") == ""){//��ü����
				alert(i+" ���� ��ü������ �Է��ϼ���.");
				return false;
			}
			
		}
   }
   
   return true;
}




/******************************************************************************
	Description : ���°� üũ 
******************************************************************************/
function ln_Chk_Save_Status(){
   /**
	for(var i =1; i<=gcds_data.countrow;i++){
		//alert("gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i));
		if(gcds_data.SysStatus(i)==3){
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				alert(gcds_data.namevalue(i,"VEND_NM")+"�� ���� ���ɰ��� �ƴմϴ�.");
				return false;
			}
		}
	}

	return true;
	**/
}




/******************************************************************************
	Description : ���°� üũ 
******************************************************************************/
function ln_Chk_Status(){
/**
    var vcnt=0;
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				alert(gcds_data.namevalue(i,"VEND_NM")+"�� ��û ���ɰ��� �ƴմϴ�.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="R"; 
			}
			
			vcnt+=1;
		}
	}
	
	if (vcnt==0){
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		return false;
	}
	return true;
	**/
}





<%
/***********************************************************************************************
	Description : ������ ���� 
	parameter   :
**********************************************************************************************/
%>
function fnDataCopy(intRow){

	if (intRow ==0){
		for (var i=1;i<=gcds_data.countrow;i++){
			if(gcds_data.namevalue(i,"CHK")=="T"){
				gcds_data.namevalue(i,"VEND_ID")=gcds_data.namevalue(i,"BS_VENDID"); 	
				gcds_data.namevalue(i,"VEND_NM")=gcds_data.namevalue(i,"BS_VENDNM"); 	
				gcds_data.namevalue(i,"VD_DIRECT")=gcds_data.namevalue(i,"BS_DIRCNM"); 	
				gcds_data.namevalue(i,"BSNS_CND")=gcds_data.namevalue(i,"BS_CND"); 	
				gcds_data.namevalue(i,"BSNS_KND")=gcds_data.namevalue(i,"BS_KND"); 	
				gcds_data.namevalue(i,"VD_TELNO")=gcds_data.namevalue(i,"BS_TELNO"); 	
				gcds_data.namevalue(i,"POST_NO1")=gcds_data.namevalue(i,"BS_PNO1"); 	
				gcds_data.namevalue(i,"POST_NO2")=gcds_data.namevalue(i,"BS_PNO2"); 	
				gcds_data.namevalue(i,"ADDRESS1")=gcds_data.namevalue(i,"BS_ADDR1"); 	
				gcds_data.namevalue(i,"ADDRESS2")=gcds_data.namevalue(i,"BS_ADDR2"); 	
				gcds_data.namevalue(i,"COCOMYN")=gcds_data.namevalue(i,"BS_COMYN"); 	
				gcds_data.namevalue(i,"USE_TAG")=gcds_data.namevalue(i,"BS_USE"); 	
			}
		}
	}else{
		if(gcds_data.namevalue(intRow,"CHK")=="T"){
				gcds_data.namevalue(intRow,"VEND_ID")=gcds_data.namevalue(intRow,"BS_VENDID"); 	
				gcds_data.namevalue(intRow,"VEND_NM")=gcds_data.namevalue(intRow,"BS_VENDNM"); 	
				gcds_data.namevalue(intRow,"VD_DIRECT")=gcds_data.namevalue(intRow,"BS_DIRCNM"); 	
				gcds_data.namevalue(intRow,"BSNS_CND")=gcds_data.namevalue(intRow,"BS_CND"); 	
				gcds_data.namevalue(intRow,"BSNS_KND")=gcds_data.namevalue(intRow,"BS_KND"); 	
				gcds_data.namevalue(intRow,"VD_TELNO")=gcds_data.namevalue(intRow,"BS_TELNO"); 	
				gcds_data.namevalue(intRow,"POST_NO1")=gcds_data.namevalue(intRow,"BS_PNO1"); 	
				gcds_data.namevalue(intRow,"POST_NO2")=gcds_data.namevalue(intRow,"BS_PNO2"); 	
				gcds_data.namevalue(intRow,"ADDRESS1")=gcds_data.namevalue(intRow,"BS_ADDR1"); 	
				gcds_data.namevalue(intRow,"ADDRESS2")=gcds_data.namevalue(intRow,"BS_ADDR2"); 	
				gcds_data.namevalue(intRow,"COCOMYN")=gcds_data.namevalue(intRow,"BS_COMYN"); 	
				gcds_data.namevalue(intRow,"USE_TAG")=gcds_data.namevalue(intRow,"BS_USE"); 	
		}
	}
}



<%
/******************************************************************************************
	Descrition : ����ڹ�ȣ üũ
	parameter  : ����ڹ�ȣ
	retun      : true - ���� , false - �Ұ���
******************************************************************************************/
%>
function fnWkresino(irow, p) {
	var int_val=0;
	var int_getpam =new Array(10);
	var int_chkval =new Array("1","3","7","1","3","7","1","3","5");
	var int_result=0;
	var int_chk=0;
	var i=0;
	var j=0;

	for (i=0;i<10;i++){int_getpam[i]= p.substring(i,i+1);} 
	for (j=0;j<9;j++){ int_val += int_getpam[j]*int_chkval[j];} 

	int_val=int_val + Math.floor((int_getpam[8]*5)/10);
	int_result = int_val%10; 

	if(int_result==0){ int_chk = 0;}
	else{ int_chk = 10 - int_result;}

	if(int_chk!= int_getpam[9]){
		alert(irow+" ���� "+"����ڵ�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�.");
		return false;
	}else{
		return true;
	}
}

<%
/******************************************************************************************
		Descrition :  ������ �ֹι�ȣ üũ
		parameter  : �ֹι�ȣ
		retun      : true - ���� , false - �Ұ���
******************************************************************************************/
%>

function fnResino(irow, p) {
	var jumin=p;
	var vindex="234567892345";
	var total=0;

	for(var i=0;i<12;i++) total+=parseInt(jumin.charAt(i)*vindex.charAt(i));

	total=11-total%11;
	if(total==10)	total=0;
	else if(total==11) total=1;

	if(total!=jumin.charAt(12)){
		alert(irow+" ���� "+"�ֹε�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�000.");
		return false;
	}

	return true;
}

<%
/******************************************************************************************
		Descrition : �ֹι�ȣ üũ (�ܱ���)
		parameter  : �ֹι�ȣ
		retun      : true - ���� , false - �Ұ���
******************************************************************************************/
%>
function fnFgResino(irow,fgnno) {  
	var sum=0;  
	var odd=0;  
	buf = new Array(13);  
	for(i=0; i<13; i++) { 
		buf[i]=parseInt(fgnno.charAt(i)); 
	}  
	
	odd = buf[7]*10 + buf[8];  
	
	if(odd%2 != 0) { 
		alert(irow+" ���� "+"�ܱ��� �ֹε�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�0.");
		return false;
	}
	
	if( (buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9) ) {   
		alert(irow+" ���� "+"�ܱ��� �ֹε�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�00.");
		return false;  
	}  
	
	multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];  
	
	for(i=0, sum=0; i<12; i++) { sum += (buf[i] *= multipliers[i]); }  
	
	sum = 11 - (sum%11);  
	
	if(sum >= 10) { sum -= 10; }  
	
	sum += 2;  
	
	if(sum >= 10) { sum -= 10; }  
	
	if(sum != buf[12]) { 
	    alert(irow+" ���� "+"�ܱ��� �ֹε�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�000.");	
		return false; 
	}  
	
	return true; 
}



<%
/******************************************************************************************
		Descrition : ����ڹ�ȣ �ߺ� üũ 
******************************************************************************************/
%>
function ln_Vendid_Chk(irow){

	for(var i = 1; i<=irow;i++){
		if (i>1){
			if(gcds_data.namevalue(i-1,"BS_VENDID")==gcds_data.namevalue(i,"BS_VENDID")){
				gcds_data.namevalue(i,"VEND_STS") = "Y";
			}
		}
	}
}

function ln_SetDataHeader(){

       var s_temp = "BS_ID:DECIMAL,VEND_ID:STRING,VEND_CD:STRING,VEND_NM:STRING,VD_DIRECT:STRING,"  
                         + "BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,POST_NO1:STRING,"   
                         + "POST_NO2:STRING,ADDRESS1:STRING,ADDRESS2:STRING,COCOMYN:STRING,USE_TAG:STRING,"        
                         + "WRID:STRING,WRDT:STRING";    
       gcds_data2.SetDataHeader(s_temp);
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue"  VALUE="a040090_t1(I:USER=gcds_data2)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	ln_Query();
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//�� ��ȸ �Ǽ�
    
    ln_Vendid_Chk(rowcount);

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
//		ln_Query();
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcgd_pyo event=OnClick(row,colid)>

	if((row==0) && (colid=="CHK")){
		if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;
	

        for(i=1;i<=gcds_data.countrow;i++){
            if(gs_gubun=="1"||gs_gubun==""){
	        	if(gcds_data.namevalue(i,"VEND_STS")=="N"||gcds_data.namevalue(i,"VEND_STS")=="Y"&&gcds_data.namevalue(i,"VEND_UPT")=="U"){
		        	gcds_data.namevalue(i,"CHK")="T";	        
		        	fnDataCopy(i); 		
	        	}
            }else{
            	if(gcds_data.namevalue(i,"VEND_STS")=="N"||gcds_data.namevalue(i,"VEND_STS")=="Y"&&gcds_data.namevalue(i,"VEND_UPT")=="U"){
		        	gcds_data.namevalue(i,"CHK")="F";	   
		        	gcds_data.undo(i);  
	        	}
            }	
		}

   }else if((row!=0) && (colid=="CHK")){
   	     if(gcds_data.namevalue(row,"VEND_STS")=="N"||gcds_data.namevalue(row,"VEND_STS")=="Y"&&gcds_data.namevalue(row,"VEND_UPT")=="U"){
		    if(gcds_data.namevalue(row,"CHK")=="T"){
		 			fnDataCopy(row);
		 	}else{
		 	        if(gcds_data.namevalue(row,"VEND_STS")!="Y"){
		 	        	gcds_data.undo(row);
		 	        }
		 	}
		 }else{
		    if(gcds_data.namevalue(row,"VEND_STS")!="Y"){
		 		gcds_data.undo(row);
		 	}
		 }
   }
   
</script>


<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

</script>

<script language=JavaScript for=gcgd_pyo event=onKeyPress(keycode)>

    if(gcds_data.namevalue(gcds_data.rowposition,"VEND_STS")=="N"||gcds_data.namevalue(gcds_data.rowposition,"VEND_STS")=="Y"&&gcds_data.namevalue(gcds_data.rowposition,"VEND_UPT")=="U"){
	    if(gcds_data.namevalue(gcds_data.rowposition,"CHK")=="T"){
	 			fnDataCopy(gcds_data.rowposition);
	 	}else{
	 	        gcds_data.undo(gcds_data.rowposition);
	 	}
	 }else{
	 	gcds_data.undo(gcds_data.rowposition);
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
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a040090_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">   
        	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		    style="cursor:hand" onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td class="tab15" width="100px;" bgcolor="#eeeeee" align="center">�Աݱ���</td>
			<td width="190px" class="tab18" align="left"><comment id="__NSID__">
			<object id=gclx_ingb_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
						<param name=CBData			         value="0^��ü,1^����,2^�ߵ���1�� ,3^�ߵ���2�� ,4^�ߵ���3�� ,5^�ߵ���4�� ,6^�ܱ�">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			             value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">ȸ��</td>
			<td width="190px" class="tab24" align="left" ><comment id="__NSID__">
				<object id=gclx_seqno_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
						<param name=CBData			         value="0^��ü,1^1ȸ,2^2ȸ,3^3ȸ,4^4ȸ,5^5ȸ">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			             value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">��ϱ���</td>
			<td class="tab14"  align="left">
			<comment id="__NSID__">
			<object id=gclx_regsts_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-35px;top:0px;font-size:12px;width:100px;">
						<param name=CBData			         value="0^��ü,1^�̵��,2^���">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			             value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object>
			
			</comment><script>__ws__(__NSID__);</script>
		</td> 	 
			
		</tr>
	</table>

	<tr>
	<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:250px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:866px;HEIGHT:427px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"  VALUE="0">
						 <PARAM NAME="Indwidth"		VALUE="0">
						 <PARAM NAME="Fillarea"		    VALUE="true">
						 <PARAM NAME="ColSizing"		VALUE="true">
						 <param name="Editable"     	value='true'>
						 <PARAM NAME="Sortview"		VALUE="left">
						 <param name=UsingOneClick  value="1">
					     <PARAM NAME="Format"			VALUE="  
					        <C>ID=CHK 	          Name='����'            width=28   HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	 EditStyle=CheckBox   </C>  
							<G> Name='�о�����',                                                     HeadBgColor=#B9D4DC,  align=center, 
							<C>ID=BS_INGB,	      Name=�Ա�,	            width=80,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=left,        edit=none, sort=true   EditStyle=Combo	Data='1:����,2:�ߵ���1��,3:�ߵ���2��,4:�ߵ���3��,5:�ߵ���4��,6:�ܱ�'</C>
							<C>ID=BS_SEQNO,	      Name=ȸ��,	            width=40,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=center,  edit=none, sort=true   EditStyle=Combo	Data='1:1ȸ,2:2ȸ,3:3ȸ,4:4ȸ,5:5ȸ'</C>
							<C>ID=BS_DNO,	      Name=��,		        width=35,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=center,  edit=none, sort=true  </C>
							<C>ID=BS_HNO,	      Name=ȣ,		        width=35,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=center,  edit=none, sort=true </C>
							<C>ID=BS_VENDID,	  Name=����ڹ�ȣ,		    width=90,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=center,  edit=none, sort=true </C>
							<C>ID=BS_VENDNM,	  Name=���ü��,			width=120,HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=left,        edit=none  sort = true  </C>
							<C>ID=BS_DIRCNM,	  Name=��ǥ�ڸ�,		    width=80,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))}  align=center,  edit=none  sort = true  </C>												
							</G>
							<G> Name='ȸ������' ,                                                     HeadBgColor=#B9D4DC, align=center, 
							<C> ID=VEND_ID,	      Name=����ڹ�ȣ,		    width=90,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=center,	edit=none  sort = true  </C>
							<C> ID=VEND_NM,	      Name=���ü��,	        width=120,HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=left,		edit=none  sort = true  </C>
							<C> ID=VD_DIRECT,	  Name=��ǥ�ڸ�,	        width=80,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=center,	edit=none  sort = true  </C>
							<C> ID=VEND_CD,	      Name=�ŷ�ó�ڵ�,	        width=70,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=center,	edit=none  sort = true  </C>
							</G>
							<C> ID=VEND_STS,	  Name=��ϻ���,           width=70,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=center,	edit=none  sort = true  </C>
							<C> ID=VEND_UPT,	  Name=��������,           width=70,	HeadBgColor=#B9D4DC, BgColor={IF(VEND_UPT='U','#FFCC66',IF(VEND_STS='N','#FFCC66',I'FFFFFF'))} , align=center,	edit=none  sort = true  </C>   
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
				</td>
			  </tr>
			 </table>

			</td>
			
		 </tr>
		</table>

	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search">
		</label></td>
  </tr>	
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='

		
	'>
</object></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



