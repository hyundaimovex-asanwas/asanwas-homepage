<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ���ݰ��� - ���ݽ��� TREE 
+ ���α׷� ID	:  a400025.jsp
+ �� �� �� ��	:  ���ݽ��� ��ȸ - MGrid ����Ͽ� ó��. 
+ �� �� �� ��	:  
+ �� �� �� ��	:   
+ ��   ��  ��      :  �� �� ��
+ �ۼ� �� ��      :  2016.12.01
+ �� �� �� ��	:  
+ ���콺 ����    :  5.2 
-----------------------------------------------------------------------------
+ �� �� �� ��	:   
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
+ �� �� �� ��     :	         
+ ��   ��  ��      : 
+ �� �� �� ��     : 
+ �� �� �� ��     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���ݰ�ȹ����</title>

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

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//�����ڵ�

var gs_frdt="";
var gs_todt="";
var gs_hf_gb="";  //�ݱⱸ��
var gs_hf_seq=""; //�ݱ⳻����

var gs_upload_gb="";

<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
	gcem_dedate.text = gs_date;	
}

<%
/******************************************************************************
	Description : ����ȸ
******************************************************************************/
%>
function ln_Before(){
	gcds_acctinfo.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400010_s1?v_str1=&v_str2=&v_str3=&v_str4=&v_str5=T";                           
	gcds_acctinfo.Reset();
	
	gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield.Reset();
	
	gclx_fdcode.index=1; 
}

<%
/******************************************************************************************
	Description : ��ȸ ( ���̺� ����� Data ��ȸ )  OK
******************************************************************************************/
%>
function ln_Query(){	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400045_s1?v_str1="+gclx_fdcode.bindcolval
																	    +"&v_str2="+gcem_dedate.text;	
	gcds_data.Reset();	
	
}
<%
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Save(){
		
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){	
			gctr_data.KeyValue = "Account.a400020_t2(I:USER=gcds_data)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400020_t2?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data.text);
			gctr_data.post();
			ln_Query();			
		}	
	}
}	


<%
/******************************************************************************
	Description : ����� üũ
******************************************************************************/
%>
function ln_Chk_Save() {
	
    //�ʼ��׸� üũ 
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"ACCTNO") == ""){ 			
			alert("���¹�ȣ�� �Է��ϼ���.");
			return false;
		}
		
		if(gcds_data.namevalue(i,"ACCTCD") == ""){
			alert("�����ڵ带 Ȯ���ϼ���.");
			return false;
		}
		
		if(gcds_data.namevalue(i,"DEALDT") == ""){ 				
			alert("�ŷ��Ͻø� Ȯ���ϼ���.");
			return false;
		}
		
		if(gcds_data.namevalue(i,"CURUNIT") == ""){ 				
			alert("��ȭ�� Ȯ���ϼ���.");
			return false;
		}
		
		if(gcds_data.namevalue(i,"CURUNIT") != "WON"){ 				
			if(gcds_data.namevalue(i,"EXRATE")==0){
				alert("ȯ���� �Է��Ͻʽÿ�.");
				return false;
			}
		}
	} 
	
	return true;
}

<%
/******************************************************************************************
	Description : ����
*****************************************************************************************/
%>
function ln_Delete(){

}

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){
 
}


/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/


<%
/******************************************************************************
	Description : ���� �ٿ�ε�
******************************************************************************/
%>
function ln_Excel(){

	//gcgd_disp01.GridToExcel("���ݾ��ε�","",2);
}

<%
/******************************************************************************
Description : ���������˾�
******************************************************************************/
%>
function ln_Popup_Acctinfo(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./acctinfo_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcem_acctcd.text = arrResult[0];  // �����ڵ� 
		gcem_acctno.text = arrResult[1];  // ���¹�ȣ
	}else{
		gcem_acctcd.text = "";
		gcem_acctno.text = "";
	}
}

