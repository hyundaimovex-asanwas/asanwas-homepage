<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �ڱݰ�����Ȳ - ��������	
+ ���α׷� ID	:  a300010.jsp
+ �� �� �� ��	:  ���������ϴ� ȭ�� 
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2016.09.26
+ ���콺 ����    : 5.2
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
<title>��������ȸ</title>

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

var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

var gs_userid = gusrid;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var gs_InsGubun=""; //��ȸ�� ��� ����
var gs_dept2="";    //�渮���úμ�

var gstrempno="";
var gstrGubun ="";
var gstrdeptcd="";
var gstrAuthgr="";

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
	gcem_enddt.text=gs_date;
	gcem_jobdt.text=gs_date;
	gcrd_bills_gb.codevalue = 1;
}


/******************************************************************************
	Description : ��ȸ
	parameter   : p - print;�ϰ��
******************************************************************************/
function ln_Query(){
		
	 if(gcrd_bills_gb.codevalue==1){	//���޾���
				
	     //������ 
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300010_s1?v_str1="+gclx_fdcode.bindcolval //����       
		                                                                        +"&v_str2="+gcem_enddt.text 	  //������ 
		                                                                        +"&v_str3="+gcem_vend_cd.text;    //�ŷ�ó         		                                           										
	     gcds_data01.Reset();
																			   
																			   
																			   
	    																
	     //������	 
	     gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300010_s2?v_str1="+gclx_fdcode.bindcolval //����                                            
		 																	   +"&v_str2="+gcem_vend_cd.text      //�ŷ�ó                                            
		 																	   +"&v_str3="+gcem_enddt.text 	      //������                                              
		 																	   +"&v_str4="+gcem_jobdt.text;       //�۾���                                                  										
	 	 gcds_data02.Reset();
	 								
	 }else if(gcrd_bills_gb.codevalue==2){ //��������
		 
		 //������ 
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300010_s4?v_str1="+gclx_fdcode.bindcolval //����       
		                                                                        +"&v_str2="+gcem_enddt.text 	  //������ 
		                                                                        +"&v_str3="+gcem_vend_cd.text;    //�ŷ�ó         		                                           										
	     gcds_data01.Reset();
																			   
																			   
																			   
	    																
	     //������	 
	     gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300010_s5?v_str1="+gclx_fdcode.bindcolval //����                                            
		 																	   +"&v_str2="+gcem_vend_cd.text      //�ŷ�ó                                            
		 																	   +"&v_str3="+gcem_enddt.text 	      //������                                              
		 																	   +"&v_str4="+gcem_jobdt.text;       //�۾���                                                  										
	 	 gcds_data02.Reset();
	 }
}
	

/******************************************************************************
	Description : ���� �� �����͸� ���� .
	parameter   : 
******************************************************************************/
function ln_Save(){
	
	//���� �����Ͱ� �������� ���� ���...��ü �����ؼ� ����.
	if(gcds_data02.CountRow<=0){
		//ln_SetDataHeader();
		gcds_data02.ImportData(gcds_data01.ExportData(1,gcds_data01.CountRow,false));
		
		for(var i =1; i<=gcds_data01.countrow;i++){
			gcds_data02.namevalue(i,"JOBDT") = gs_date;
		}
		
		//������ �Էµ� ���䰡������.
		gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300010_s3?v_str1="+gclx_fdcode.bindcolval //����                                            
																			  +"&v_str2="+gcem_vend_cd.text      //�ŷ�ó                                            
																			  +"&v_str3="+gcem_enddt.text 	     //������                                              
																			  +"&v_str4="+gcem_jobdt.text;       //�۾���                                                  										
	    gcds_data03.Reset();
		
																			  																		  
		for(var i=1; i<=gcds_data03.countrow;i++){	
			for(var j =1;j<=gcds_data02.countrow;j++){
				
				if(gcds_data03.namevalue(i,"FDCODE")==gcds_data02.namevalue(j,"FDCODE")&&
				   gcds_data03.namevalue(i,"FSDAT") ==gcds_data02.namevalue(j,"FSDAT")&&	
				   gcds_data03.namevalue(i,"FSNBR") ==gcds_data02.namevalue(j,"FSNBR")&&	
				   gcds_data03.namevalue(i,"FSSEQ") ==gcds_data02.namevalue(j,"FSSEQ")&&	
				   gcds_data03.namevalue(i,"DEAMT") ==gcds_data02.namevalue(j,"DEAMT")&&	
				   gcds_data03.namevalue(i,"CRAMT") ==gcds_data02.namevalue(j,"CRAMT")){
					
					gcds_data02.namevalue(j,"BILLSNO") = gcds_data03.namevalue(i,"BILLSNO");	
					break;
				}
			}
		}																	  																		 															  
	}
	
	if(gcds_data02.IsUpdated) {	
		if (confirm("���� �Ͻðڽ��ϱ�?")){	
			//alert("gs_userid::"+gs_userid);
			gctr_data1.KeyValue = "Account.a300010_t1(I:USER=gcds_data02)";
			gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300010_t1";
			
			//prompt('',gcds_data02.text)
			gctr_data1.Parameters = "v_str1="+gs_userid;
			gctr_data1.post();
			
			ln_Query();
		}
	}
	
	
}
/******************************************************************************
	Description : ����
	parameter   : 
******************************************************************************/
function ln_Excel(){
	//gcgd_disp01.GridToExcel("��������ȸ","",2);
}

