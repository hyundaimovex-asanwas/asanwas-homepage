<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 기타소득원천징수
+ 프로그램 ID	:  a160006.jsp
+ 기 능 정 의	:  기타소득원천징수 
+ 작   성  자      :  정 영 식
+ 서 블 릿 명	:  a160006_s1, a160006_t1, excel_upload_a160006_t1
-----------------------------------------------------------------------------
+ 수 정 내 용     :	         
+ 수   정  자      : 
+ 수 정 일 자     :  2014.10.14
+ 서 블 릿 명	:
------------------------------------------------------------------------------*/
%>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>기타소득원천징수</title>

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

var gs_frdt="";
var gs_todt="";

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
	gcem_yyyy.text       = gs_date2;	//년도
	gclx_mm.bindcolval   = gcurdate.substring(5,7);	//월
	gcrdo_prt_option.CodeValue="1";
}

<%
/******************************************************************************
	Description : 엑셀 적용 버튼 작업시 엑셀Data ==> Grid로 업로드 함               
******************************************************************************/
%>
function ln_Excel_Apply(){
    var s_temp = "";
	
	//데이터 초기화 ( 화면 Clear ) 
	gcds_excel_grid.clearAll();
    //excel_upload ( grid와 연동 )
	gcds_excel.clearAll(); 
	gcds_excel_grid.clearAll();

    //dataSet head 만들기
    //파일경로
	s_temp = "EXCEL_INFO:STRING(255),EXCEL_URL:URL";
	gcds_excel.SetDataHeader(s_temp);

	gcds_excel.addrow();
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_INFO") = file_path.value;
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_URL") = file_path.value;

	gctr_data_excel.KeyValue = "excel_upload_a160006_t1(I:USER=gcds_excel,O:USER2=gcds_excel_grid)";
	gctr_data_excel.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_a160006_t1";

	gctr_data_excel.post();
		
}

<%
/******************************************************************************************
	Description : 사업소득원천징수 DB INSERT
*****************************************************************************************/
%>
function ln_Create(){
		
	gcds_excel_grid.UseChangeInfo = "false";	

	if (confirm("사업소득 원천징수 데이터를 업로드 하시겠습니까?")){	
			gctr_data.KeyValue = "Account.a160006_t1(I:USER=gcds_excel_grid)";
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160006_t1?";
			gctr_data.post();
	}

}

<%
/******************************************************************************************
	Description : 조회 ( 테이블에 저장된 Data 조회 )  OK
******************************************************************************************/
%>
function ln_Query(){

	if(gcem_yyyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	} 
    
	gcds_excel_grid.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160006_s1?v_str1="+gcem_yyyy.text
	       															          +"&v_str2="+gclx_mm.bindcolval
	  																		  +"&v_str3="+gcem_ea_nm.text;
    //prompt('',gcds_excel_grid.DataID);
	gcds_excel_grid.Reset();
}

