<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ������ - ��꼭
 * ���α׷�ID 	 : PMS/Sta
 * J  S  P		 : Sta500.jsp
 * �� �� ��		 : Sta500
 * �� �� ��		 : �� �� ��
 * �� �� ��		 : 2018-06-21
 * �������		 : ������ - ��꼭
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/


	var gs_userid = gusrid;
	var gs_fdcode;
	
	var gstrempno="";
	var gstrdeptcd="";
	var gstrGubun ="";
	var gstrAuthgr="";
	var gstrRowpos="";




	var v_default_row = 1;
	
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		
		fnInit();
		
	}
	
	<%//�ʱ��۾� %>
	function fnInit() {
		
	    v_job ="I";
	    
	    v_fr_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
        v_to_date.Text = "<%=DateUtil.getCurrentDate(8)%>";		
		
		
    	//�����ڵ�
    	ds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
    	ds_fdcode.Reset();


    	//�ΰ�������[����]
    	ds_staxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
    	ds_staxknd.Reset();

    	//alert(ds_fdcode.countrow);
    	
		//alert("18");
        

	
		//fnSelect();
	    
	}

	
	

	
	
    <%//���� ��ȸ  %>
    function fnSelect() {
    	
		    v_job="S";

	        var fr_date = v_fr_date.Text.trim();
	        var to_date = v_to_date.Text.trim();

	        if(fr_date.length!=8) {
	            alert("��꼭����(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("��꼭����(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	    	}

	                  
	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
									                + ",v_frdt=" + fr_date
									                + ",v_todt=" + to_date;    
									                
	                  								//+ ",v_journal="  + v_journal.value	                  								
													//+ ",v_journal="  + v_journal.value;
	                  								
	        //alert(param);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_STA%>Sta100",
				            "JSP(O:DS_DEFAULT=ds_default)",
				            param);
	           
	        tr_post(tr1);
	        

    }    	
	

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

        gstrAuthgr="A"; 

		var str1 = gclx_staxiodiv.BindColVal;	 //���Ը��ⱸ��
		var str2 = gclx_cocode.BindColVal;		 //�����
		var str3 = gcem_staxdatfr.text;			 //��꼭�Ⱓ from
		var str4 = gcem_staxdatto.text;			 //��꼭�Ⱓ to
		var str5 = gcem_vendcd.text;			 //�ŷ�ó�ڵ�
		var str6 = "";		                     //�ͼӱ���
		var str7 = "";	                      	 //�ΰ�������
		var str8 = "";                      	 //���࿩��
		var str9 = gclx_fsstat.BindColVal;		 //��ǥ����
		var str10 = gcem_vendnm.text;			 //�ŷ�ó��
		var str11 = gclx_fdcode.BindColVal;		 //�����ڵ�
		var str12 = gs_userid;	                 //�α���
		var str17 = "";                          //�����ڵ�
		var gs_chk="";
		var str18 = gclx_gubun.BindColVal;       //���ڹ��౸��
		var str19 = gcem_empno.text;             //�ۼ���
		var str21 = gclx_ebillgb.bindcolval;     //ebill����
		

		if (str1 =="1") {       //����
			str1 = "A";
			str7 = gclx_staxknd.BindColVal;
		}else if (str1 =="2") { //����
			str1 = "B";
			str7 = gclx_staxknd_2.BindColVal;		
  	    }
		
		if(gstrAuthgr=="A"){ //�ΰ��� ������
			str13 = "1";	
		}else{
            str13 = "2";            //�Ϲݻ����	
		}


    	if(str1 =="A"){         //����
			//���ݰ�꼭 ( ���� +�Ұ�+���� ) 
			if(str7=="9"){
				str7= "1','2','4";
			}else if (str7=="6"){
				str7= "1','2','4','7','8";
			}
    	}else if(str1 =="B"){  //����
			if(str7=="9"){  //���ݰ�꼭 (����+����)
				str7= "1','2";
			}
		}

		//���ݰ�꼭+��Ÿ  ( ���� +�Ұ�+���� + �ſ�ī�� + ���ݿ�����  ) 
    
    	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_ee"
											+"?v_str1="+str1+"&v_str2="+str2
											+"&v_str3="+str3+"&v_str4="+str4
											+"&v_str5="+str5+"&v_str6="+str6
											+"&v_str7="+str7+"&v_str8="+str8
											+"&v_str9="+str9+"&v_str10="+str10
											+"&v_str11="+str11+"&v_str12="+gs_chk
											+"&v_str13="+str12+"&v_str14="+str13
											+"&v_str15="+gstrempno+"&v_str16="+gstrdeptcd
											+"&v_str17="+str17+"&v_str18="+str18
											+"&v_str19="+str19+"&v_str21="+str21;
											
		//prompt('',gcds_data.DataID);
		gcds_data.Reset();
}


	/******************************************************************************
		Description : ã�� - �ŷ�ó�ڵ�
	******************************************************************************/
	function ln_Popup(){
	    var arrVAT	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	
	   //2013.01.15 jys 
	   //arrVAT[0]="VAT";
		//arrVAT[0]="";
	
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_vendcd.text  = arrParam[0];
			gcem_vendnm.text	= arrParam[1];
		} else {
			gcem_vendcd.text	= "";
			gcem_vendnm.text	= "";
		}
	}





    <%//���� ��- �˻����� ó���� : �����ڸ� �����ϰ�%>
    function fnEmpNoPopup(dirPath){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		v_mgr_no.value = arrParam[1];
    		v_mgr_nm.value = arrParam[0];
        } else {
			fnEmpNoCleanup();
        }               
    }

    function fnEmpNoCleanup(){
        v_mgr_no.value = "";
        v_mgr_nm.value  = "";
    }





	/******************************************************************************
		Description : ã�� - �ۼ��� 
	******************************************************************************/
	function ln_Popup_Empno(){
	
		//var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	 
		strURL = "./empno_popup3.jsp";
		strPos = "dialogWidth:480px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);
	 
		if (arrResult != null) {
			arrParam = arrResult.split(";");
	        gcem_empno.text    = arrParam[0];
	    }else{
	        gcem_empno.text    = "";
	    }
	}

	
	
	
	
	/***********************************************************************************************
		Description : ��ǥ��ȸ
		parameter   : 
	**********************************************************************************************/
	function ln_Slipno(){
		
		if(gcds_data.namevalue(gcds_data.rowposition,"CHK") == "T" && gcds_data.namevalue(gcds_data.rowposition,"FSNBR") != "") {	
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL="";	
			var strPos="";
	
			arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"FDCODE");
			arrParam[1] = gcds_data.namevalue(gcds_data.rowposition,"FSDAT");
			arrParam[2] = gcds_data.namevalue(gcds_data.rowposition,"FSNBR");
	
			strURL = "./slipno_popup.jsp";
			strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);
		}else if (gcds_data.namevalue(gcds_data.rowposition,"CHK") == "T" && gcds_data.namevalue(gcds_data.rowposition,"FSNBR") == "") {
			alert("���� �� ��ǥ�� �����ϴ�.");
		}
	
	}

	
	

	/******************************************************************************
		Description : ���ݰ�꼭 ����
		parameter   :            
	******************************************************************************/
	function ln_Bill_View(){
	
	   if(!ln_Bill_Chk()) return;
	   
	
		if (gcds_data.IsUpdated){
			gs_sm_call_status="V"; // ��꼭���� tag
			ln_Batch_id();
		}
	}

	
	
	
	
	/******************************************************************************
		Description : ���ݰ�꼭 ���� üũ 
		parameter   :            
	******************************************************************************/
	function ln_Bill_Chk(){
		var view_chk ="";
	
	   //���� �ϰ�츸 ����
	   //���� �� ���Ž��� �Ǵ� ���� �̽��θ� ���� 
	   for(var i=1;i<=gcds_data.countrow;i++){
		   if (gcds_data.namevalue(i,"CHK")=="T"){
		   		if(gcds_data.namevalue(i,"SUPBUY_TYPE")=="AR" ){
		   			if(gcds_data.namevalue(i,"DTI_STATUS")=="I"||gcds_data.namevalue(i,"DTI_STATUS")=="C" ){
		   				
		   			}else{
		   			
		   			   alert( i +" ���� ���ݰ�꼭 ���Ⱑ ���� �ʽ��ϴ�. Ȯ�ιٶ��ϴ�. 1");
					   return false;
		   			}
		   		}else{
		   		    alert( " ���⼼�ݰ�꼭�� �����մϴ�. "+ i +" ���� ���ݰ�꼭 ���Ⱑ ���� �ʽ��ϴ�. Ȯ�ιٶ��ϴ�. 2");
		   			return false;
		   		}
		   }
	   }
	   
	   return true;
	}

	
	
	
	/******************************************************************************
		Description : Interface_Batch_id ���� �� ������� id, pw ã��
		parameter   :            
	******************************************************************************/
	function ln_Batch_id(){      
	
	    var strregno ="";
	    strregno = gs_regno_s;
	    /**
	    if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;
		else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
		else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
		**/
		
		//alert("strregno::"+strregno);
	  
	    gctr_data.KeyValue = "a040065_t1(I:USER=gcds_data,O:USER2=gcds_return)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_t1"
		gctr_data.Parameters = "v_str1="+gusrid+",v_str2="+strregno;
			
		//prompt('gcds_data',gcds_data.text);
	
		gctr_data.post();
	}
	

	
	
	
	
	/******************************************************************************
		Description : ����Ʈ ��� ȣ�� 
	******************************************************************************/
	function ln_SM_Call(strBatchId, strId, strPass){
	
	      //alert("strBatchId::"+strBatchId+"::STATUS::"+gs_status+"::SIGNAL::"+gs_signal+"::strId::"+strId+"strPass::"+strPass+"::SBDESCRIPTION::"+hid_sbdescription.value);
	    
			var url="";
	        var v_left = (screen.width-300)/2;
	        var v_top  = (screen.height-300)/2;
	
			if (gs_sm_call_status=="V"){   //���ݰ�꼭 ���� �� ���
					url=gs_url+"/callSB_V3/XXSB_DTI_PRINT.asp?BATCH_ID="+strBatchId+"&SORTFIELD=A&SORTORDER=1";			
					window.open(url,"", "status=1,  scrollbars=yes, width=300, height=280, left="+v_left+", top="+v_top  );
					ln_Query();
	    	}
	    	
	}



