<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	ȸ�����/���������(���ڼ��ݰ�꼭)
+ ���α׷� ID	: A040060.html
+ �� �� �� ��	: ���������(���ڼ��ݰ�꼭)
+ �� �� �� ��	: ������
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
+ �� �� �� ��     :	�������ݰ�꼭 �ڵ� �߰� 
+ ��   ��  ��      : JYS
+ �� �� �� ��     : 2009.12.07
-----------------------------------------------------------------------------
+ �� �� �� ��     :	��� �߰�
+ ��   ��  ��      : JYS
+ �� �� �� ��     : 2010.12.01
-----------------------------------------------------------------------------
+ �� �� �� ��     : ������� ���� �ǿ� ���Ͽ� ������� �����ϰ� ��.  //
+ �� �� �� ��     : �������ݰ�꼭��� ���ʽ��ι�ȣ �ֱ�.... 
+ ��   ��  ��      : J Y S
+ �� �� �� ��     : 2017.06.27 
+ �� �� �� ��	:
-----------------------------------------------------------------------------
+ �� �� �� ��	: a040060_s1 , 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���������</title>

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

var gs_gubun="";
var gs_empnos="";
var gs_deptcds="";
var gs_curdate="";



/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

    //&&
	//newWin=window.open('inform.html','child','width=350,height=230,top=310,left=350');
	gclx_cocode.index=2;
	gclx_amend_code.index=0;
	//ln_Find_Regno();
	//ln_Query(gcem_regno.text);
    ln_Before();
    //gcem_frdt.text="20090801";
	//gcem_todt.text="20090831";

	gclx_fdcode.index=1;
	gcem_frdt.text=ln_Load_Date('s');

	gs_curdate = ln_Load_Date('c');
  	gcem_todt.text= gs_curdate;

    //2011.01.31. jys ������ ���� ���� üũ 
	if (!ln_User_Chk()){
		sp0.style.display = "none";
	}else{
		sp0.style.display = "";
  }

}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

    ln_Authority();
}

/******************************************************************************
	Description : ������ȸ
******************************************************************************/
function ln_Authority(){
	
	//login�ڿ� �ΰ��� ������Ȯ��---------------------------------------------------------
	gcds_login.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0901&v_str2="+gusrid;
	gcds_login.Reset();

	if( gcds_login.countrow>0){
		hid_login.value="M";
		gs_empnos="";
		gs_deptcds="";
	}else{
		hid_login.value="";	
	
		//�α������� ����.-----------------------------------------------------------------------
		gcds_right.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0902&v_str3="+gusrid;
		//prompt(this,gcds_right.DataID);
		gcds_right.Reset();

		for(i=1;i<=gcds_right.countrow;i++){
			if(gcds_right.namevalue(i,"CDREMARK")!=""){   // ���κ����� ������.empno
				gs_empnos=gs_empnos+gcds_right.namevalue(i,"CDREMARK")+"','";
			}else if(gcds_right.namevalue(i,"GBCD")!=""){ // �μ������� ������.deptcd
				gs_deptcds=gs_deptcds+gcds_right.namevalue(i,"GBCD")+"','"; 
			}
		}

		//�Ǹ������� �޸��� �����.
		if(gs_empnos.length>1){
			gs_empnos = gs_empnos.substring(0,gs_empnos.length-3);
		}

		if(gs_deptcds.length>1){
			gs_deptcds = gs_deptcds.substring(0,gs_deptcds.length-3);
		}
		//------------------------------------------------------------------------------------
	} 
}


