<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	���Ը�����ȸ 
+ ���α׷� ID	: A040058
+ �� �� �� ��	: ��ȸ|����
+ ��   ��  ��	: �� �� �� 
+ �� �� �� �� : 2013.05.23 
+ �� �� �� ��	:
------------------------------------------------------------------------------
+ �� �� �� ��   : ������� �߰� 
+ ��   ��  ��    : JYS
+ �� �� �� ��   : 2017.06.23
+ �� �� �� ��   :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���Ը�����ȸ</title>

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
var gs_fdcode = gfdcode;

var gstrempno="";
var gstrdeptcd="";
var gstrGubun ="";
var gstrAuthgr="";
var gstrRowpos="";

var gs_sm_call_status=""; // ȣ�� asp ����

/******************************************************************************
 ȭ�� �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    ln_Before();
	ln_Query_Authority2();
	
	 sp7.style.display = ""; //���ݰ�꼭����
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){ 
	gclx_fsstat.index = 0;//��ǥ����
	//gclx_cocode.BindColVal	= "02";							//�����
	gcem_staxdatfr.text			= gs_date2 + "01";	//��꼭�Ⱓ from
	gcem_staxdatto.text			= gs_date;					//��꼭�Ⱓ to

	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	//�ŷ�ó�ڵ�[�˻�]  
	//gcds_vendcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>vendcode_s1?v_str1="; 
	//gcds_vendcd.Reset();
	
	//�ͼӱ���[����]
	//gcds_staxdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	//gcds_staxdiv.Reset();

	//�ͼӱ���[����]
	//gcds_staxdiv2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1215"; 
	//gcds_staxdiv2.Reset();

	//�ΰ�������[����]
	gcds_staxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	gcds_staxknd.Reset();

	//�ΰ�������[����]
	gcds_staxknd2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0009"; 
	gcds_staxknd2.Reset();
}


/******************************************************************************
 ��ȸ���� �ű�
******************************************************************************/
function ln_Query_Authority2(){
	gcds_empno_chk.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_s1?v_str1=&v_str2="+gs_userid+"&v_str3=A1500058&v_str4=Y";
	gcds_empno_chk.Reset();
}