</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>



<object  id=ds_empno_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id="ds_fdcode" classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �����ڵ�[�˻�] -->
</object> 

<object  id="ds_staxknd" classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �ΰ�������[����] -->
</object> 


<object id=ds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>




<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript  for=ds_default event=OnLoadCompleted(row,colid)>

		window.status = "���������� ��ȸ�Ǿ����ϴ�.";
		
		if (row<1) 
			alert("�˻��� �����Ͱ� �����ϴ�.");
</script>





<script language="javascript" for="ds_fdcode" event="onloadCompleted(row,colid)">

	ds_fdcode.InsertRow(1);
	
	ds_fdcode.NameValue(1,"FDCODE")="";
	
	ds_fdcode.NameValue(1,"FDNAME")="��ü";
	
	lc_fdcode.bindcolval=gs_fdcode;
	
</script>




<script language="javascript" for="ds_staxknd" event="onloadCompleted(row,colid)">

	ds_staxknd.InsertRow(1);
	
	ds_staxknd.NameValue(1,"CDCODE")="";
	ds_staxknd.NameValue(1,"CDNAM")="��ü";
	
	ds_staxknd.AddRow();
	
	ds_staxknd.NameValue(ds_staxknd.rowposition,"CDCODE")="9";
	ds_staxknd.NameValue(ds_staxknd.rowposition,"CDNAM")="���ݰ�꼭";

	ds_staxknd.AddRow();
	
	ds_staxknd.NameValue(ds_staxknd.rowposition,"CDCODE")="6";
	ds_staxknd.NameValue(ds_staxknd.rowposition,"CDNAM")="���ݰ�꼭+��Ÿ";

	lc_staxknd.index=0;
	