<%
/******************************************************************************
Description : ���ε������ �׸��� ������ ���� 
******************************************************************************/
%>
function fn_Acctcd_fix(){
	
	for(var j=1;j<=gcds_data.countrow;j++){
		for(var i=1;i<=gcds_acctinfo.countrow;i++){
			//���¹�ȣ�� �����ڵ� ã��
			if(gcds_acctinfo.namevalue(i,"ACCTNO")==gcds_data.namevalue(j,"ACCTNO")){
				gcds_data.namevalue(j,"ACCTCD")    = gcds_acctinfo.namevalue(i,"ACCTCD");
				gcds_data.namevalue(j,"RESULT")    = gcds_acctinfo.namevalue(i,"RESULT");
				gcds_data.namevalue(j,"RSTREMARK") = gcds_acctinfo.namevalue(i,"RSTREMARK");
				gcds_data.namevalue(j,"RSTSEQ")    = gcds_acctinfo.namevalue(i,"RSTSEQ");
				gcds_data.namevalue(j,"TEAM")      = gcds_acctinfo.namevalue(i,"TEAM");
				gcds_data.namevalue(j,"INRATE")    = gcds_acctinfo.namevalue(i,"INRATE");
				gcds_data.namevalue(j,"COSTCD")    = gcds_acctinfo.namevalue(i,"COSTCD");
				gcds_data.namevalue(j,"COSTNM")    = gcds_acctinfo.namevalue(i,"COSTNM");
				
			}	
		}
		
		//��ȭ ó��
	
			if(gcds_data.namevalue(j,"CURUNIT")!="WON"){
				
				gcds_data.namevalue(j,"FINAMT") =gcds_data.namevalue(j,"INAMT");
				gcds_data.namevalue(j,"FOUTAMT")=gcds_data.namevalue(j,"OUTAMT");
				gcds_data.namevalue(j,"FBALAMT")=gcds_data.namevalue(j,"BALAMT");
				gcds_data.namevalue(j,"INAMT")=0;
				gcds_data.namevalue(j,"OUTAMT")=0;
				gcds_data.namevalue(j,"BALAMT")=0;
			}
		
		//�ŷ����� �ŷ��ð�		
		gcds_data.namevalue(j,"DEDATE") = gcds_data.namevalue(j,"DEALDT").substring(0,10).replace(/-/gi,"");     
		gcds_data.namevalue(j,"DETIME") = gcds_data.namevalue(j,"DEALDT").substring(11,20).replace(/:/gi,"");
	}
	
	gs_upload_gb="";
}


<%
/******************************************************************************
Description : ȯ������� �ش���¿� ���� �ܾ� ���� 
******************************************************************************/
%>
function ln_Balamt_Sum(strAcctno,intBalamt2){
	
	alert("strAcctno::"+strAcctno+"::intBalamt2::"+intBalamt2);
	
	if(intBalamt2==undefined)intBalamt2=0;
	
	for(var i=1; i<=gcds_data.countrow; i++){
		if(strAcctno == gcds_data.namevalue(i,"ACCTNO")){

			gcds_data.namevalue(i,"BALAMT") = intBalamt2 +  gcds_data.namevalue(i,"INAMT")-gcds_data.namevalue(i,"OUTAMT");
			
			intBalamt2 = gcds_data.namevalue(i,"BALAMT");
		}
	}
}