/******************************************************************************
	Description : ��꼭 ����� ���üũ 
******************************************************************************/
function ln_User_Chk(){
  //��꼭 ����� ��� üũ && Email ��� üũ
	gcds_chk.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_sm_user_s1?v_str1="+gusrid;
  //prompt('',gcds_chk.DataID);

	gcds_chk.Reset();

	if(gcds_chk.countrow<=0){
		alert("���ڼ��ݰ�꼭 ������ �ݵ�� ��꼭 ����ڰ����� ����ϼž� �մϴ�. ");
		return false;
	}

	if(gcds_chk.namevalue(gcds_chk.rowposition,"SMART_ID")==""){
		alert("smartbill.co.kr �� ����� ������ id�� ��꼭 ����ڰ����� ����ϼž� �մϴ�. ");
		return false;
	}

	if(gcds_chk.namevalue(gcds_chk.rowposition,"SMART_PASSWORD")==""){
		alert("smartbill.co.kr �� ����� ������ password�� ��꼭 ����ڰ����� ����ϼž� �մϴ�. ");
		return false;
	}

	if(gcds_chk.namevalue(gcds_chk.rowposition,"EMAIL")==""){
		alert("�λ� ���������� smartbill.co.kr�� ����� eMail�� ����ϼž� �մϴ�. ");
		return false;
	}
	return true;

}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
  var strcocode ="";																

  if(gclx_cocode.bindcolval=="00"){
	  strcocode ="";
  }else{
	  strcocode =gclx_cocode.bindcolval;
  }	
	
  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040060_s1_ee?v_str1="+gclx_fdcode.bindcolval          //����                
	                                                                     +"&v_str2="+strcocode          	         //�����              
																	     +"&v_str3="+gcem_frdt.text					 //��꼭�Ⱓ from     
																		 +"&v_str4="+gcem_todt.text					 //��꼭�Ⱓ to       
																		 +"&v_str5="+gcem_regno.text				 //����ڵ�Ϲ�ȣ      
																		 +"&v_str6="+gcem_vendnm.text				 //�ŷ�ó��            
																		 +"&v_str7="+gcem_vendcd.text				 //�ŷ�ó�ڵ�    
																	     +"&v_str8="+gusrid 	                     //id     
																		 +"&v_str9="+gs_empnos	                     //���������� ���     
																		 +"&v_str10="+gs_deptcds	                 //���������� �μ�
																		 +"&v_str11="+hid_login.value	             //�����ڱ���			
																		 +"&v_str12="+gclx_amend_code.bindcolval	 //�����ڵ�	
																		 +"&v_str13="+gclx_taxsts.bindcolval;	     //�������
  //prompt("",gcds_data.DataID);
  gcds_data.Reset();

}

/******************************************************************************
	Description : ������ ����
	�����͸� XXSB_DTI_MAIN, XXSB_DTI_ITEM, XXSB_DTI_STATUS�� INSERT �ؾ���.
******************************************************************************/
function ln_Save(){

  var strregno ="";

  if(!ln_Chk())return;

  if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;       
  else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
  else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
  else if (gclx_cocode.bindcolval=="04") strregno = gs_regno_g;


  if(strregno==""){
	  strregno="2218113834";
	 //alert("�ش� ������� �����Ͻʽÿ�.");  
	 //return;
  }

  //�� �̷� ���� �߻��ϴ��� Ȯ���غ�����..........
	//JYS. �������� ����ڵ�Ϲ�ȣ�� Ʋ���ٰ� ����....����� ���̺� 2���� �Է��ؼ� �׷���???????
  if(gusrid=="6070001"){
		alert("gclx_cocode.bindcolval::"+gclx_cocode.bindcolval+"::strregno::"+strregno);
  }

  if (gcds_data.IsUpdated) {
		if (confirm("���� �Ͻðڽ��ϱ�?")){	
			//&&gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040060_t1"
			//gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040060_t1_ee"
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040060_t1_ee_A"
			gctr_data.Parameters = "v_str1="+strregno+",v_str2="+gusrid;
			//prompt('',gcds_data.text);
			gctr_data.post();
		}	
	}

 /*
  if(!ln_Chk()) return;
  
  var v_left = (screen.width-300)/2;
  var v_top  = (screen.height-300)/2;
  //var v_left = screen.availWidth/2 - 300/2; 
  //var v_top  = screen.availHeight/2 - 300/2;            

	
	if(gcds_data.namevalue(1,"CHK")=="T"){        //������ ���
		url=gs_url+"/callSB_V3/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_s+"&CERT_COMNAME="+gs_comname_s;		
	}else if(gcds_data.namevalue(2,"CHK")=="T"){  //���� ���
		url=gs_url+"/callSB_V3/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_g+"&CERT_COMNAME="+gs_comname_g;	
	}

  window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
	*/
}