<%
/******************************************************************************
	Description : 출력
******************************************************************************/
%>
function ln_Print(){
		
	gcds_prt.clearAll();	
		
	ln_SetDataHeader();
	
	for( var i=1;i<=gcds_excel_grid.countrow;i++){
		
		gcds_prt.Addrow();
		
		gcds_prt.namevalue(i,"CCHK1")= "V";
		gcds_prt.namevalue(i,"CCHK2")= "";
		
		if(gcrdo_prt_option.CodeValue=="1"){
			gcds_prt.namevalue(i,"CCHK3")= "V";  //소득자 보관용
			gcds_prt.namevalue(i,"CCHK4")= "";   //발행자 보관용	
			gcds_prt.namevalue(i,"CCHK6")= gcds_excel_grid.namevalue(i,"EA_NM");
		}else if (gcrdo_prt_option.CodeValue=="2"){
			gcds_prt.namevalue(i,"CCHK3")= "";  //소득자 보관용
			gcds_prt.namevalue(i,"CCHK4")= "V";   //발행자 보관용
			gcds_prt.namevalue(i,"CCHK6")= "세 무 서 장";
		}
		
		
		if(gcds_excel_grid.namevalue(i,"INOUT_GB")=="1"){
			gcds_prt.namevalue(i,"CCHK5")= "내국인1"	
		}else if (gcds_excel_grid.namevalue(i,"INOUT_GB")=="9"){
			gcds_prt.namevalue(i,"CCHK5")= "외국인9"
		}
		
		//소득구분코드 체크 초기화 
		gcds_prt.namevalue(i,"CCHK60")= "";
		gcds_prt.namevalue(i,"CCHK62")= "";
		gcds_prt.namevalue(i,"CCHK63")= "";
		gcds_prt.namevalue(i,"CCHK64")= "";
		gcds_prt.namevalue(i,"CCHK68")= "";
		gcds_prt.namevalue(i,"CCHK69")= "";
		gcds_prt.namevalue(i,"CCHK71")= "";
		gcds_prt.namevalue(i,"CCHK72")= "";
		gcds_prt.namevalue(i,"CCHK73")= "";
		gcds_prt.namevalue(i,"CCHK74")= "";
		gcds_prt.namevalue(i,"CCHK75")= "";
		gcds_prt.namevalue(i,"CCHK76")= "";
		
		//소득구분코드 체크
		gcds_prt.namevalue(i,"CCHK"+gcds_excel_grid.namevalue(i,"INCOME_GB"))= "V";
			
		gcds_prt.namevalue(i,"CYMD")= gcurdate.substring(0,4) +"년"+ gcurdate.substring(5,7)+"월"+ gcurdate.substring(8,10)+"일";
		
		gcds_prt.namevalue(i,"PAY_Y")=gcds_excel_grid.namevalue(i,"PAY_DT").substring(0,4);	
		gcds_prt.namevalue(i,"PAY_M")=gcds_excel_grid.namevalue(i,"PAY_DT").substring(4,6);	
		gcds_prt.namevalue(i,"PAY_D")=gcds_excel_grid.namevalue(i,"PAY_DT").substring(6,8);	
		
		
		gcds_prt.namevalue(i,"YYYY")=gcds_excel_grid.namevalue(i,"YYYY");
		gcds_prt.namevalue(i,"INC_MM")=gcds_excel_grid.namevalue(i,"INC_MM");
		gcds_prt.namevalue(i,"INC_SEQ")=Number(gcds_excel_grid.namevalue(i,"INC_SEQ"));
		gcds_prt.namevalue(i,"PAY_DT")=gcds_excel_grid.namevalue(i,"PAY_DT");
		gcds_prt.namevalue(i,"CO_CRNO")=gcds_excel_grid.namevalue(i,"CO_CRNO");
		gcds_prt.namevalue(i,"CO_NO")=gcds_excel_grid.namevalue(i,"CO_NO");
		gcds_prt.namevalue(i,"CO_NM")=gcds_excel_grid.namevalue(i,"CO_NM");
		gcds_prt.namevalue(i,"CO_RENM")=gcds_excel_grid.namevalue(i,"CO_RENM");
		gcds_prt.namevalue(i,"CO_AD")=gcds_excel_grid.namevalue(i,"CO_AD");
		gcds_prt.namevalue(i,"EA_NM")=gcds_excel_grid.namevalue(i,"EA_NM");
		gcds_prt.namevalue(i,"EA_NO")=gcds_excel_grid.namevalue(i,"EA_NO");
		gcds_prt.namevalue(i,"EA_AD")=gcds_excel_grid.namevalue(i,"EA_AD");
		
		gcds_prt.namevalue(i,"TOT_AMT")=Number(gcds_excel_grid.namevalue(i,"TOT_AMT"));
		gcds_prt.namevalue(i,"EXP_AMT")=Number(gcds_excel_grid.namevalue(i,"EXP_AMT"));
		gcds_prt.namevalue(i,"INC_AMT")=Number(gcds_excel_grid.namevalue(i,"INC_AMT"));
		
		gcds_prt.namevalue(i,"TAX_RATE")=Number(gcds_excel_grid.namevalue(i,"TAX_RATE"));
		gcds_prt.namevalue(i,"INC_TAX")=Number(gcds_excel_grid.namevalue(i,"INC_TAX"));
		gcds_prt.namevalue(i,"LINC_TAX")=Number(gcds_excel_grid.namevalue(i,"LINC_TAX"));
		gcds_prt.namevalue(i,"FVS_TAX")=Number(gcds_excel_grid.namevalue(i,"FVS_TAX"));
		
		gcds_prt.namevalue(i,"SUM_AMT")=Number(gcds_excel_grid.namevalue(i,"SUM_AMT"));
		gcds_prt.namevalue(i,"INOUT_GB")=gcds_excel_grid.namevalue(i,"INOUT_GB");
		gcds_prt.namevalue(i,"INCOME_GB")=gcds_excel_grid.namevalue(i,"INCOME_GB");
		
	
	}
	gcrp_print.Preview();
}

