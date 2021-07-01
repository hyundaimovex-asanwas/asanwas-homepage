<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  자금관리 - 자금지급현황
+ 프로그램 ID	:  a300070.jsp
+ 기 능 정 의	:  현업이 필요한 자금을 신청현황을 조회하는 화면이다.  
+ 작   성  자      :  정 영 식
+ 작성 일 자      :  2016.12.19
+ 서 블 릿 명	:  
+ 가우스 버젼    :  5.2 
-----------------------------------------------------------------------------
+ 수 정 내 용     :	         
+ 수   정  자      : 
+ 수 정 일 자     : 
+ 서 블 릿 명     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>자금지급현황</title>

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
var gs_fdcode = gfdcode;	//지점코드


<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
}

<%
/******************************************************************************
	Description : 선조회
******************************************************************************/
%>
function ln_Before(){

	gcem_appdate_fr.text = gs_date;
	gcem_appdate_to.text = gs_date;
	//gcem_appdate.text = "20161001";
	//gcem_reqdate.text = gs_date;
	
	
	gcds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
	
	gclx_fdcode.bindcolval = gs_fdcode;
	gcem_appempno.text =gs_userid;
	gcem_appempnm.text =gusrnm;	
	
	gclx_paygb.index =0;
	gclx_fsstat.index=0;
}

