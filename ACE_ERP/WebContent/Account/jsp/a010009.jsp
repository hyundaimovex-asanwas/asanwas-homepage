
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명 :  거래처 upload
+ 프로그램 ID :  A010008.html
+ 기 능 정 의 : 
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2008.07.23
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수   정  자 : 
+ 수 정 일 자 :  
-----------------------------------------------------------------------------
+ 서 블 릿 명 :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title></title>

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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
    /*
		gcds_data.DataID = g_servlet+"/Account.a010007_s1?v_str1="+gcrd_tablegb.codevalue;
		prompt('',gcds_data.DataID);
		gcds_data.Reset();
		*/
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	gcds_data.UseChangeInfo = "false";
  //prompt('',gcds_data.text);
  
	/*
  if(gcds_data.countrow <1){
		alert("저장할 데이타 존재하지 않습니다. 확인바랍니다.");
		return false;
	}
  */

	if(confirm("저장하시겠습니까?")){

       gctr_data0.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010009_t0?";
		gctr_data0.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;	
					
		gctr_data0.post();
  /*
		gctr_data0.KeyValue = "a010009_t1(I:USER=gcds_data)";
		gctr_data0.Action = g_servlet+"/Account.a010009_t1?";
		//gctr_data0.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;	
		prompt('',gcds_data.text);
		gctr_data0.post();
		*/
	}
	
}


/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}


/******************************************************************************
	Description : 팝업
******************************************************************************/
function ln_Popup(){

}


/******************************************************************************
	Description : 엑셀 파일을 그리드로 가져오기
	parameter   :  - grid object명 , p2 - sheet명
******************************************************************************/
function ln_Excel_Apply(){
        gcds_excel.clearAll(); 
	    gcds_data.clearAll();

        //dataSet head 만들기
		ln_SetDataHeader();
    
		gcds_excel.addrow();
		gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_INFO") = file_path.value;
		gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_URL") = file_path.value;

		//gctr_data.KeyValue = "excel_upload_t1?(I:USER=gcds_excel,O:USER2=gcds_data)";
		/*
		gctr_data.KeyValue = "excel_upload_t1(I:USER=gcds_excel)";
		gctr_data.Action = g_servlet+"/Account.excel_upload_t1?";
		*/

		gctr_data.KeyValue = "excel_upload_t1(I:USER=gcds_excel,O:USER2=gcds_data)";
		gctr_data.Action ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_t1?";
		//prompt('',gcds_excel.text);
		gctr_data.post();
   
}

 /*-----------------------------------------------------------------------------
	Description : Dataset Head 설정 - gcds_data00
-----------------------------------------------------------------------------*/
	function ln_SetDataHeader(){
		if(gcds_excel.countrow<1){
				var s_temp = "EXCEL_INFO:STRING(255),EXCEL_URL:URL";
				gcds_excel.SetDataHeader(s_temp);
		}
	}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
 <object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

 <object  id=gctr_data0 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010009_t0(I:USER=gcds_data)"> 
	<param name=TimeOut       value=3600000>
</object>
</comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
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
  	alert("엑셀 불러오기가 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");

</script>
 
<script language=JavaScript for=gctr_data0 event=OnSuccess()>
    alert("성공적으로 저장하였습니다.");
	gcds_data.UseChangeInfo = "true"
</script>

<script language=JavaScript for=gctr_data0 event=OnFail()>
	alert("Error Code : " + gctr_data0.ErrorCode + "\n" + "Error Message : " + gctr_data0.ErrorMsg + "\n");
	gcds_data.UseChangeInfo = "true";