<%
/******************************************************************************
Description : 출력
******************************************************************************/
%>
function ln_SetDataHeader(){
	
	var s_tmp1="";
		
	s_tmp1 ="CCHK1:STRING,CCHK2:STRING,CCHK3:STRING,CCHK4:STRING,CCHK5:STRING,"
		   +"CCHK6:STRING,CYMD:STRING,PAY_Y:STRING,PAY_M:STRING,PAY_D:STRING," 
		   +"YYYY:STRING,INC_MM:STRING,INC_SEQ:DECIMAL,PAY_DT:STRING,CO_CRNO:STRING,"	
		   +"CO_NO:STRING,CO_NM:STRING,CO_RENM:STRING,CO_AD:STRING,EA_NM:STRING,"	
		   +"EA_NO:STRING,EA_AD:STRING,TOT_AMT:DECIMAL,EXP_AMT:DECIMAL,INC_AMT:DECIMAL,"		
		   +"TAX_RATE:DECIMAL,INC_TAX:DECIMAL,LINC_TAX:DECIMAL,FVS_TAX:DECIMAL,SUM_AMT:DECIMAL,"		
		   +"INOUT_GB:STRING,INCOME_GB:STRING,"		
		   +"CREATE_ID:STRING,CREATE_DATE:STRING,UPDATE_ID:STRING,UPDATE_DATE,"
		   +"CCHK60:STRING,CCHK62:STRING,CCHK63:STRING,CCHK64:STRING,CCHK68:STRING,CCHK69:STRING,"
		   +"CCHK71:STRING,CCHK72:STRING,CCHK73:STRING,CCHK74:STRING,CCHK75:STRING,CCHK76:STRING";		
	gcds_prt.SetDataHeader(s_tmp1);
	
}