<%
/******************************************************************************************
	Description : 조회 ( 테이블에 저장된 Data 조회 )  OK
******************************************************************************************/
%>
function ln_Query(e){
	
	 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300070_s1?v_str1="+gclx_fdcode.bindcolval
	  																       +"&v_str2="+gcem_appdate_fr.text
	  																       +"&v_str3="+gcem_appdate_to.text
																		   +"&v_str4="+gcem_reqdate.text
																		   +"&v_str5="+gclx_paygb.bindcolval
																		   +"&v_str6="+gclx_fsstat.bindcolval
																		   +"&v_str7="+gcem_appempno.text;	
     gcds_data01.Reset();

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/


<%
/******************************************************************************
	Description : 엑셀 다운로드
******************************************************************************/
%>

function ln_Excel(){
	//gcgd_disp01.GridToExcel("일자별 예금집계 현황","",2);
}

<%
/******************************************************************************
Description : 찾기 - 작성자 
******************************************************************************/
%>
function ln_Popup_Appempno(){

	if(gusrid=="6070001"||gusrid=="3170009"){
		//var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	
		strURL = "./empno_popup.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);
		
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_appempno.text    = arrParam[1];
			gcem_appempnm.text    = arrParam[0];
		}else{
			gcem_appempno.text="";
			gcem_appempnm.text="";
		}
	}
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--자금신청내역 -->
<object  id=gcds_data01 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<object  id=gcds_fdcode classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>




</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
  	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:0 solid #708090'>
				<tr>
					<td class="tab25" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>지점</nobr></td>
					<td class="tab24" style="width:120px">
						<comment id="__NSID__">
							<object  id=gclx_fdcode    classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=ComboDataID      value="gcds_fdcode">
								<param name=CBDataColumns	 value="FDCODE,FDNAME">
								<param name=SearchColumn	 value=FDNAME>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="FDNAME">								
								<param name=BindColumn		 value="FDCODE">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>신청일</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gcem_appdate_fr classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_appdate_fr', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
						~
						<comment id="__NSID__">
							<object  id=gcem_appdate_to classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_appdate_to', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>지급요청일</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gcem_reqdate classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_reqdate', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					</td>
			    </tr>
				<tr>
					<td class="tab27" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>지급상태</nobr></td>
					<td class="tab28" style="width:120px">
						<comment id="__NSID__">
							<object  id=gclx_paygb classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData			 value="^전체,1^미지급,2^접수,3^지급">
								<param name=CBDataColumns	 value="CODE,NAME">
								<param name=SearchColumn	 value=NAME>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="NAME">								
								<param name=BindColumn		 value="CODE">
						    </object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab28" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>지급전표상태</nobr></td>
					<td class="tab28">
						<comment id="__NSID__">
							<object  id=gclx_fsstat classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData			 value="^전체,Y^결재완료,R^결재요청,N^결재대기,C^결재취소,B^반송">
								<param name=CBDataColumns	 value="CODE,NAME">
								<param name=SearchColumn	 value=NAME>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="NAME">								
								<param name=BindColumn		 value="CODE">
						    </object>
						</comment><script>__ws__(__NSID__);</script>		
					</td>
					<td class="tab28" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>처리자</nobr></td>
					<td class="tab28" >
						<comment id="__NSID__">
						<object id=gcem_appempno classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
							<param name=Text		  value="">
							<param name=Alignment	  value=0>
							<param name=Border		  value=true>
							<param name=Format		  value="#######">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="false">
						</object>
					    </comment><script>__ws__(__NSID__);</script>
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Appempno()">
				    	
				    	<comment id="__NSID__">
						<object  id=gcem_appempnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:80px;height:20px;position:relative;left:5px;top:2px" >		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Enable		  value="false">
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top  colspan=2>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:465px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data01">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<param name="GTitleHeight"  value=25>
							<param name="TitleHeight"   value="25">
							<param name=RowHeight       value="20">
							<PARAM NAME="Format"        VALUE="  
			
								<FC> Name='신청일자'     ID=APPDATE        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' </FC>
								<FG> Name='지급정보'    HeadAlign=Center  HeadBgColor=#B9D4DC
								<FC> Name='종류'       ID=PAYKND         HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='1:수시지급,2:고정지급,3:자동출금,4:지로납부'</FC>
								<FC> Name='요청일'     ID=REQDATE	        HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX'</FC>    
								<FC> Name='완료일'     ID=PAYDATE	        HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' </FC>
								</FG>    
								<FG> Name='거래처정보'   HeadAlign=Center HeadBgColor=#B9D4DC
								<FC> Name='코드'	      ID=VENDCD	       HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none show=false </FC>
								<FC> Name='거래처명'	  ID=VENDNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </FC>
								<FC> Name='계좌번호'    ID=PAYACCTNO 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=120    	align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </FC>
								</FG>
								<C> Name='적요'  	 ID=REMARK		   HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='공급가액'    ID=SUPAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none SumText=@sum  show=false</C>
								<C> Name='부가세액'    ID=SUPVATAMT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none SumText=@sum  show=false</C>
								<C> Name='신청금액'    ID=APPAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none SumText=@sum  </C>
								<C> Name='지급기준'    ID=PAYGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='1:보통예금,2:현금,3:외화보통예금,4:현금(외화)'</C>
								
								<G> Name='외화정보'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='통화명'     ID=CURUNIT 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='외화'       ID=FOUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='환율'       ID=EXRATE  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								</G>
								
								<G> Name='계정정보'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'	     ID=ATCODE 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50     	align=center 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  show=false</C>
								<C> Name='계정명'	     ID=ATKORNAM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	    align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								</G>
								<G> Name='원가/예산정보' HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='구분'	     ID=COSTGB  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=center 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='1:원가,2:예산'</C>
								<C> Name='코드'	     ID=COSTBGT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none show=false</C>
								<C> Name='원가/예산명'	 ID=COSTBGTNM  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								</G>
								
								<C> Name='코드'	     ID=ATCODE2 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50     	align=center 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none show=false</C>
								<C> Name='지급계정명'	 ID=ATKORNAM2	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	    align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								
								<G> Name='매입정보'    HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='매입처리'    ID=PURGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=53    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  EditStyle=CheckBox   show = false </C>
								<C> Name='계산서번호'   ID=TAXNBR 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none MASK='XXXXXXX-XXXX' show=false</C>
								</G>
								<G> Name='신청전표정보'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='접수일자'    ID=APPFSDAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  show=false</C>
								<C> Name='접수번호'    ID=APPFSNBR	   HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  show=false</C>
							    </G>
								<C> Name='지급상태'    ID=PAYSTAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:미지급,2:접수,3:지급' </C>
								<G> Name='신청전표정보'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='접수일자'    ID=APPFSDAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=65    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  </C>
								<C> Name='접수번호'    ID=APPFSNBR	   HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  </C>
								<C> Name='전표번호'    ID=SSLIPNO  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=110    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  </C>
							    <C> Name='전표상태'    ID=FSSTAT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='Y:결재완료,R:결재요청,N:결재대기,C:결재취소,B:반송' </C>
							    <C> Name='자금상태'    ID=FSLOCK  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='T:잠금' </C>
							    </G>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
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

<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