/******************************************************************************
	Description : ����� �ڵ�� ����ڵ�Ϲ�ȣ ã�� 
******************************************************************************/
function ln_Find_Regno(){
  /*
	if(gclx_cocode.bindcolval=="01"){
		gcem_regno.text =gs_regno_g;
	}else if(gclx_cocode.bindcolval=="02"){
    gcem_regno.text =gs_regno_s;
	}else{
    gcem_regno.text ="";
	}
	*/
}

/******************************************************************************
	Description : üũ 
******************************************************************************/
function ln_Chk(){

   gcgd_data.focus();
  
	//üũ�� ���� ���

	var intcnt = 0; 
  	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			intcnt+=1;
		}
	}
	if (intcnt==0){
		alert("���� ���� ���� �����Ͽ��� �մϴ�.");
		return false;
	}

    for (j=1;j<=gcds_data.countrow;j++){
		if(gcds_data.namevalue(j,"CHK")=="T"){

		    //2009.09.03
			//�������� ������ ���� ��ǥ��ȣ�� ������ ��찡 ����.
      		// alert("FDCODE::"+gcds_data.namevalue(j,"FDCODE"));
			if(gcds_data.namevalue(j,"FDCODE")=="04"){

			}else{
				//��ǥ��ȣ�� ������ ��� 
				//�ӽø���..2009.10.05 JYS
				if(gcds_data.namevalue(j,"SLIPNO")!=""){
					alert(j+" �࿡ ��ǥ��ȣ�� �����Ͽ� �� ������ �� �����ϴ�.");
					return false;
				}
			}

			//�ŷ�ó���� ���� ���
      		if(gcds_data.namevalue(j,"VEND_NM")==""){
				alert(j+" ���� �ŷ�ó�� Ȯ�� �Ͻʽÿ�.");
				return false;
			}

			//����ڵ�Ϲ�ȣ�� ���� ���
			if(gcds_data.namevalue(j,"VEND_ID")==""){
				alert(j+" ���� ����ڵ�Ϲ�ȣ�� Ȯ�� �Ͻʽÿ�.");
				return false;
			}

			//���ް����� ���� ���
			if(gcds_data.namevalue(j,"TAXSUM")==0){
				alert(j+" ���� ���ް����� Ȯ�� �Ͻʽÿ�.");
				return false;
			}

			//�հ���� ���� ���
			if(gcds_data.namevalue(j,"TAXTOT")==0){
				alert(j+" ���� �հ���� Ȯ�� �Ͻʽÿ�.");
				return false;
			}

			//��꼭 ��ȣ�� ���� ���
			if(gcds_data.namevalue(j,"TAXNBR")==0){
				alert(j+" ���� ��꼭��ȣ�� Ȯ�� �Ͻʽÿ�.");
				return false;
			}

			//Email�� ���� ��� ���� ���� ����. ( Ư�� �������� �����)
			if(gcds_data.namevalue(j,"EMAIL")==""){
				alert(j+" ���� EMAIL�� Ȯ���Ͻʽÿ�.");
				return false;
			}

    
			//2009.12.09 JYS
			//�ۼ����� �� �������� ���ؼ� �ۼ�����>�������� ��� ����ȵ�.
      		if(gcds_data.namevalue(j,"TAXDAT")>gs_curdate){
				alert(j+" ���� ��꼭 �ۼ����ڸ� Ȯ���Ͻʽÿ�.");
				return false;
			}
			
			//2017.06.27 JYS
			//������°� ������ �ƴѰ��� ������� �Ұ�
      		if(gcds_data.namevalue(j,"TAXSTS")!="Y"){
				alert(j+" ���� ������°� ������ �ƴմϴ�. ���ؿ� �븮���� Ȯ�� �Ͻʽÿ�.");
				return false;
			}
			
		}
	}
	
	return true;
}
/******************************************************************************
	Description : ã�� - �ŷ�ó�ڵ�
******************************************************************************/
function ln_Popup(){
    	var arrVAT	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrVAT[0]="VAT";

		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_vendcd.text  = arrParam[0];
			gcem_vendnm.text	= arrParam[1];
			gcem_regno.text	= arrParam[5];
		} else {
			gcem_vendcd.text	= "";
			gcem_vendnm.text	= "";
			gcem_regno.text="";
		}
}