<%
/******************************************************************************
	Description : 엑셀 다운로드
******************************************************************************/
%>
function ln_Excel(){
	gcgd_disp01.GridToExcel("사업소득 원천징수","",2);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_excel_grid classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_prt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data_excel classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_excel_grid" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_excel_grid" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
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
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data_excel event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data_excel event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data_excel.ErrorCode + "\n" + "Error Message : " + gctr_data_excel.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td colspan=2  height="20px"><strong><font size="2" color="blue">&nbsp;[파일업로드]</font></strong></td></tr>
	<tr>
		<td colspan=2 align=left style="position:relative;left:6px;top:-2px">
			<table  cellpadding="0" cellspacing="0" style="width:1000;height:30px;font-size:9pt;background-color:#ffffff;">
			<tr> 
				<td width="102px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>엑셀파일</nobr></td>
				<td class="tab18" ><nobr>&nbsp;
					<input type="text" name="file_path" value="" style="width:600px;position:relative;top:-2px" >&nbsp;
					<comment id="__NSID__">
					<object id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="width:70;height:20;position:relative;top:4px;fontSize=8"  >
						<param name = "Text"		value="찾아보기">
					</object>&nbsp;
					</comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</nobr>	
					<img src="../../Common/img/btn/com_btn_exl_app.gif" style="cursor:hand;position:relative;top:3px"  onClick="ln_Excel_Apply()">
					<img src="../../Common/img/btn/com_b_save.gif"    style="cursor:hand;position:relative;top:3px"  onClick="ln_Create()">
				</td> 
			</tr>
			</table>
		</td>
	</tr>
    <tr><td height="35px"><strong><font size="2" color="blue">&nbsp;[조회조건]</font></strong></td>
        <td align="right">&nbsp;<nobr>      
			<img src="../../Common/img/btn/com_b_print.gif"   style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print()">
			<img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;top:2px;right:2px"	onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
			</nobr>
		</td>          
    </tr>
	<tr>
		<td colspan=2 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>귀속년도</nobr></td>
					<td class="tab23" style="width:60px"><comment id="__NSID__">
						<object id=gcem_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>소득년월</nobr></td>
					<td class="tab23" ><nobr><comment id="__NSID__">
						<object  id=gclx_mm classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:60px;height:20px;">
							<param name=CBData				value="01^1월,02^2월,03^3월,04^4월,05^5월,06^6월,07^7월,08^8월,09^9월,10^10월,11^11월,12^12월,">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat	    value="CDNAM^0^60">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>성명</nobr></td>
					<td class="tab23" style="width:120px" ><nobr><comment id="__NSID__">
						<object id=gcem_ea_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:100px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value="true">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>출력옵션</nobr></td>
					<td><nobr><comment id="__NSID__">
						<object id=gcrdo_prt_option classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:20; width:200">
							<param name=Cols	value="2">
							<param name=Format	value="1^소득자 보관용,2^발행자 보관용">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td colspan=2  ALIGN=CENTER>
		<table width="1000" cellpadding="1" cellspacing="0" border="0">
			<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
				<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:1000px;HEIGHT:420px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
					<PARAM NAME="DataID"        VALUE="gcds_excel_grid">
					<PARAM NAME="Editable"		VALUE="false">
					<PARAM NAME="BorderStyle"	VALUE="0">
					<PARAM NAME="IndWidth"		VALUE="0">
					<PARAM NAME="ColSizing"		VALUE="true">
					<param NAME="Fillarea"      VALUE="true">
					<param name=SortView        value="Left">
					<PARAM NAME="viewSummary"	VALUE="1">
					<PARAM NAME="Format"        VALUE="  
					<C> Name='귀속년도'	   	    ID=YYYY      	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center	SumBgColor='#C3D0DB'  </C>
					<C> Name='소득월'		        ID=INC_MM   	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center	SumBgColor='#C3D0DB'  </C>
					<C> Name='순번'			    ID=INC_SEQ  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='지급년월일'		    ID=PAY_DT   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=center	SumBgColor='#C3D0DB' sort=true MASK='XXXX-XX-XX'</C>
					<C> Name='성명'		        ID=EA_NM    	HeadAlign=Center HeadBgColor=#B9D4DC Width=60   align=center	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='주민번호'	        ID=EA_NO    	HeadAlign=Center HeadBgColor=#B9D4DC Width=95   align=center	SumBgColor='#C3D0DB' sort=true MASK='XXXXXX-X******'</C>
					<C> Name='주소'		        ID=EA_AD    	HeadAlign=Center HeadBgColor=#B9D4DC Width=150  align=left  	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='지급총액'		    ID=TOT_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='필요경비'		    ID=EXP_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='소득금액'		    ID=INC_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='세율'			    ID=TAX_RATE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center  	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='소득세'		        ID=INC_TAX  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='지방소득세'		    ID=LINC_TAX 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='농어촌특별세'		ID=FVS_TAX   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='계'			    ID=SUM_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='내외구분'		    ID=INOUT_GB 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center	SumBgColor='#C3D0DB'  </C>
					<C> Name='소득구분'		    ID=INCOME_GB 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center	SumBgColor='#C3D0DB'  </C>
					">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="position:relative;left:5px;width:1002px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
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
<comment id="__NSID__"><object  id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_mst">
	<param name="DetailDataID"			    value="gcds_prt">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"				VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="TRUE">
	<param name="SuppressColumns"	        value="1:pageskip,EA_NO; ">
	<PARAM NAME="Format"                    VALUE="
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=1002 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1490 ,top=74 ,right=1918 ,bottom=262 ,border=true</X>
	<X>left=1490 ,top=74 ,right=1918 ,bottom=169 ,border=true</X>
	<X>left=153 ,top=79 ,right=273 ,bottom=198 ,border=true</X>
	<X>left=37 ,top=79 ,right=156 ,bottom=198 ,border=true</X>
	<L> left=40 ,top=452 ,right=1918 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=209 ,top=921 ,right=209 ,bottom=1003 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CO_AD', left=1167, top=381, right=1908, bottom=447, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_NO', left=484, top=381, right=804, bottom=447, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_RENM', left=1662, top=302, right=1908, bottom=368, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_NM', left=1167, top=302, right=1487, bottom=368, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_CRNO', left=484, top=299, right=804, bottom=365, align='left' ,mask='XXX-XX-XXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(3)성명' ,left=1527 ,top=299 ,right=1656 ,bottom=373 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=148 ,top=918 ,right=148 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=386 ,top=918 ,right=386 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='일' ,left=209 ,top=921 ,right=267 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='월' ,left=151 ,top=921 ,right=209 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1693 ,top=918 ,right=1693 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=918 ,right=1249 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1021 ,top=918 ,right=1921 ,bottom=918 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=632 ,top=839 ,right=632 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=918 ,right=479 ,bottom=918 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=1000 ,right=1921 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='연' ,left=53 ,top=921 ,right=148 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='연' ,left=278 ,top=921 ,right=384 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(10)지급연월일' ,left=53 ,top=841 ,right=273 ,bottom=915 ,align='left' ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=42 ,top=839 ,right=1921 ,bottom=839 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='의무자' ,left=53 ,top=373 ,right=161 ,bottom=447 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='징 수' ,left=53 ,top=299 ,right=161 ,bottom=373 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=815 ,top=288 ,right=815 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1521 ,top=291 ,right=1521 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(5)소재지 또는 주소' ,left=820 ,top=376 ,right=1162 ,bottom=450 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(4)법인등록번호' ,left=172 ,top=376 ,right=479 ,bottom=450 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=167 ,top=373 ,right=1916 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(2)법인명 또는 상호' ,left=820 ,top=296 ,right=1162 ,bottom=370 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(1)사업자등록번호' ,left=172 ,top=296 ,right=479 ,bottom=370 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=40 ,top=291 ,right=1918 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CCHK4', left=926, top=209, right=976, bottom=267, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK3', left=479, top=209, right=529, bottom=267, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=']소득자 보관용     [' ,left=529 ,top=209 ,right=926 ,bottom=267 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( [' ,left=413 ,top=209 ,right=479 ,bottom=267 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=']  발행자 보관용  )' ,left=976 ,top=209 ,right=1392 ,bottom=267 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CCHK1', left=389, top=74, right=439, bottom=132, align='left', face='굴림', size=16, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK2', left=389, top=135, right=439, bottom=193, align='left', face='굴림', size=16, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=']' ,left=434 ,top=74 ,right=474 ,bottom=132 ,face='Arial' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=']' ,left=434 ,top=135 ,right=474 ,bottom=193 ,face='Arial' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[' ,left=349 ,top=135 ,right=389 ,bottom=193 ,face='Arial' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[' ,left=349 ,top=74 ,right=389 ,bottom=132 ,face='Arial' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='YYYY', left=156, top=108, right=270, bottom=175, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='귀속' ,left=61 ,top=93 ,right=135 ,bottom=140 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='년도' ,left=61 ,top=140 ,right=135 ,bottom=188 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주자의 기타소득 지급명세서' ,left=482 ,top=135 ,right=1437 ,bottom=193 ,align='left' ,face='굴림' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주자의 기타소득 원천징수영수증 ' ,left=479 ,top=74 ,right=1434 ,bottom=132 ,align='left' ,face='굴림' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(6)성           명' ,left=172 ,top=455 ,right=479 ,bottom=529 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(7)주민등록번호' ,left=1172 ,top=455 ,right=1479 ,bottom=529 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=167 ,top=532 ,right=1916 ,bottom=532 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1164 ,top=288 ,right=1164 ,bottom=532 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1659 ,top=294 ,right=1659 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='EA_NO', left=1490, top=460, right=1902, bottom=527, align='left' ,mask='XXXXXX-X******', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EA_NM', left=482, top=460, right=1154, bottom=527, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(8)주           소' ,left=172 ,top=537 ,right=479 ,bottom=611 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='소득자' ,left=53 ,top=495 ,right=161 ,bottom=569 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=167 ,top=291 ,right=167 ,bottom=611 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=614 ,right=1921 ,bottom=614 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='EA_AD', left=482, top=542, right=1902, bottom=609, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=479 ,top=294 ,right=479 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=275 ,top=841 ,right=275 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id=' * 해당코드에 V 표시' ,left=114 ,top=743 ,right=394 ,bottom=786 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(9)소득구분코드' ,left=114 ,top=669 ,right=394 ,bottom=743 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(11)귀속연월' ,left=275 ,top=841 ,right=471 ,bottom=915 ,align='left' ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='월' ,left=389 ,top=921 ,right=471 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='지급총액' ,left=484 ,top=913 ,right=630 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Multiline=true</T>
	<T>id='(12)' ,left=484 ,top=857 ,right=630 ,bottom=910 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Multiline=true</T>
	<L> left=783 ,top=839 ,right=783 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='필요경비' ,left=635 ,top=913 ,right=781 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Multiline=true</T>
	<T>id='(13)' ,left=635 ,top=857 ,right=781 ,bottom=910 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Multiline=true</T>
	<T>id='(14)' ,left=786 ,top=857 ,right=931 ,bottom=910 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Multiline=true</T>
	<T>id='(17)소득세' ,left=1027 ,top=921 ,right=1244 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(15)' ,left=937 ,top=857 ,right=1019 ,bottom=910 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Multiline=true</T>
	<T>id='세율' ,left=937 ,top=913 ,right=1019 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Multiline=true</T>
	<T>id='원 천 징 수 세 액 ' ,left=1027 ,top=841 ,right=1916 ,bottom=915 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(19)계' ,left=1699 ,top=921 ,right=1916 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(18)지방소득세' ,left=1254 ,top=921 ,right=1471 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1474 ,top=918 ,right=1474 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(18)지방소득세' ,left=1479 ,top=921 ,right=1691 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='내.외국인구분' ,left=1498 ,top=183 ,right=1728 ,bottom=249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CCHK5', left=1736, top=183, right=1913, bottom=249, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1730 ,top=169 ,right=1730 ,bottom=262 </L>
	<T>id='소득자 구분' ,left=1498 ,top=93 ,right=1908 ,bottom=159 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1487 ,top=452 ,right=1487 ,bottom=529 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='[68] 비과세 기타소득, ' ,left=516 ,top=619 ,right=831 ,bottom=661 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='소득금액' ,left=786 ,top=913 ,right=931 ,bottom=995 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Multiline=true</T>
	<C>id='CCHK68', left=497, top=619, right=537, bottom=661, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='[73] 지역권 등' ,left=1267 ,top=706 ,right=1498 ,bottom=749 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='[69] 분리과세 기타소득, ' ,left=881 ,top=619 ,right=1225 ,bottom=661 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='CCHK69', left=860, top=619, right=900, bottom=661, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=' [63]연금저축, 소기업소상공인공제부금해지 소득,' ,left=1254 ,top=619 ,right=1939 ,bottom=661 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='[60] 필요경비 없는 기타소득([63] 제외), ' ,left=516 ,top=664 ,right=1093 ,bottom=706 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<L> left=934 ,top=839 ,right=934 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1021 ,top=839 ,right=1021 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='[64]서화.골동품 양도소득,' ,left=1267 ,top=664 ,right=1701 ,bottom=706 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='CCHK64', left=1236, top=664, right=1275, bottom=706, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='[71] 상금 및 부상,' ,left=516 ,top=706 ,right=815 ,bottom=749 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='[72] 광업권 등,' ,left=884 ,top=706 ,right=1183 ,bottom=749 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='CCHK72', left=860, top=706, right=900, bottom=749, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK73', left=1236, top=706, right=1275, bottom=749, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK63', left=1236, top=619, right=1275, bottom=661, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='[74] 주택입주지체상금,' ,left=1561 ,top=706 ,right=1910 ,bottom=749 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='CCHK74', left=1529, top=706, right=1569, bottom=749, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='[75] 원고료 등, ' ,left=516 ,top=749 ,right=812 ,bottom=791 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='[76] 강연료 등,' ,left=884 ,top=749 ,right=1130 ,bottom=791 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='CCHK76', left=860, top=749, right=900, bottom=791, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='[62] 그 밖의 필요경비 있는 기타소득 ([64],[68],[69],[71]~[76] 제외 )' ,left=516 ,top=791 ,right=1831 ,bottom=833 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<C>id='CCHK60', left=497, top=664, right=537, bottom=706, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK71', left=497, top=706, right=537, bottom=749, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK75', left=497, top=749, right=537, bottom=791, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK62', left=497, top=791, right=537, bottom=833, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=45 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='YYYY', left=278, top=0, right=384, bottom=45, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_D', left=209, top=0, right=267, bottom=45, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_M', left=151, top=0, right=209, bottom=45, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_Y', left=53, top=0, right=148, bottom=45, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=148 ,top=0 ,right=148 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=50 ,right=1921 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=209 ,top=0 ,right=209 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=386 ,top=0 ,right=386 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=783 ,top=0 ,right=783 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=632 ,top=0 ,right=632 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=0 ,right=1249 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1693 ,top=0 ,right=1693 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=275 ,top=0 ,right=275 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='INC_MM', left=389, top=0, right=471, bottom=45, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=479 ,top=0 ,right=479 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TOT_AMT', left=484, top=0, right=630, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EXP_AMT', left=635, top=0, right=781, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC_AMT', left=786, top=0, right=931, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=934 ,top=0 ,right=934 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAX_RATE', left=937, top=0, right=1019, bottom=45, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1021 ,top=0 ,right=1021 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='INC_TAX', left=1027, top=0, right=1244, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LINC_TAX', left=1254, top=0, right=1471, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUM_AMT', left=1699, top=0, right=1916, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1474 ,top=0 ,right=1474 ,bottom=45 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='LINC_TAX', left=1479, top=0, right=1691, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=478 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='위의 원천징수세액(수입금액)을 정히 영수(지급)합니다.' ,left=140 ,top=13 ,right=1050 ,bottom=61 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. 이 서식은 거주자가 기타소득을 지급하는 경우에 사용하며, 이자.배당소득원천징수영수증[별지 제23호서식(1)]의 작성방법과 같습니다.' ,left=58 ,top=352 ,right=1897 ,bottom=394 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='2.징수의무자란의 (4)주민(법인)등록번호은 소득자 보관용에는 적지 않습니다.' ,left=58 ,top=394 ,right=1897 ,bottom=437 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='3.(16)란부터 (19)란까지 중 셍액이 소액부징수(1천원 미만을 말합니다.)에 해당하는 경우에는 세액을  0으로 적습니다.' ,left=58 ,top=437 ,right=1897 ,bottom=479 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='작 성 방 법' ,left=58 ,top=304 ,right=1897 ,bottom=347 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A0A0A4</T>
	<L> left=42 ,top=286 ,right=1921 ,bottom=286 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='귀하' ,left=545 ,top=193 ,right=675 ,bottom=241 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 서명 또는 인 )' ,left=1564 ,top=119 ,right=1902 ,bottom=167 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYMD', left=1569, top=58, right=1897, bottom=106, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_NM', left=828, top=127, right=1214, bottom=175, face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK6', left=172, top=183, right=524, bottom=249, face='굴림', size=16, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2783 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=1511 ,top=3 ,right=1889 ,bottom=85</I>
	<L> left=42 ,top=0 ,right=1921 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>


">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 