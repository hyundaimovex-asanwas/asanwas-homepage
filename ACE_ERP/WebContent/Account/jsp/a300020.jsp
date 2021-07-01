<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  자금관리현황 - 만기일별 어음 집계현황	
+ 프로그램 ID	:  a300020.jsp
+ 기 능 정 의	:  어음 집계하는 화면 
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2016.09.27
+ 가우스 버젼    : 5.2
-----------------------------------------------------------------------------
+ 수 정 내 용 :	   
+ 수   정  자 :
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>계정별조회</title>

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
	Description : 페이지 로딩
******************************************************************************/

var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

var gs_userid = gusrid;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var gs_InsGubun=""; //조회와 등록 구분
var gs_dept2="";    //경리관련부서

var gstrempno="";
var gstrGubun ="";
var gstrdeptcd="";
var gstrAuthgr="";

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
	gcem_enddt.text=gs_date;
	gcem_jobdt.text=gs_date;
	gcrd_bills_gb.codevalue = 1;
}


/******************************************************************************
	Description : 조회
	parameter   : p - print;일경우
******************************************************************************/
function ln_Query(){
		
		
	 if(gcrd_bills_gb.codevalue==1){	//지급어음
		
	     //저장전 
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300020_s1?v_str1="+gclx_fdcode.bindcolval //지점      
		                                                                       +"&v_str2="+gcem_enddt.text	      //만기일    
																			   +"&v_str3="+gcem_jobdt.text;	      //작업일                                              															  
	     gcds_data01.Reset();
															   															       																
	     //저장후	 
	     gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300020_s2?v_str1="+gclx_fdcode.bindcolval //지점                                                                    
		 																	   +"&v_str2="+gcem_enddt.text 	      //만기일                                              
		 																	   +"&v_str3="+gcem_jobdt.text;       //작업일 
	 	 gcds_data02.Reset();
	 }else if(gcrd_bills_gb.codevalue==2){ //받을어음
		 
		 //저장전 
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300020_s4?v_str1="+gclx_fdcode.bindcolval //지점                                            												                                   
		                                                                       +"&v_str2="+gcem_enddt.text	      //만기일    
				                                                               +"&v_str3="+gcem_jobdt.text;	      //작업일                                              															  
	     gcds_data01.Reset();
									
	    																	   
																		   															       																
	     //저장후	 
	     gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300020_s5?v_str1="+gclx_fdcode.bindcolval //지점                                                                    
		 																	   +"&v_str2="+gcem_enddt.text 	      //만기일                                              
		 																	   +"&v_str3="+gcem_jobdt.text;       //작업일 
	 	 gcds_data02.Reset();
		 
	 }		 																	  
	 																																	 
}
	

/******************************************************************************
	Description : 저장 전 데이터를 저장 .
	parameter   : 
******************************************************************************/
function ln_Save(){
	
		
	//if(gcrd_bills_gb.codevalue==1){	//지급어음
		//최초 데이터가 존재하지 않을 경우...전체 복사해서 저장.
		if(gcds_data02.CountRow<=0){
			
			//alert("1");
			//ln_SetDataHeader();
			gcds_data02.ImportData(gcds_data01.ExportData(1,gcds_data01.CountRow,false));
			for(var i =1; i<=gcds_data01.countrow;i++){
				gcds_data02.namevalue(i,"JOBDT") = gs_date;
				gcds_data02.namevalue(i,"FDCODE") = gclx_fdcode.bindcolval;
				gcds_data02.namevalue(i,"GUBUN") = gcds_data01.namevalue(i,"GUBUN")
			}
			
			gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300020_s3?v_str1="+gclx_fdcode.bindcolval //지점                                                                             
																				  +"&v_str2="+gcem_enddt.text 	     //만기일                                              
																				  +"&v_str3="+gcem_jobdt.text;       //작업일                                                  										
            gcds_data03.Reset();
			
			for(var i=1; i<=gcds_data03.countrow;i++){	
				for(var j =1;j<=gcds_data02.countrow;j++){
					
					if(gcds_data03.namevalue(i,"FDCODE")==gcds_data02.namevalue(j,"FDCODE")&&	
					   gcds_data03.namevalue(i,"ENDDT") ==gcds_data02.namevalue(j,"ENDDT")&&	
					   gcds_data03.namevalue(i,"DEAMT") ==gcds_data02.namevalue(j,"DEAMT")&&	
					   gcds_data03.namevalue(i,"CRAMT") ==gcds_data02.namevalue(j,"CRAMT")){
					   	gcds_data02.namevalue(j,"REMARK") = gcds_data03.namevalue(i,"REMARK");	
					   	break;
					}
				}
			}										
		}
		
		if(gcds_data02.IsUpdated) {
			//alert("3");
			if (confirm("저장 하시겠습니까?")){	
				//alert("gs_userid::"+gs_userid);
				gctr_data1.KeyValue = "Account.a300020_t1(I:USER=gcds_data02)";
				gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300020_t1";
				
				//prompt('',gcds_data02.text)
				gctr_data1.Parameters = "v_str1="+gs_userid;
				gctr_data1.post();
				
				ln_Query();
			}
		}
	//}else if(gcrd_bills_gb.codevalue==2){
		
		
	//}
}
/******************************************************************************
	Description : 엑셀
	parameter   : 
******************************************************************************/
function ln_Excel(){
	//gcgd_disp01.GridToExcel("계정별조회","",2);
}