</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr>
		<td>
			<table width="876" cellpadding="0" cellspacing="0" border="0" >
				<tr> 
					<td >
			       		<img src="../img/a010009_head.gif"> 
					</td>
					<td width="876" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	 style="cursor:hand" onclick="ln_Save()">
					</td>
				</tr>
       </table>
    </td>
  </tr>

  <tr>
	<td>
     <table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
			<tr width="876px"> 
				<td width="80px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;엑셀파일&nbsp;</nobr></td>
				<td class="tab18" style="width:750px;"><nobr>&nbsp;
						<input type="text" name="file_path" value="" style="position:relative;top:-2px;width:350px;" >&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="position:relative;top:4px;width:70;height:20"  >
							<param name="Text"		value="찾아보기">
						</OBJECT>&nbsp;
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_btn_exl_app.gif" style="position:relative;top:3px;cursor:hand;"  onClick="ln_Excel_Apply()">
						</comment><script>__ws__(__NSID__);</script>  
						</nobr>
				</td> 
			</tr>
	 </table>
    </td>
	</tr>

  <!-- Grid 와 입력창 -->
	<tr>
		<td>
			<table>
				<tr>
				  <td>
					  <!--Grid-->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:876px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
										style="position:relative;left:2px;width:876px; height:400px; border:1 solid #708090;display:block;" viewastext>
											<param name="dataid"			  value="gcds_data">
											<param name="indwidth"		  value ='0'>
											<param name="BorderStyle"		value=1>
											<param name="HeadLineColor" value=#b0bde2>
											<param name="LineColor"     value=#b0bde2>
											<param name=SortView  value="Left">
											<param name=ColSizing  value="true">
											<param name="format"		   	value="  
											 <C> id=''         , 		name=순번          ,		width=60, 	Headbgcolor='#B9D4DC' Value={CurRow}</C>
                                             <C> id=VEND_CD    , 		name=거래처코드    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VEND_NM    , 		name=거래처명      ,		width=100, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VEND_ID    , 		name=사업자번호    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VEND_NO    , 		name=법인번호      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VD_DIRECT  , 		name=대표자        ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=BSNS_CND   , 		name=업태          ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=BSNS_KND   , 		name=업종          ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VD_TELNO   , 		name=전화번호      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VD_FAXNO   , 		name=팩스번호      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=POST_NO1   , 		name=우편번호1     ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=POST_NO2   , 		name=우편번호2     ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=ADDRESS1   , 		name=주소1         ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=ADDRESS2   , 		name=주소2         ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=C_BANKCD   , 		name=현금은행코드  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=C_ACCTNO   , 		name=현금계좌번호  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=C_ACCTNO_NM, 		name=현금계좌명    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=C_ACCTNM   , 		name=현금계좌예금주,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=B_BANKCD   , 		name=어음은행코드  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=B_ACCTNO   , 		name=어음계좌번호  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=B_ACCTNO_NM, 		name=어음계좌명    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=B_ACCTNM   , 		name=어음계좌예금주,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=O_VENDGB   , 		name=구거래구분    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=O_VENDCD   , 		name=구거래처코드  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=VEND_MAG   , 		name=관리번호      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=USE_TAG    , 		name=사용유무      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=REMARK     , 		name=비고          ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=CREAT_DT   , 		name=등록일자      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=CREAT_NM   , 		name=등록자        ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=MSN        , 		name=아이디        ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=MPWD       , 		name=비밀번호      ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=COCOMYN    , 		name=협력업체구분  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=H_VEND_CD  , 		name=대표거래처    ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=H_VEND_NM  , 		name=대표거래처명  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=IUGB    , 		name=입력수정  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=WRDT    , 		name=입력일자  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=WRID    , 		name=입력자  ,		  width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=UPDT    , 		name=수정일자  ,		width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											 <C> id=UPID    , 		name=수정자  ,		  width=80, 	Headbgcolor='#B9D4DC' sort=true</C>
											">
									</object></comment><script>__ws__(__NSID__);</script>   
									<fieldset style="position:relative;left:3px;width:876px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
										&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
									</fieldset>
									
								</td>
							</tr>
							<tr>
								 <td>
								 	<B><FONT SIZE="2" COLOR="blue">엑셀 파일 확장자가 .xlsx 파일일 경우 []다른 이름으로 저장]하여 .xls 파일로 변환  후 업로드 하십시요. </FONT></B>
								 </td>
					        </tr>
						</table>
					</td>
        </tr>
			<table>
		</td>
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