<%
/******************************************************************************
Description : ����
******************************************************************************/
%>
function ln_Popup_Cost(strrow){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] ="0030";
	arrParam[1] = "";
	arrParam[2]="";
	arrParam[3]="";
	arrParam[4]="02";

	//2007.10.08.ȸ������ �߰�(�μ� CHGYM ����)
	//var stractdat = gcem_actdat02.text;
	arrParam[5]="201610";
	
    strURL = "./commdtil_cost_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    result = showModalDialog(strURL,arrParam,strPos);
    
    if (result != null) {
		arrResult = result.split(";");
		gcds_data.namevalue(strrow,"COSTCD")=arrResult[0];
		gcds_data.namevalue(strrow,"COSTNM") =arrResult[1];
	}else{
		gcds_data.namevalue(strrow,"COSTCD")="";
		gcds_data.namevalue(strrow,"COSTNM")="";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--�׸��� DATA -->
<object  id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="SortExpr"	    value="+RSTSEQ">
    <param name="SubsumExpr"	value="2:INOUTGB,1:RSTREMARK">
</object>

<!--�����ڵ� ���� -->
<object  id=gcds_acctinfo classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--�׸��� Data�� Table�� insert Tail -->
<object  id=gcds_tail_b classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_comfield classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data_excel classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language="javascript" for="gcds_head_a" event="onloadCompleted(row,colid)">
	//alert("gcds_head_a:row:"+row);
</script>

<script language="javascript" for="gcds_tail_b" event="onloadCompleted(row,colid)">
	//alert("gcds_tail_b:row:"+row);
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	//alert("gcds_data:row:"+row);
	if(gs_upload_gb=="1"){
		fn_Acctcd_fix();
	}
	
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!="") {		
		file_path.value = gcip_file.value;
	}
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("������ ������ ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("������ ������ ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data_excel event=OnSuccess()>
	ln_Upload_Grid();
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data_excel event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data_excel.ErrorCode + "\n" + "Error Message : " + gctr_data_excel.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Excel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Save()">
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab23" style="width:380px"><nobr>
						<comment id="__NSID__">
						<object  id=gclx_fdcode classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=ComboDataID      value="gcds_comfield">
								<param name=CBDataColumns	 value="FDCODE,FDNAME">
								<param name=SearchColumn	 value=FDNAME>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="FDNAME">								
								<param name=BindColumn		 value="FDCODE">
						</object>
					    </comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					
				    <td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�ŷ�����</nobr></td>
					<td class="tab23" style="width:380px"><nobr>
						<comment id="__NSID__">
						<object  id=gcem_dedate classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</object> 
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_dedate', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
						</nobr>
					</td>
				   
				</tr>
			</table>
		</td>
	</tr>
	<tr>
	    <td align = right>
	    	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowadd.gif"		style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_RowAdd()"></font>
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowdel.gif"		style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_RowDel()"></font>
		</td>
	</tr>

	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top>
					 	<OBJECT id=Mgcgd_disp01 classid=clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08 style="WIDTH:998px;HEIGHT:547px;border:1 solid #777777;position:relative;left:5px" viewastext>
						    <PARAM NAME="DataID"        VALUE="gcds_data">
							<Param Name="SelectedRows"	value="true">
							<Param Name="Sort"	    	value="false">
							<Param Name="ColumnInfo"	value='
						       <COLUMNINFO>
							    	<COLUMN id="COSTNM"  refcolid="COSTNM">
							    		<TREE   type="1"  expand="false"/>
							    		<HEADER left="0"  top="0" right="500" bottom="30" text="����"/>
							    		<VIEW   left="0"  top="0" right="500" bottom="30"/>
							    		<GROUP  level="2" bgcolor="#bb9999"/>
							    		<GROUP  level="1" bgcolor="#99bb99"/>
							    	</COLUMN>
							    	
							    	<COLUMN id="PLANAMT" refcolid="PLANAMT"  >
							    		<HEADER left="500" top="0"  right="650" bottom="30" text="��ȹ"/>
							    		<VIEW   left="500" top="0"  right="650" bottom="30" align="rightcenter" displayformat="#,##0" />
							    		<CHILD  type="edit"  inputtype="num" decimal="3"  editable="false" />
							    		<GROUP level="2" bgcolor="#bb9999"  align="rightcenter" displayformat="#,##0"/>
							    		<GROUP level="1" bgcolor="#99bb99"  align="rightcenter" displayformat="#,##0"/>
							    	</COLUMN>
							
									<COLUMN id="REALAMT" refcolid="REALAMT">
							    		<HEADER left="650" top="0" right="800" bottom="30"  text="����" />
							    		<VIEW   left="650" top="0" right="800" bottom="30"  align="rightcenter" displayformat="#,##0" />
							    		<CHILD type="edit" editable="false" />	
							    		<GROUP level="2" bgcolor="#bb9999"  align="rightcenter" displayformat="#,##0"/>
							    		<GROUP level="1" bgcolor="#99bb99"  align="rightcenter" displayformat="#,##0"/>
							    	</COLUMN>
							
									<COLUMN id="CUAMT" refcolid="CUAMT">
							    		<HEADER left="800" top="0" right="950"   bottom="30" text="���ϰ�ȹ"/>
							    		<VIEW   left="800" top="0" right="950"   bottom="30" align="rightcenter" displayformat="#,##0"/>
							    		<CHILD  type="edit" editable="false" />
							    		<GROUP  level="2" bgcolor="#bb9999"  align="rightcenter" displayformat="#,##0"/>
							    		<GROUP  level="1" bgcolor="#99bb99"  align="rightcenter" displayformat="#,##0"/>
							    	</COLUMN>
							     </COLUMNINFO>
						     '>
						  </object>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
	
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_head classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID			value=gcds_head_a>
	<param name=BindInfo		value='  
		<C>Col=CO_NM			Ctrl=gcem_co_nm				Param=text</C>
		<C>Col=CO_CRNO			Ctrl=gcem_co_crno	    	Param=text</C>
		<C>Col=CO_RENM	        Ctrl=gcem_co_renm			Param=text</C>
		<C>Col=CO_NO	        Ctrl=gcem_co_no   			Param=text</C>
	'>
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 