/******************************************************************************
	Description : ���� �۾�
******************************************************************************/
function ln_Before() {
  	//��������
	gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield.Reset();
}

/******************************************************************************
	Description : Dataset Head ���� - ��ǥ Detail
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(){
    var s_temp="";

	if (gcds_data02.countrow<1){
	    s_temp="";
		s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,FSSEQ:ATCODE,"
			   + "PAYDT:STRING,ENDDT:STRING,REMARK:STRING,DEAMT:DECIMAL,CRAMT:DECIMAL,"
			   + "SSDAT:STRING,SSNBR:STRING,VEND_CD:STRING,VEND_NM:STRING";
		gcds_data02.SetDataHeader(s_temp);
	}
}

/******************************************************************************
 Description :�����˾�
  parameter   : 
******************************************************************************/
function ln_Popup_Atcode(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";	
	arrParam[1]=txt_atkornam.value;
	arrParam[2]="";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(arrResult != null) {
	    arrParam = arrResult.split(";");
		txt_atcode.value   = arrParam[0];
		txt_atkornam.value = arrParam[1];
	}else{	 
		txt_atcode_to.text = "";
		txt_atkornam_to.value = "";					
	}
}

/******************************************************************************
	Description : �ŷ�ó
	parameter   : 
******************************************************************************/
function ln_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./gczm_vender_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcem_vend_cd.text = arrResult[0];
		gcem_vend_nm.text = arrResult[1];
	}else{
		gcem_vend_cd.text = "";
		gcem_vend_nm.text = "";
	}
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
<object  id=gcds_data01 classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB" VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object> 

<object  id=gcds_data02 classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB" VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object> 

<object  id=gcds_data03 classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB" VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object> 

<!-- �������� -->
<object  id=gcds_comfield classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB" VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object> 


<object  id="gcds_tempmst" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object> 

</comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gctr_data1 classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_comfield" event="onloadCompleted(row,colid)">
		gcds_comfield.insertrow(1);
		gcds_comfield.namevalue(1,"FDCODE") = "";
		gcds_comfield.namevalue(1,"FDNAME") = "��ü";
		gclx_fdcode.bindcolval = gs_fdcode;
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gctr_data1" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_data1" event="onfail()">

	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
		<td>
			<table width="1070" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td height ="'vAlign="center"><strong><h4>* </h4></strong></td>
					<td width="685" align="right"  style="padding-top:4px;"> 
					    
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"    style="position:relative;right:5px;cursor:hand" onclick="ln_Query()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	 style="position:relative;right:5px;cursor:hand" onClick="ln_Save()">
					</td>
				</tr>
			</table>
			
			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:1070px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr> 
								<td width="100px"  style="height:30px" bgcolor="#eeeeee" class="tab15" align=center ><nobr>����</nobr></td>
								<td class="tab18"  style="width:200px;"><nobr>&nbsp;
									<comment id="__NSID__">
										<object  id=gclx_fdcode classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197  style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
												<param name=ComboDataID      value="gcds_comfield">
												<param name=CBDataColumns	 value="FDCODE,FDNAME">
												<param name=SearchColumn	 value=FDNAME>
												<param name=Sort			 value=false>
												<param name=ListExprFormat   value="FDNAME">								
												<param name=BindColumn		 value="FDCODE">
												<param name=enable		 value="true">
										</object>
									</comment><script>__ws__(__NSID__);</script></nobr>
								
								</td>        
                				<td width="100px"  bgcolor="#eeeeee" class="tab18" align=center ><nobr>�ŷ�ó</nobr></td>
								<td class="tab18"  colspan=3><nobr>&nbsp;&nbsp;
									<comment id="__NSID__">
										<object  id=gcem_vend_nm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:170px;height:20px;position:relative;left:-3px;top:2px" >		
											<param name=Text					value="">
											<param name=Border        value=true>
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
											<param name=Language			value=1>
										</object></comment><script>__ws__(__NSID__);</script>
										<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup()">
									
									<comment id="__NSID__">
										<object id=gcem_vend_cd classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:90px">
											<param name=Text				value="">
											<param name=Alignment		value=0>
											<param name=Border			value=true>
											<param name=Format			value="#############">
											<param name=PromptChar	value="_">
											<param name=Enable			value="false">
										</object>
									</comment><script>__ws__(__NSID__);</script></nobr>
								</nobr>
								</td> 
							 </tr>
							 <tr> 
								<td width="100px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>������</nobr></td>
								<td class="tab19" ><nobr>&nbsp;
									<comment id="__NSID__">
										<object  id=gcem_enddt classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text		  value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 	</object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_enddt', 'Text')" style="position:relative;width:20px;top:4px;cursor:hand;">
									 <font size="2" color="blue">����</font>
								</td>

								<td width="100px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�۾���</nobr></td>
								<td class="tab19" ><nobr>&nbsp;
									<comment id="__NSID__">
										<object  id=gcem_jobdt classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text		  value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 	</object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_jobdt', 'Text')" style="position:relative;width:20px;top:4px;cursor:hand;">
								</td>
								
								<td width="100px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>��������</nobr></td>
								<td class="tab19" ><nobr>&nbsp;
									<comment id="__NSID__">
										<object id=gcrd_bills_gb classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:24; width:200">
											<param name=Cols	    value="2">
											<param name=Format	value="1^���޾���,2^��������">
										</object>
									</comment><script>__ws__(__NSID__);</script>
								</nobr>
								</td>								
							</tr>
					 </table>
					</td>
				</tr>  	
			</table>

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
				<tr>
					<td>
						<table>
							<tr><td><font size="2" color="blue" ><strong>[������] - ����</strong></font></td></tr>
							
							<tr> 			
								<td style="width:280" ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_disp01  
										style="position:relative;left:3px;width:330px; height:500px; border:1 solid #708090;display:block;" viewastext>
											<PARAM NAME="DataID"		VALUE="gcds_data01">
											<PARAM NAME="IndWidth"		VALUE ='0'>
											<PARAM NAME="BorderStyle"   VALUE="0">
											<PARAM NAME="Fillarea"		VALUE="true">
											<PARAM NAME="Sortview"		VALUE="left">
											<param name="ViewSummary"	value=1>
											<param name="ColSizing"      value="true">
											<param name="Editable"      value="false">
											<PARAM NAME="Format"		VALUE="  
											<C> Name='��������'	 ID=ENDDT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	edit=none sort=false  SumBgColor=#C3D0DB MASK='XXXX/XX/XX'</C>
											<C> Name='�ŷ�ó'	     ID=VEND_NM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=left    edit=none sort=false  SumBgColor=#C3D0DB </C>
											<C> Name='����'		 ID=REMARK	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=left	edit=none sort=false  SumBgColor=#C3D0DB </C> 								
											<C> Name='�ݾ�'	     ID=JANAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right   edit=none sort=false  SumBgColor=#C3D0DB  SumText=@sum</C> 
				
											">
									</object></comment><script>__ws__(__NSID__);</script>   
									<fieldset style="position:relative;left:3px;width:332px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
										&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
									</fieldset>
								</td>
							</tr>
						</table>
			    </td>
			    <td>&nbsp;</td>
			    <td>
			    <table>
				<tr><td><font size="2" color="blue" ><strong>[������] - �۾����ں� ��������</strong></font></td></tr>
				
				<tr> 			
					<td style="width:280" ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object  classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_disp01  
							style="position:relative;left:3px;width:720px; height:500px; border:1 solid #708090;display:block;" viewastext>
								<PARAM NAME="DataID"		VALUE="gcds_data02">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="BorderStyle"   VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<param name="ViewSummary"	value=1>
								<param name="ColSizing"     value="true">
								<param name="Editable"      value="true">
								<PARAM NAME="Format"		VALUE="  
								
								<C> Name='�۾�����'	 ID=JOBDT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	 edit=none sort=false  SumBgColor=#C3D0DB MASK='XXXX/XX/XX'</C>
								<C> Name='��������'	 ID=ENDDT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	 edit=none sort=false  SumBgColor=#C3D0DB MASK='XXXX/XX/XX'</C>
								<C> Name='�ŷ�ó'	     ID=VEND_NM   HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left     edit=none sort=false  SumBgColor=#C3D0DB </C>
								<C> Name='����'		 ID=REMARK	  HeadAlign=Center HeadBgColor=#B9D4DC Width=190  align=left	 edit=none sort=false  SumBgColor=#C3D0DB </C> 								
								<C> Name='�ݾ�'	     ID=JANAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right    edit=none sort=false  SumBgColor=#C3D0DB SumText=@sum</C> 
								<C> Name='������ȣ'	 ID=BILLSNO	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center              sort=false SumBgColor=#C3D0DB BgColor=#CCFFCC  </C> 
								<C> Name='��ǥ����'  	 ID=SSDAT     HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=center    edit=none  sort=false SumBgColor=#C3D0DB  </C>
								<C> Name='��ǥ��ȣ'  	 ID=SSNBR	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center    edit=none  sort=false SumBgColor=#C3D0DB   </C>
								">
						</object></comment><script>__ws__(__NSID__);</script>   
						<fieldset style="position:relative;left:3px;width:722px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
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
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 