</script>





<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript"  for=gcgd_data  event="OnDblClick(Row,Colid)">

	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();
	
	var strParam = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR").substring(0,1);
	
	arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR");

	
	if(strParam=="A"||strParam=="C"||strParam=="E"||strParam=="G"){
		strURL = "./a040110_popup.jsp";
		
	}else if(strParam=="B"||strParam=="D"||strParam=="F"||strParam=="H"){
		strURL = "./a040120_popup.jsp";
	}
	
	strPos = "dialogWidth:970px;dialogHeight:635px;status:no;scroll:no;resizable:no";
	
	result = showModalDialog(strURL,arrParam,strPos);
	
</script>





<script language="javascript" for="gcgd_data" event="OnClick(row,colid)">
	
		
    if((row!=0) && (colid=="CHK")){
        
	    if(gcds_data.namevalue(row,"CHK")=="T"){
	
	 	}else{
	 	        gcds_data.undo(row);
	 	}
    }   
        
</script>




<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>





</head>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>


<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">

        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"				style="cursor:pointer" onClick="fnApply();">

						</td>
                    </tr>
                </table>
            </td>
        </tr>

	<tr><td height=4></td></tr>
</table>

<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>

            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>

                        <td align=left class="text"  width="100">��꼭�Ⱓ</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>&nbsp;~&nbsp;
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>           			

                        <td align="left" class="text" width="90">�����ڵ�</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_fdcode classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
								<param name=ComboDataID			value="ds_fdcode">
								<param name=CBDataColumns		value="FDCODE,FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				value=false>
	              				<param name=Enable              value="true">
								<param name=ListExprFormat	    value="FDNAME^0^150">
								<param name=BindColumn			value="FDCODE">
								<param name=Index               value="2">                            
                            </object>
                        </td>                         
                               
                        <td align="left" class="text" width="90">�����</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_cocode classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
								<param name=CBData				value="^��ü,01^��,02^����,04^ȫ��">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
                            </object>            
                        </td>                                
					</tr>

           			<tr>
                        <td align="center" class="text" width="90">�ŷ�ó</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                        	<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:150px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="��ȸâ ��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
                        </td>
                        
                        
                        <td align="center" class="text" width="90">�ۼ���</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                        	<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:150px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="��ȸâ ��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
                        </td>                        
                        
                        <td align="center" class="text" width="90">eBill����</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                            <object id=lc_ebill classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
								<param name=CBData					value="^��ü,1^����Ʈ��,2^Ʈ������,9^��Ÿ">
								<param name=CBDataColumns			value="CDCODE,CDNAM">
								<param name=SearchColumn			value="CDNAM">
								<param name=Sort					value=false>
								<param name=ListExprFormat	    	value="CDNAM^0^100">
								<param name=BindColumn				value="CDCODE">
								<param name=index					value="0">
                            </object>
                        </td>                           
                        
					</tr>
					
           			<tr>
                        <td align="center" class="text" width="90">�ΰ�������</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                            <object id=lc_staxknd classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
                        
								<param name=ComboDataID			value="ds_staxknd">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^150">
								<param name=BindColumn			value="CDCODE">

                            </object>
                        </td>
                        
                        
                        <td align="center" class="text" width="90">��ǥ����</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                            <object id=lc_fsstat classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
								<param name=CBData					value="^��ü,Y^����Ϸ�,C^�������,R^�����û,N^������,B^�ݼ�,X^����Ϸ��̿�">
								<param name=CBDataColumns			value="CDCODE,CDNAM">
								<param name=SearchColumn			value="CDNAM">
								<param name=Sort					value=false>
								<param name=ListExprFormat	    	value="CDNAM^0^100">
								<param name=BindColumn				value="CDCODE">
								<param name=index					value="0">
                            </object>
                        </td>                        
                        
                        <td align="center" class="text" width="90">���౸��</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                            <object id=lc_cocode classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
								<param name=CBData					value="^��ü,1^���ڹ���,2^�������">
								<param name=CBDataColumns			value="CDCODE,CDNAM">
								<param name=SearchColumn			value="CDNAM">
								<param name=Sort					value=false>
								<param name=ListExprFormat	    	value="CDNAM^0^100">
								<param name=BindColumn				value="CDCODE">
								<param name=index					value="0">
                            </object>
                        </td>                           
                        
					</tr>

           		</table>
            </td>	
	</tr>
	
	
	
	

  <tr>
	  <td height=10>&nbsp;
	  </td>
  </tr>
  
  
  <tr>
      <td valign="top">
          <table  border='0' cellpadding='0' cellspacing='0'>
              <tr>
                  <td valign='top' width="1000px">
                      <%=HDConstant.COMMENT_START%>
                      <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='550px' border='1'>
                          <param name="DataID"            value="ds_default">
                          <param name="ColSizing"         value="true">
                          <param name="Editable"          value="true">
                          <param name="SuppressOption"    value="1">
                          <param name="BorderStyle"       value="0">
                          <param name="ViewSummary"       value="1">
                          <param name="Format"            value="
							<C>ID=CHK,				Name='����'				width=30, 	align=center, EditStyle=CheckBox BgColor='#f5f5f5'</C>
							<C>ID=FDNAME, 			Name='����'				width=30, 	align=left,   Edit=none show=false </C>
							<C>ID=FSNUM,			Name='��ǥ��ȣ'			width=105, 	align=center, BgColor='#f5f5f5' Edit=none sort=true mask='XXXXXXXXX-XXXXXX' SumText='�հ�'</C>
							<C>ID=VEND_CD,			Name='�ŷ�ó�ڵ�'		width=80,  	align=center, BgColor='#f5f5f5' Edit=none show=false </C>
				                       
							<C>ID=VEND_NM,			Name='�ŷ�ó��'			width=95,  	align=LEFT,   BgColor='#f5f5f5' 	Edit=none sort=true </C>
							<C>ID=VEND_ID,			Name='����ڹ�ȣ'		width=90,  	align=center, mask='XXX-XX-XXXXX'	Edit=none sort=true </C>
				                         
							<C>ID=TAXSUM,			Name='���ް���'			width=85,  align=right   Edit=none sort=true  </C>		                             
							<C>ID=TAXVATAMT,		Name='�ΰ�����'			width=70,  align=right   Edit=none sort=true  </C>
							<C>ID=TAXTOT,			Name='�հ�ݾ�'			width=90,  align=right   Edit=none sort=true  </C>		                             
				                         
							<C>ID=REMARK,			Name='����'				width=135, align=LEFT    Edit=none sort=true </C>
							<C>ID=TAXKNDNM,			Name='����'	     		width=45,  align=center  Edit=none sort=true </C>
							<C>ID=GUBUN,    		Name='���౸��'	    	width=75,  align=left    sort=true show=true  EditStyle=Combo Data='1:���ڹ���,2:�������'</C>
							<C>ID=FSSTAT,			Name='��ǥ����'			width=75,  align=center  EditStyle=Combo, Data='Y:����Ϸ�,C:�������,R:�����û,N:������,B:�ݼ�' Edit=none sort=true </C>
							<C>ID=DTI_STATUS, 		Name='����'				width=75,  align=left    Edit=none sort=true show=false  EditStyle=Combo Data='A:��������,V:�������û,I:���Ź̽���,C:���Ž���,M:������ҿ�û(���޹޴���),N:������ҿ�û(������),R:���Űź�,O:��ҿϷ�,T:������ź�,W:�������û ���'</C>
							<C>ID=TAXPRTYN,			Name='���࿩��'			width=75,  align=center  EditStyle=Combo, Data='Y:����,N:�̹���' Edit=none sort=true </C>

							<C>ID=DEPTNM,			Name='���μ�'			width=75,  align=left    Edit=none sort=true show=true </C>
							<C>ID=EMPNMK,			Name='�����'			width=75,  align=center  Edit=none sort=true show=true </C>
														
							<C>ID=AMEND_CODE, 		Name='�����ڵ�'			width=75,  align=left    Edit=none sort=true show=false</C>
				
							<C>ID=TAXDAT,   		Name='��꼭����'		width=90,  align=center  Edit=none sort=true show=true   mask='XXXX-XX-XX'</C>
							<C>ID=EXTCHK,   		Name='�ܺι���'     	width=80,  align=center  Edit=none sort=true show=false</C>
							<C>ID=TAXDIVNM,			Name='�ͼӱ���'			width=80,  align=LEFT    Edit=none sort=true show=false</C>
							<C>ID=FSDAT,			Name='��������'			width=60,  align=center  Edit=none sort=true </C>
							<C>ID=FSNBR,			Name='������ȣ'			width=60,  align=center  Edit=none sort=true </C>
							<C>ID=CREATION_DATE,	Name='���Ϲ����Ͻ�'		width=150,  align=center Edit=none sort=true show=false</C>
							<C>ID=DUEDATE,  		Name='�Աݿ�����'		width=90,  align=center  Edit=none sort=true show=fals mask='XXXX-XX-XX'</C>
							<C>ID=TAXSTS,	 		Name='�������'	  		width=75,  align=center  EditStyle=Combo, Data='N:���,R:��û,Y:����,B:�ݼ�' Edit=none sort=true </C>
									                             
                       ">
                      </object>   
                      <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
            </table>
</td>
    </tr>
  
  
  
  
</table>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 