/******************************************************************************
 ��ȸ���� ��� return 
******************************************************************************/
function ln_Authority_Result(row,colid){
  var cnt=0;
  gstrempno="'"+gs_userid+"',";

	if(row>0){
    //���ѱ׷�
		gstrAuthgr=gcds_empno_chk.namevalue(row,"AUTHGR");
	
    //�μ�(6-14), ���(15-19)
		//�μ�(6-25), ���(26-30)
    for(i=6;i<=30;i++){
			if(i<=25){		  
				if(gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))!=""){ //�μ����� 
					cnt+=1;
					gstrdeptcd+="'"+gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))+"',"				
				}			
			}

			if(i>=26){
        if(gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))!=""){ //������� 
					gstrempno+="'"+gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))+"',"				
				}
			}
		}

		if(cnt>0){
		  //2011.03.10 �μ� �Ǿհ� �ǵ��� �̱��ڵ�� ����
			gstrdeptcd=gstrdeptcd.substring(1,gstrdeptcd.length-2);
		}
		//2011.03.10 ��� �Ǿհ� �ǵ��� �̱��ڵ�� ����
		gstrempno=gstrempno.substring(1,gstrempno.length-1);
	}

	if(gstrAuthgr=="A"){
		gstrGubun = gstrAuthgr;
	}else{
		gstrGubun="";
	}
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
		var str22 = gclx_taxsts.bindcolval;      //�������
		
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
											+"&v_str19="+str19+"&v_str21="+str21
    										+"&v_str22="+str22;
											
		//prompt('',gcds_data.DataID);
		gcds_data.Reset();
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

	if (gcds_data.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
	else gcgd_data.GridToExcel("���Ը������","",2);

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
<comment id="__NSID__">
<object  id="gcds_data" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  <PARAM NAME="UseFilter" VALUE="true">
</object>

<object  id=gcds_empno_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id="gcds_fdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �����ڵ�[�˻�] -->
</object> 

<object  id="gcds_staxknd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �ΰ�������[����] -->
</object> 

<object  id="gcds_staxknd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �ΰ�������[����] -->
</object> 

<object id=gcds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script> 


<!---------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
	<object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
    </object>     
 </comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(row,colid)>
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
	if (row<1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_empno_chk" event="onloadCompleted(row,colid)">
		ln_Authority_Result(row,colid);
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	gclx_fdcode.bindcolval=gs_fdcode;
</script>

<script language="javascript" for="gcds_staxknd" event="onloadCompleted(row,colid)">
	gcds_staxknd.InsertRow(1);
	gcds_staxknd.NameValue(1,"CDCODE")="";
	gcds_staxknd.NameValue(1,"CDNAM")="��ü";
	
	gcds_staxknd.AddRow();
	gcds_staxknd.NameValue(gcds_staxknd.rowposition,"CDCODE")="9";
	gcds_staxknd.NameValue(gcds_staxknd.rowposition,"CDNAM")="���ݰ�꼭";

	gcds_staxknd.AddRow();
	gcds_staxknd.NameValue(gcds_staxknd.rowposition,"CDCODE")="6";
	gcds_staxknd.NameValue(gcds_staxknd.rowposition,"CDNAM")="���ݰ�꼭+��Ÿ";

	gclx_staxknd.index=0;
</script>

<script language="javascript" for="gcds_staxknd2" event="onloadCompleted(row,colid)">
	gcds_staxknd2.InsertRow(1);
	gcds_staxknd2.NameValue(1,"CDCODE")="";
	gcds_staxknd2.NameValue(1,"CDNAM")="��ü";
 
	gcds_staxknd2.AddRow();
	gcds_staxknd2.NameValue(gcds_staxknd2.rowposition,"CDCODE")="9";
	gcds_staxknd2.NameValue(gcds_staxknd2.rowposition,"CDNAM")="���ݰ�꼭";


	gclx_staxknd_2.index=0;


</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for="gclx_staxiodiv" event="OnSelChange2()">
	if (gclx_staxiodiv.bindcolval == "1") {	//�ΰ�������[����]
		document.all.gclx_staxknd.style.display='block';
		document.all.gclx_staxknd_2.style.display='none';
	}else if(gclx_staxiodiv.bindcolval == "2") {
		document.all.gclx_staxknd.style.display='none';
		document.all.gclx_staxknd_2.style.display='block';
	}
</script>

<script language="javascript"  for=gcgd_data  event="OnDblClick(Row,Colid)">
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();
	
	var strParam = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR").substring(0,1);
	arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR");

	//arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR").substring(0,1);
	//arrParam[1] = gcds_data.namevalue(gcds_data.rowposition,"FDCODE");
	//arrParam[2] = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR").substring(1,11);

    //strURL = "./staxbill_popup_2_ee_a.jsp";
	//strURL = "./staxbill_popup_ee.jsp";
	//strPos = "dialogWidth:888px;dialogHeight:650px;status:no;scroll:no;resizable:no";
	
	if(strParam=="A"||strParam=="C"||strParam=="E"||strParam=="G"||strParam=="J"){
		strURL = "./a040110_popup.jsp";
		
	}else if(strParam=="B"||strParam=="D"||strParam=="F"||strParam=="H"||strParam=="K"){
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

<script language=JavaScript for=gctr_data event=OnSuccess()>
	ln_SM_Call(gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"),
	                  gcds_return.namevalue(gcds_return.rowposition,"ID"),
					  gcds_return.namevalue(gcds_return.rowposition,"PASS"));
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</head>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
		<td><img src="../img/a040059_head.gif"></td>
        <td width="685" align="right" background="../../Common/img/com_t_bg.gif">
			<nobr>
			
			<span id=sp7 style="display:none;"> <!-- ���ݰ�꼭���� -->
				<img src="../../Common/img/btn/com_b_bill_view.gif"     style="cursor:hand" onclick="ln_Bill_View()">
			</span>
			
			<img src="../../Common/img/btn/com_b_taxselect.gif"  style="cursor:hand"   onclick="ln_Slipno()">
			<img src="../../Common/img/btn/com_b_excel.gif"	     style="cursor:hand"   onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"	     style="cursor:hand"   onclick="ln_Query()">
			</nobr>
		</td>
  </tr>
	<tr><td height=4></td></tr>
</table>

<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>
		<td>
			<table cellpadding="1" cellspacing="0" border="0" style='position:relative;left:3px;width:877px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>�����ڵ�</nobr></td>
					<td width="115px;" class="tab21">
						<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_fdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
              				<param name=Enable              value="true">
							<param name=ListExprFormat	    value="FDNAME^0^100">
							<param name=BindColumn			value="FDCODE">
							<param name=Index               value="2">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>  
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;�����&nbsp;</nobr></td>
					<td width="115px;" class="tab21">
            		<nobr>
						<comment id="__NSID__"><object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="^��ü,01^��,02^����,04^ȫ��">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;��꼭�Ⱓ&nbsp;</nobr></td>
					<td width="407px"class="tab22" colspan=3><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>
<!-- 			<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;���࿩��&nbsp;</nobr></td>
					<td width="115px" class="tab22">
						<comment id="__NSID__"><object  id=gclx_taxprtyn2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData					value="^��ü,Y^����,N^�̹���">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
 -->				
        </tr>
				<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>�ŷ�ó�ڵ�</nobr></td>
					<td width="170px;" class="tab21" colspan="5"><nobr>
						<comment id="__NSID__"><object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:250px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit     value="true">
								<param name=PromptChar	    value="_">
							</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup()">
						<comment id="__NSID__"><object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	    value="_">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img name="btn_clear" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm.text='';gcem_vendcd.text='';">
							
					</td>
					
					<td width="80px"  class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;�ۼ���&nbsp;</nobr></td>
					<td width="180px" class="tab22"  ><nobr>
						<comment id="__NSID__">
						   <object  id=gcem_empno  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:150px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit     value="true">
								<param name=Enable          value=false>
								<param name=PromptChar	    value="_">
							</object>
						</comment><script>__ws__(__NSID__);</script> &nbsp;
						<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup_Empno()">
					</td>
				</tr>
				<tr> 
					<td width="80px"   class="tab11" bgcolor="#eeeeee"><nobr>���Ը��ⱸ��</nobr></td>
					<td width="110px;" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxiodiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="1^����,2^����">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>  
					<td width="80px"  class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;�ΰ�������&nbsp;</nobr></td>
					<td width="110px" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxknd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:150px;display:block">
							<param name=ComboDataID			value="gcds_staxknd"><!-- ���Ա���:0013 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value=CDNAM>
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxknd_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:150px;display:none">
							<param name=ComboDataID			value="gcds_staxknd2"><!-- ���ⱸ��:0009 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value=CDNAM>
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<!-- <td width="80px"  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;�ͼӱ���&nbsp;</nobr></td>
					<td width="200px" class="tab23"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:block">
							<param name=ComboDataID			value="gcds_staxdiv">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^130">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxdiv_3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:none">
							<param name=ComboDataID			value="gcds_staxdiv2">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^130">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td> -->
					<td width="80px"  class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;��ǥ����&nbsp;</nobr></td>
					<td width="110px" class="tab22" ><nobr>
						<comment id="__NSID__"><object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="^��ü,Y^����Ϸ�,C^�������,R^�����û,N^������,B^�ݼ�,X^����Ϸ��̿�">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>

					<td width="80px"   class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;���౸��&nbsp;</nobr></td>
					<td width="180px"  class="tab22"  ><nobr>
						<comment id="__NSID__"><object  id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="^��ü,1^���ڹ���,2^�������">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>

				</tr>
				<tr> 
					<td width="80px" class="tab12" bgcolor="#eeeeee"><nobr>eBill����</nobr></td>
					<td  class="tab23"  ><nobr>
						<comment id="__NSID__"><object  id=gclx_ebillgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="^��ü,1^����Ʈ��,2^Ʈ������,9^��Ÿ">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
						</nobr>
					</td>
					
					<td width="80px" class="tab12" bgcolor="#eeeeee"><nobr>�������</nobr></td>
					<td width="370px;"  colspan="5"><nobr>
						<comment id="__NSID__">
							<object  id=gclx_taxsts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:100px;height:100px;">
								<param name=CBData			    value="^��ü,N^���,R^��û,Y^����,B^�ݼ�">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="true">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
							</object>
						</comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
				</tr>
       <!--  <tr> 
					<td width="80px" class="tab12" bgcolor="#eeeeee"><nobr>�����ڵ�</nobr></td>
					<td width="370px;"  colspan="6"><nobr>
						<comment id="__NSID__">
							<object  id=gclx_amend_code2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:3px;top:0px;font-size:12px;width:170px;height:200px;">
								<param name=CBData					value="^'��ü',01^��������� ����������,02^���ް��� ����,03^ȯ��,04^����� ����,05^�����ſ��� ���� ����">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDCODE^0^30,CDNAM^0^153">
								<param name=BindColumn			value="CDCODE">
  						</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
					<td align = right>
					  <nobr>
						<span id=sp0 style="display:none;">
							<img name="btn_p0_2" src="../../common/img/btn/com_b_save.gif"	style="position:relative;cursor:hand"	onclick="ln_Save()"> 
						</span>
						</nobr>
					</td>
				</tr> -->
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="865" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
        <tr> 
          <td style="width:865" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:355;width:875" >
              				<PARAM NAME="DataID"			VALUE="gcds_data">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="viewSummary"   VALUE="1">
							<PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="BorderStyle"   VALUE="0">
							<param name="IndWidth"      value="0">
							<param name="Fillarea"		VALUE="true">
							<Param Name="UsingOneClick" value="1">
							<PARAM NAME="Format"		VALUE=" 
							<F>ID=CHK,		Name='����'			,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=CheckBox BgColor='#f5f5f5' SumBgColor=#C3D0DB</F>
							<F>ID=FDNAME, 	Name='����'		    ,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   Edit=none sort=false SumBgColor=#C3D0DB</F>
							<F>ID=FSNUM,	Name='��ǥ��ȣ'		,width=105,HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true mask='XXXXXXXXX-XXXXXX' SumText='�հ�'  SumBgColor=#C3D0DB</F>
							<C>ID=VEND_CD,	Name='�ŷ�ó�ڵ�'	    ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true show=false SumBgColor=#C3D0DB</C>
							<C>ID=VEND_NM,	Name='�ŷ�ó��'		,width=95, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT,   BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=VEND_ID,	Name='����ڹ�ȣ'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXX-XX-XXXXX',Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=TAXSUM,	Name='���ް���'		,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=TAXVATAMT,Name='�ΰ�����'		,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=TAXTOT,	Name='�հ�ݾ�'		,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=REMARK,	Name='����'			,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=TAXKNDNM,	Name='����'	        ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=GUBUN,    Name='���౸��'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='1:���ڹ���,2:�������'</C>
							<C>ID=FSSTAT,	Name='��ǥ����'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:����Ϸ�,C:�������,R:�����û,N:������,B:�ݼ�' Edit=none sort=true SumBgColor=#C3D0DB</C>
                            <C>ID=DTI_STATUS, Name='����'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='S:��������,A:��������,V:�������û,I:���Ź̽���,C:���Ž���,M:������ҿ�û(���޹޴���),N:������ҿ�û(������),R:���Űź�,O:��ҿϷ�,T:������ź�,W:�������û ���'</C>
							<C>ID=TAXPRTYN,	Name='���࿩��'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:����,N:�̹���' Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=EMPNMK,	Name='�����'		    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
							<C>ID=DEPTNM,	Name='���μ�'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
							<C>ID=AMEND_CODE, Name='�����ڵ�'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB </C>
							<C>ID=TAXCDNBR, Name='�ſ�ī���ȣ'	,width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center    Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XXXX-XXXX-XXXX'</C>
							<C>ID=TAXDAT,   Name='��꼭����'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>
							<C>ID=EXTCHK,   Name='�ܺι���'       ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  </C>
							<C>ID=TAXDIVNM,	Name='�ͼӱ���'		,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=FSDAT,	Name='��������'		,width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=FSNBR,	Name='������ȣ'		,width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=CREATION_DATE,	  Name='���Ϲ����Ͻ�'	,width=150, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=DUEDATE,  Name='�Աݿ�����'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB mask='XXXX-XX-XX'</C>
							<C>ID=TAXSTS,	 Name='�������'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='N:���,R:��û,Y:����,B:�ݼ�' Edit=none sort=true SumBgColor=#C3D0DB</C>
							">
            		</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 