/******************************************************************************
	Description : 지점 작업
******************************************************************************/
function ln_Before() {
  	//지점구분
	gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield.Reset();
}

/******************************************************************************
	Description : Dataset Head 설정 - 전표 Detail
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
 Description :계정팝업
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
	Description : 거래처
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


function ln_Print(){
	if(gcrd_bills_gb.codevalue==1){	//지급어음
		gcrp_print.preview();	
	}else if(gcrd_bills_gb.codevalue==2){ //받을어음
		gcrp_print2.preview();
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

<!-- 지점구분 -->
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
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_comfield" event="onloadCompleted(row,colid)">
		gcds_comfield.insertrow(1);
		gcds_comfield.namevalue(1,"FDCODE") = "";
		gcds_comfield.namevalue(1,"FDNAME") = "전체";
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
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_data1" event="onfail()">

	alert("작업이 성공적으로 완료되지 못했습니다.");
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
			<table width="1045" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td height ="'vAlign="center"><strong><h4>* </h4></strong></td>
					<td width="685" align="right"  style="padding-top:4px;"> 
					    
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"    style="position:relative;right:5px;cursor:hand" onclick="ln_Query()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	 style="position:relative;right:5px;cursor:hand" onClick="ln_Save()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_print.gif"	 style="position:relative;right:5px;cursor:hand" onClick="ln_Print()">
					</td>
				</tr>
			</table>
			
			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:1045px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr> 
								<td width="100px"  style="height:30px" bgcolor="#eeeeee" class="tab15" align=center ><nobr>지점</nobr></td>
								<td class="tab18"  style="width:100px;"><nobr>&nbsp;
									<comment id="__NSID__">
										<object  id=gclx_fdcode classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197  style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
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
                				<td width="100px"  bgcolor="#eeeeee" class="tab18" align=center ><nobr>만기일</nobr></td>
								<td class="tab18"  ><nobr>&nbsp;&nbsp;
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
									 <font size="2" color="blue">이후</font>			
								</nobr>
								</td> 
								
								<td width="100px" style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>작업일</nobr></td>
								<td class="tab18" ><nobr>&nbsp;
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
								
								<td width="100px" style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>어음구분</nobr></td>
								<td class="tab18" ><nobr>&nbsp;
									<comment id="__NSID__">
										<object id=gcrd_bills_gb classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:24; width:140">
											<param name=Cols	    value="2">
											<param name=Format	value="1^지급어음,2^받을어음">
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
							<tr><td><font size="2" color="blue" ><strong>[저장전] - 작업일자별 어음원장 </strong></font></td></tr>
							
							<tr> 			
								<td style="width:270" ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_disp01  
										style="position:relative;left:3px;width:420px; height:500px; border:1 solid #708090;display:block;" viewastext>
											<PARAM NAME="DataID"		VALUE="gcds_data01">
											<PARAM NAME="IndWidth"		VALUE ='0'>
											<PARAM NAME="BorderStyle"   VALUE="0">
											<PARAM NAME="Fillarea"		VALUE="true">
											<PARAM NAME="Sortview"		VALUE="left">
											<param name="ViewSummary"	value=1>
											<param name="ColSizing"     value="true">
											<param name="Editable"      value="false">
											<PARAM NAME="Format"		VALUE="  
											<C> Name='No.'		 ID={CURROW}  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	      align=center	</C>  
											<C> Name='작업일자'	 ID=JOBDT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	      align=center	edit=none sort=false  SumBgColor=#C3D0DB MASK='XXXX/XX/XX'</C>
											<C> Name='만기일자'	 ID=ENDDT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	      align=center	edit=none sort=false  SumBgColor=#C3D0DB MASK='XXXX/XX/XX'</C> 								
											<C> Name='금액'	     ID=JANAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100      align=right   edit=none sort=false  SumBgColor=#C3D0DB  SumText=@sum</C> 
				                            <C> Name='비고'	     ID=''  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90      align=right   edit=none sort=false  SumBgColor=#C3D0DB  </C>  
				                             
											">
									</object></comment><script>__ws__(__NSID__);</script>   
									<fieldset style="position:relative;left:3px;width:422px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
										&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
									</fieldset>
								</td>
							</tr>
						</table>
			    </td>
			    <td>&nbsp;</td>
			    <td>
			    <table>
				<tr><td><font size="2" color="blue" ><strong>[저장후] 작업일자별 어음집계</strong></font></td></tr>
				
				<tr> 			
					<td style="width:280" ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object  classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_disp01  
							style="position:relative;left:3px;width:605px; height:500px; border:1 solid #708090;display:block;" viewastext>
								<PARAM NAME="DataID"		VALUE="gcds_data02">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="BorderStyle"   VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<param name="ViewSummary"	value=1>
								<param name="ColSizing"     value="true">
								<param name="Editable"      value="true">
								<PARAM NAME="Format"		VALUE="  
								<C> Name='No.'		 ID={CURROW}   HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center	</C>  
								<C> Name='작업일자'	 ID=JOBDT	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    align=center	 edit=none sort=false  SumBgColor=#C3D0DB MASK='XXXX/XX/XX'</C>
								<C> Name='만기년월'	 ID=ENDYM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=60    align=center	 edit=none sort=false  SumBgColor=#C3D0DB suppress=2  </C>
								<C> Name='만기일자'	 ID=ENDDT	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    align=center	 edit=none sort=false  SumBgColor=#C3D0DB MASK='XXXX/XX/XX'</C>
								<C> Name='적요'		 ID=REMARK	   HeadAlign=Center HeadBgColor=#B9D4DC Width=150   align=left	               sort=false  SumBgColor=#C3D0DB bgcolor=#FFFFBF </C> 								
								<C> Name='금액'	     ID=JANAMT	   HeadAlign=Center HeadBgColor=#B9D4DC Width=95    align=right      edit=none sort=false  SumBgColor=#C3D0DB SumText=@sum</C> 
								<C> Name='합계'	     ID=JANAMT_SUM HeadAlign=Center HeadBgColor=#B9D4DC Width=95    align=right      edit=none sort=false  SumBgColor=#C3D0DB suppress=1</C> 
								  
								">
						</object></comment><script>__ws__(__NSID__);</script>   
						<fieldset style="position:relative;left:3px;width:607px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
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
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__"><object id="gcrp_print" classid="clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089"> 
	<param name="MasterDataID"			    value="gcds_data02">
	<param name="DetailDataID"			    value="gcds_data02">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				    VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"			    VALUE="100">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"		        VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<param name="SuppressColumns"	        value="2:ENDYM;1:CRAMT_SUM"> 
	<PARAM NAME="Format"                    VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=275 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='( 단위 : 원 )' ,left=1720 ,top=225 ,right=1931 ,bottom=273 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='만기일별 지급어음현황' ,left=156 ,top=101 ,right=1815 ,bottom=209 ,face='굴림' ,size=25 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=109 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=42 ,top=5 ,right=42 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=624 ,top=5 ,right=624 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=5 ,right=1931 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=45 ,top=5 ,right=1931 ,bottom=5 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='합계' ,left=1561 ,top=19 ,right=1926 ,bottom=103 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='금액' ,left=1169 ,top=21 ,right=1535 ,bottom=106 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1550 ,top=5 ,right=1550 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='적요' ,left=632 ,top=19 ,right=1151 ,bottom=103 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='만기일' ,left=302 ,top=16 ,right=614 ,bottom=101 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='년월' ,left=50 ,top=16 ,right=288 ,bottom=101 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=294 ,top=5 ,right=294 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1159 ,top=5 ,right=1159 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=103 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1580 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<L> left=45 ,top=0 ,right=1307 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=2 </L>
	<L> left=1304 ,top=0 ,right=1588 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=2 </L>
	<C>id='ENDYM', left=50, top=11, right=288, bottom=95, supplevel=2 ,mask='XXXX년XX월', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CRAMT_SUM,0,,CRAMT_SUM)}', left=1561, top=11, right=1926, bottom=95, align='right', supplevel=2, face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CRAMT,0,,CRAMT)}', left=1169, top=11, right=1535, bottom=95, align='right', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=632, top=11, right=1151, bottom=95, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1159 ,top=0 ,right=1159 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=624 ,top=0 ,right=624 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ENDDT', left=302, top=11, right=614, bottom=95 ,mask='XXXX년XX월XX일', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1550 ,top=0 ,right=1550 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=294 ,top=0 ,right=294 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=0 ,right=42 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=42 ,top=0 ,right=1929 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2000 ,bottom=106 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=42 ,top=0 ,right=42 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=106 ,right=1929 ,bottom=106 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1550 ,top=3 ,right=1550 ,bottom=106 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<S>id='{Sum(CRAMT)}' ,left=1169 ,top=13 ,right=1535 ,bottom=98 ,align='right' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=1159 ,top=3 ,right=1159 ,bottom=106 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='합계' ,left=48 ,top=11 ,right=1146 ,bottom=95 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
</B>
<B>id=Footer ,left=0 ,top=2793 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1540 ,top=0 ,right=1929 ,bottom=77</I>
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 



<comment id="__NSID__"><object id="gcrp_print2" classid="clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089"> 
	<param name="MasterDataID"			    value="gcds_data02">
	<param name="DetailDataID"			    value="gcds_data02">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				    VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"			    VALUE="100">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"		        VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<param name="SuppressColumns"	        value="2:ENDYM;1:CRAMT_SUM"> 
	<PARAM NAME="Format"                    VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=275 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='( 단위 : 원 )' ,left=1720 ,top=225 ,right=1931 ,bottom=273 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='만기일별 받을어음현황' ,left=156 ,top=101 ,right=1815 ,bottom=209 ,face='굴림' ,size=25 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=109 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=42 ,top=5 ,right=42 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=624 ,top=5 ,right=624 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=5 ,right=1931 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=45 ,top=5 ,right=1931 ,bottom=5 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='합계' ,left=1561 ,top=19 ,right=1926 ,bottom=103 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='금액' ,left=1169 ,top=21 ,right=1535 ,bottom=106 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1550 ,top=5 ,right=1550 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='적요' ,left=632 ,top=19 ,right=1151 ,bottom=103 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='만기일' ,left=302 ,top=16 ,right=614 ,bottom=101 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='년월' ,left=50 ,top=16 ,right=288 ,bottom=101 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=294 ,top=5 ,right=294 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1159 ,top=5 ,right=1159 ,bottom=108 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=103 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1580 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<L> left=45 ,top=0 ,right=1307 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=2 </L>
	<L> left=1304 ,top=0 ,right=1588 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=2 </L>
	<C>id='ENDYM', left=50, top=11, right=288, bottom=95, supplevel=2 ,mask='XXXX년XX월', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEAMT_SUM,0,,DEAMT_SUM)}', left=1561, top=11, right=1926, bottom=95, align='right', supplevel=2, face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEAMT,0,,DEAMT)}', left=1169, top=11, right=1535, bottom=95, align='right', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=632, top=11, right=1151, bottom=95, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1159 ,top=0 ,right=1159 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=624 ,top=0 ,right=624 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ENDDT', left=302, top=11, right=614, bottom=95 ,mask='XXXX년XX월XX일', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1550 ,top=0 ,right=1550 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=294 ,top=0 ,right=294 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=0 ,right=42 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=42 ,top=0 ,right=1929 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2000 ,bottom=106 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=42 ,top=0 ,right=42 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=106 ,right=1929 ,bottom=106 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1550 ,top=3 ,right=1550 ,bottom=106 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<S>id='{Sum(DEAMT)}' ,left=1169 ,top=13 ,right=1535 ,bottom=98 ,align='right' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=1159 ,top=3 ,right=1159 ,bottom=106 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='합계' ,left=48 ,top=11 ,right=1146 ,bottom=95 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
</B>
<B>id=Footer ,left=0 ,top=2793 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1540 ,top=0 ,right=1929 ,bottom=77</I>
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 



<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 