/******************************************************************************
	Description : ã�� - ����� 
******************************************************************************/
function ln_Popup2(){
		var arrTAXNBR	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrTAXNBR[0] = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR");

		strURL = "./a040060_popup1.jsp";
		strPos = "dialogWidth:520px;dialogHeight:270px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrTAXNBR,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcds_data.namevalue(gcds_data.rowposition,"EMAIL")  = arrParam[0]; //email
		} //else {
		//	gcds_data.namevalue(gcds_data.rowposition,"EMAIL")	= "";
		//}
		ln_Query();
}


/******************************************************************************
	Description : ����Ʈ ��� ȣ�� 
******************************************************************************/
function ln_SM_Call(strBatchId, strId, strPass){
    
		var v_left = (screen.width-300)/2;
   		var v_top  = (screen.height-300)/2;

		//���ݰ�꼭��
   		url=gs_url+"/callSB_V3/XXSB_DTI_ARISSUE.asp?BATCH_ID="+strBatchId+"&ID="+strId+"&PASS="+strPass;		
		window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );

		ln_Query();
    
		//���ݰ�꼭 �� �ŷ����� 
        //url=gs_url+"/callSB_V3/XXSB_DTI_ARISSUE_T.asp?BATCH_ID="+strBatchId+"&ID="+strId+"&PASS="+strPass;		
		//window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );

}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
<object id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- ���Ѱ��� -->
<object id=gcds_right classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_login classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
	<object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="a040060_t1_ee_A(I:USER=gcds_data,O:USER2=gcds_return)">
  </object>
 </comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_cocode event=OnSelChange()>
  
  //ln_Find_Regno();
  //ln_Query(gcem_regno.text);

</script>

<script language="javascript"  for=gcgd_data event="OnClick(row,colid)">
  
	if(row==0 && colid=="CHK"){ //��ü����              
		if(gcds_data.namevalue(1,"CHK")=="T"){ //ù���� üũ �Ǿ� ���� ���
			for(i=1;i<=gcds_data.Countrow;i++){
				gcds_data.namevalue(i,"CHK") = "F";
			}//for
		}else{
			for(i=1;i<=gcds_data.Countrow;i++){  //ù����  üũ ���� ���� ��� ��� üũ 
				gcds_data.namevalue(i,"CHK") = "T";
			}//for
		}
	}else if (row!=0 && colid=="CHK"){  //��������
      
		if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;

		if(gs_gubun=="1"||gs_gubun==""){
			gcds_data.namevalue(row,"CHK")="T";
		}else{
			gcds_data.namevalue(row,"CHK")="F";
		}
	}

</script>

<script language="javascript" for="gcgd_data" event="OnDblClick(row,colid)">
	if(gclx_fdcode.BindColVal == "04"&&colid!="CHK") ln_Popup2();
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gctr_data event=OnSuccess()>

    //alert("BATCH_ID::"+gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"));
 
	ln_SM_Call(gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"),
	           gcds_return.namevalue(gcds_return.rowposition,"ID"),
			   gcds_return.namevalue(gcds_return.rowposition,"PASS"));
 
</script>



<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>
 
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a040060_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>
		<span id=sp0 style="display:none;"> 
			<img src="../../Common/img/btn/com_b_sale.gif" style="cursor:hand" onclick="ln_Save()">
		</span>
		<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand" onclick="ln_Query()"></nobr>
	</td>
  </tr>
  <tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;" >
			<tr> 
      			<td width="65px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>�����ڵ�</nobr></td>
				<td width="90px" class="tab18"><nobr>&nbsp;<comment id="__NSID__">
					<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:2px;width:85px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=Enable          value="true">
						<param name=ListExprFormat	value="FDNAME^0^85">
						<param name=BindColumn			value="FDCODE">
					</object>
	        		</comment><script>__ws__(__NSID__);</script></nobr> 
				</td>
				<td width="65px" align=center  bgcolor="#eeeeee" class="tab18" ><nobr>�����</nobr></td>
				<td width="90px" class="tab18"><nobr>&nbsp;<comment id="__NSID__">
					<object id=gclx_cocode      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;width:85px;">
						<param name=CBData			value="00^��ü,01^��,02^����,04^ȫ��">
						<param name=CBDataColumns	value="CODE,NAME">
						<param name=SearchColumn	value=NAME>
						<param name=Sort			value=false>
						<param name=ListExprFormat	Value="CODE^1^20,NAME^1^60">								
						<param name=BindColumn		value="CODE">
					</object>
	        		</comment><script>__ws__(__NSID__);</script></nobr> 
				</td>
				<td width="65px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>����Ⱓ</nobr></td>
				<td width="200px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
					<object  id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_todt', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
				</td>
				<td width="65px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>�����ڵ�</nobr></td>
				<td width="200px" class="tab18" ><nobr>
					<comment id="__NSID__">
					<object  id=gclx_amend_code classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:3px;top:0px;font-size:12px;width:180px;height:200px;">
						<param name=CBData				value="^'��ü',01^��������� ���� ����,02^���ް��� ����,03^ȯ��,04^����� ����,05^�����ſ��� ���� ����,06^������ ���� ���߹߱� ��">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				value="false">
						<param name=ListExprFormat	    value="CDCODE^1^20,CDNAM^0^180">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					</nobr>
				</td>
			</tr>
			<tr> 
				<td width="65px" align=center  bgcolor="#eeeeee" class="tab17" ><nobr>����ڹ�ȣ</nobr></td>
				<td width="90px" class="tab19" ><nobr>&nbsp;<comment id="__NSID__"><nobr> 
					<object id=gcem_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:2px;width:80px;height:20px;">
						<param name=Text          value="">
						<param name=Alignment	  value=0>
						<param name=Border	      value=True>
						<param name=Format	      value="000-00-00000">
						<param name=PromptChar	  value="_">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<!-- <param name=ReadOnly      value=true> -->
					</object>
				    </comment><script>__ws__(__NSID__);</script></nobr> 
				</td>
				<td width="65px" align=center  bgcolor="#eeeeee" class="tab19" ><nobr>�ŷ�ó��</nobr></td>
				<td width="150px" class="tab19" colspan=5><nobr>&nbsp;<comment id="__NSID__">
					<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:250px" onKeydown="if(event.keyCode==13) ln_Popup()">
						<param name=Text			value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=GeneralEdit     value="true">
						<param name=PromptChar	    value="_">
					</object>
					</comment><script>__ws__(__NSID__);</script>&nbsp;
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('A')">
			  		<comment id="__NSID__">
					<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px" onKeydown="if(event.keyCode==13) ln_Popup()">
						<param name=Text			value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#############">
						<param name=PromptChar	    value="_">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
					<img name="btn_find" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm.text = '';gcem_vendcd.text = '';gcem_regno.text=''">
				  </nobr> 
				</td>
			</tr>
			<tr>
				<td width="65px" align=center  bgcolor="#eeeeee" class="tab17" >�������</td>
				<td width="90px" class="tab19"  colspan =7><nobr>&nbsp;
					<comment id="__NSID__"> 
					<object  id=gclx_taxsts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:-5px;top:3px;font-size:12px;width:100px;">
						<param name=CBData			    value="^��ü,N^���,R^��û,Y^����,B^�ݼ�">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				value="false">
						<param name=Enable				value="true">
						<param name=ListExprFormat	    value="CDNAM^0^90">
						<param name=BindColumn			value="CDCODE">
						<param name=index				value="0">
					</object>
				    </comment><script>__ws__(__NSID__);</script></nobr> 
				</td>
			</tr>
		</table>
    </td>
	</tr>

	<tr>
	<td colspan=2>	  
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:5px;width:876px;border:0 solid #708090;">
		<tr> 			
			<td>
				<comment id="__NSID__">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:874px;HEIGHT:377px;border:1 solid #777777;display:block;">
						<PARAM NAME="DataID"			  VALUE="gcds_data">
						<PARAM NAME="BorderStyle"   VALUE="0">
						<param name="IndWidth"      value="0">
						<param name="Fillarea"		  VALUE="true">
						<param name="ColSizing"     value="true">
						<param name="editable"      value="true">
						<PARAM NAME="Format"			  VALUE="  
						<FC> Name='����'	            ID=CHK         	     HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center	EditStyle=CheckBox </FC> 
						<FC> Name='��ǥ��ȣ'			ID=SLIPNO        	 HeadAlign=Center HeadBgColor=#B9D4DC Width=105	align=cneter	edit=none  Mask='XXXXXXXXX-XXXXXX'</FC>
						<FC> Name='�ŷ�ó��'			ID=VEND_NM       	 HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		edit=none</FC>
						<FC> Name='����ڵ�Ϲ�ȣ'	    ID=VEND_ID   	     HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=center    edit=none  Mask='XXX-XX-XXXXX'</FC>
						<C>  Name='���ް���'			ID=TAXSUM        	 HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right		edit=none</C>
						<C>  Name='�ΰ�����'		    ID=TAXVATAMT         HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=right		edit=none</C>
						<C>  Name='�հ�'             ID=TAXTOT   		 HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right  	edit=none</C>
						<C>  Name='����'             ID=REMARK        	 HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left  	edit=none</C>
						<C>  Name='����'             ID=DTI_STATUS        HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left  	edit=none  EditStyle=Combo Data='S:��������,I:���Ź̽���,C:���Ž���,R:���Űź�,O:��ҿϷ�,M:������ҿ�û(���޹޴���),N:������ҿ�û(������),V:�������û,T:������ź�,W:�������û ���'</C>
						<C>  Name='��꼭��ȣ'        ID=TAXNBR        	 HeadAlign=Center HeadBgColor=#B9D4DC Width=85	align=center 	edit=none  Mask='XXXXXXX-XXXX'</C>
						<C>  Name='Email'          ID=EMAIL         	 HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	edit=none  </C>
						<C>  Name='��꼭����'    	   ID=TAXDAT    	     HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center     edit=none  Mask='XXXX-XX-XX'</FC>
						<C>  Name='�����ڵ�'         ID=AMEND_CODE     	 HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	edit=none  EditStyle=Combo Data='01:��������� ����������,02:���ް��� ����,03:ȯ��,04:����� ����,05:�����ſ��� ���� ����'</C>
						<C>  Name='�������'         ID=AMEND_REMARK   	 HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	edit=none  </C>
						<C>  Name='�������'         ID=TAXSTS        	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left  	edit=none EditStyle=Combo, Data='N:���,R:��û,Y:����,B:�ݼ�' </C>
					">                                                                                                                                                             
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
		</table> 
  </td>
	</tr>
	<tr><td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search"></label></td> </tr>	 
	<input type="hidden" class="txt11" id="hid_login"  style="position:relative;left:0px;width:60px;background-color:#d7d7d7" readOnly>
</table>

 </body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
