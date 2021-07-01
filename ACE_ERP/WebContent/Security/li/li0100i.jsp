<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 정보보보>정보관리>등록관리>정보등록
* 프로그램 ID	: li0101I.jsp
* 기 능 정 의	: 정보등록
* 작  성   자 : 정 영 식
* 작 성 일 자 : 2011.10.17
-----------------------------------------------------------------------------
* 수 정 내 용 : 
* 수   정  자 :
* 수 정 일 자 : 
-----------------------------------------------------------------------------
* 서 블 릿 명	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 변수 설정.
  String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>정보조회</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
var sApproveLine="";

/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
    fnInit();
    
    txt_own_dpt.value = gdeptcd;
    txt_own_dptnm.value = gdeptnm;
}

/******************************************************************************
	Description : 초기화 
****************************************************************************/
function fnInit(){
	ds_doc_grd.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI001&s_item1=Y";
    ds_doc_grd.Reset(); //문서등급
    
    ds_doc_frm.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI002&s_item1=Y";
    ds_doc_frm.Reset(); //문서형태
    
    ds_crt_div.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI003&s_item1=Y";
    ds_crt_div.Reset(); //생성구분
    
    ds_use_yn.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY011&s_item1=Y";
    ds_use_yn.Reset(); //사용유무
    
    ds_prs_yr_lmt.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI006&s_item1=Y";
    ds_prs_yr_lmt.Reset(); //보존년한
    
    ds_sgn_sts.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP002&s_item1=Y";
    ds_sgn_sts.Reset(); //결재상태
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function fnSelect(){

     /** 이 건은 의미 없음. ==> 결재대상건만 조회 가능하게 함 
     if(gcem_doc_mag_sid.text==""){
     	alert("관리번호 입력 후 조회 가능합니다.");
        return;
     }
     **/

	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		              + ",v_doc_mag_sid="
		              + ",v_gdeptcd="+gdeptcd;           
		          
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0100S",  "JSP(O:DS_DEFAULT=ds_default)",  param);
    //prompt('',ds_default.dataid);   
    tr_post(tr1);

}

/******************************************************************************
	Description : 신규
******************************************************************************/
function fnAddRow(){
    ds_default.AddRow();
    
    txt_own_dpt.value = gdeptcd;
    txt_own_dptnm.value = gdeptnm;
    
    gcem_prd_dt.text = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
    gclx_use_yn.bindcolval="Y";
    
    if(ds_default.CountRow==0){
        alert("조회를 먼저 하시길 바랍니다.");
        return;
    }
}

/******************************************************************************
	Description : 저장
******************************************************************************/
 function fnApply() {
    if (ds_default.IsUpdated) {
        if (fnChk()) {
            ln_TRSetting(tr1, "<%=dirPath%><%=HDConstant.PATH_LI%>Li0100S",  "JSP(I:DS_DEFAULT=ds_default)",  "proType=A, dsType=1");
            tr_post(tr1);
        }else{
        	return;
        }
    }else{
    	alert("저장할 데이터가 존재하지 않습니다.");
    	return;
    }
    
    fnSelect();
}


/******************************************************************************
	Description : 취소
******************************************************************************/
 function fnCancel() {           
    ds_default.undoall();
    window.status="자료 변경이 취소되었습니다.";      
}



/******************************************************************************
	Description : 저장시 체크
******************************************************************************/
 function fnChk() {      
    
    if(gclx_doc_grd.bindcolval==""){
    	alert("문서등급은 필수항목입니다.");
    	return false;
    }
    
    if(gclx_doc_frm.bindcolval==""){
    	alert("문서형태는 필수항목입니다.");
    	return false;
    }
    
    if(gcem_prd_dt.text==""){
    	alert("생산일자는 필수항목입니다.");
    	return false;
    }
    
    if(gcem_prd_psn.text==""){
    	alert("생산자는 필수항목입니다1.");
    	return false;
    }
    
    if(gcem_prd_psn_nm.text==""){
    	alert("생산자는 필수항목입니다2.");
    	return false;
    }
    
    if(gclx_crt_div.bindcolval==""){
    	alert("생성구분은 필수항목입니다.");
    	return false;
    }
    
    if(gclx_use_yn.bindcolval==""){
    	alert("사용유무는 필수항목입니다.");
    	return false;
    }
    
    if(gclx_prs_yr_lmt.bindcolval==""){
    	alert("보존년한은  필수항목입니다.");
    	return false;
    }
    
    if(gcem_doc_tle.text==""){
    	alert("제목은  필수항목입니다.");
    	return false;
    }
    
    if(gcem_doc_cts.text==""){
    	alert("내용은  필수항목입니다.");
    	return false;
    }
    
    if(gcem_doc_kwd.text==""){
    	alert("키워드는  필수항목입니다.");
    	return false;
    }
    
  	return true;
}




/******************************************************************************
	Description : 생산자, 생산부서  popup
******************************************************************************/
function fnPrdPsnPopup() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_prd_dpt.value           = arrParam[3];
	   		txt_prd_dptnm.value      = arrParam[0];
	   		gcem_prd_psn.text       = arrParam[1];
	   		gcem_prd_psn_nm.text = arrParam[2];
		} else {
			txt_prd_dpt.value           = "";
	   		txt_prd_dptnm.value      = "";
	   		gcem_prd_psn.text       = "";
	   		gcem_prd_psn_nm.text = "";
   		}				
	}

/******************************************************************************
	Description : 결재선  popup
******************************************************************************/

function fnApproval() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/sy040h.jsp?";
			strPos = "dialogWidth:580px;dialogHeight:530px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);
			sApproveLine = arrResult; // ru
	}


/******************************************************************************
	Description : 기안  popup
******************************************************************************/
function fnDraft() {

	if(ds_default.CountRow ==0){
		alert("기안 할 내용을 조회 해 주세요");
		return;
	}
	
	if(ds_default.namevalue(ds_default.rowposition,"DOC_GRD")!="1"){
		alert("문서등급이 기밀만 기안 가능합니다.");
		return;
	}
		
	if(sApproveLine==""||sApproveLine=="undefined"){
	   alert("결재선지정이 되지 않았습니다.");
	   return;
	}
	
	
	var arrParam	= new Array();
		
	arrParam[0]="010";  // AP006 ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 
	arrParam[1]=ds_default.namevalue(ds_default.rowposition,"DOC_MAG_SID");  //등록번호
	arrParam[2]=sApproveLine;      // 결재선정보 
	
	
	strURL = "<%=dirPath%>/Security/help/li0100h.jsp?";
	strPos = "dialogWidth:740px;dialogHeight:480px;status:no;scroll:no;resizable:no";
	
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/******************************************************************************
	Description : 파일명 중복체크 
******************************************************************************/
function fnFind() {

    if(gcem_fle_nm.text==""){
    	alert("파일명이 존재하지 않습니다.");
    	return;
    }
	
	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  + ",v_fle_nm="+gcem_fle_nm.text
		              + ",v_gdeptcd="+gdeptcd;           
		          
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0100S",  "JSP(O:DS_FILENM=ds_file_nm)",  param);
    //prompt('',ds_default.dataid);   
    tr_post(tr1);
}


/******************************************************************************
	Description : 파일 경로 팝업 
******************************************************************************/
function fnSearch() {
        var strDr=""
        var strFullDr="";

		if(gcem_fle_drc.text==""){
			//strDr="Z:\\Read.txt";
			strDr=tb_InputFile.value;
		}
		
		strFullDr=fnShowFolderList(strDr);  //

		//tb_InputFile.OpenFileName = "Z:\\filename.txt";
		//alert("strDr::"+strDr);
		tb_InputFile.OpenFileName = strDr;
   		tb_InputFile.Open();
   		
   		//alert("tb_InputFile.value::"+tb_InputFile.value);
   		
   		strFullDr=fnShowFolderList(tb_InputFile.value);  //
   		
   		gcem_fle_drc.text = strFullDr;  
   		
        var fso, fileObj,oldName ;		    
        fso=new ActiveXObject('Scripting.FileSystemObject'); // 자동화 개체를 만듬.		
        //alert("tb_InputFile::"+tb_InputFile.value);        
  		fileObj=fso.GetFile(tb_InputFile.value);
	    oldName=fileObj.Name;
	    gcem_fle_nm.text =oldName;
}


/******************************************************************************
	Description : 폴더 경로 찾기 
******************************************************************************/
function fnShowFolderList(drivePath){
	var fso,drvname,enumObj,enum1;
	
	var chk_Drive="N";  //
	
	//var drivePath="Z:\\filename.txt"; //파일이름 임의 설정 
    
    fso=new ActiveXObject('Scripting.FileSystemObject'); // 자동화 개체를 만듬.
    
    enumObj=new Enumerator(fso.Drives);
    
     for (; !enumObj.atEnd(); enumObj.moveNext()){
     	 enum1=enumObj.item();
     	if (enum1.DriveLetter=="Z"){  //Z 드라이브 존재 
			chk_Drive="Y";     	 
			 if (enum1.DriveType==3) {
			 	drvname=enum1.ShareName;   //공유드라이브 경로 
			 	drivePath =drivePath.substring(2,drivePath.length); //Z: 없애기
			 	drvname+=drivePath;                //실제경로
			 }
     	}
     }
     
    if(chk_Drive=="N"){
    	alert(drivePath+" 드라이브가 존재하지 않습니다.");
    	return;
    }
    
    drvname = drvname.substring(14,drvname.length);
     return drvname;
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr       value="-DOC_MAG_SID">
</object>

<object  id=ds_doc_grd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_doc_frm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_crt_div classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_use_yn classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_prs_yr_lmt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_sgn_sts classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=ds_file_nm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=tb_InputFile classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="width=0; height=0;">
	<param name="Text"		value='FileOpen'>
</object>

</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">
	
</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">
  
    ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	
	if(ds_default.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>

<script language="javascript" for="ds_use_yn" event="onloadCompleted(row,colid)">   
	gclx_use_yn.index =1; //default로 적용
</script>


<script language="javascript" for="ds_file_nm" event="onloadCompleted(row,colid)">   
	if(ds_file_nm.namevalue(row,"CNT")!=0){
		alert("기등록한 파일명이 존재합니다.");
	}else{
	    alert("등록한 파일명이 존재하지 않습니다. 등록하셔도 됩니다.");
	}
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="tb_InputFile" event=OnClick()>

        //alert("tb_InputFile.value::"+tb_InputFile.value);

		if (tb_InputFile.value!="") {
			gcem_fle_nm.text = tb_InputFile.value;
		}
</script>

<!-- 그리드 선택일괄 체크 이벤트 -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=left >
			<img src="<%=dirPath%>/Sales/images/ap_line.gif"	style="cursor:hand" onclick="fnApproval()">
			<img src="<%=dirPath%>/Sales/images/ap_up.gif"		style="cursor:hand" onclick="fnDraft()">
		</td>
		<td align=right >
		    <img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
			<img src="<%=dirPath%>/Sales/images/new.gif"	    	style="cursor:hand" onclick="fnAddRow()">
			<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onclick="fnApply()">
			<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" onclick="fnCancel()">
		
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"   class="tab25" bgcolor="#eeeeee" align=center>등록번호</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object id=gcem_doc_mag_sid    classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;left:0px;top:1px;font-size:12px;width:70px;">
					<param name=Text			    value="">
					<param name=Alignment		value=2>
					<param name=Numeric		value=true>
					<param name=MaxLength	value=10>
					<param name=IsComma      value=false>
					<param name=ReadOnly     value="true">
					<param name=ReadOnlyBackColor   value="#C0C0C0">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>원등록번호</td>  
	    <td width="120px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object id=gcem_org_mgn_no    classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;left:0px;top:1px;font-size:12px;width:70px;">
					<param name=Text			    value="">
					<param name=Alignment		value=2>
					<param name=Numeric		value=true>
					<param name=MaxLength	value=10>
					<param name=IsComma      value=false>
					<param name=ReadOnly     value="true">
					<param name=ReadOnlyBackColor   value="#C0C0C0">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
		</td>
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>결재상태</td> 
		<td class="tab24"  colspan =3 >&nbsp;
			<input type="hidden" class="txt11" id="txt_sgn_sts"   style="position:relative;left:-4px;width:0px;background-color:#d7d7d7" readOnly>
			<input type="text" class="txt11" id="txt_sgn_sts_nm"    style="position:relative;left:-10px;width:100px;background-color:#d7d7d7" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="80px"   class="tab30" bgcolor="#eeeeee" align=center>문서등급</td>
		<td width="120px" class="tab28"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_doc_grd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	value="ds_doc_grd">
				<param name=BindColumn      value="detail">
                <param name=BindColVal        value="detail">
                <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                <param name=ListExprFormat  value="detail_nm^0^100">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center>문서형태</td>  
	    <td width="120px" class="tab28">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_doc_frm classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	  	value="ds_doc_frm">
				<param name=CBDataColumns   value="detail, detail_nm">
				<param name=SearchColumn		value=detail_nm>
				<param name=ListExprFormat	    value="detail_nm^0^100">
				<param name=BindColumn			value="detail">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
		</td>
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>소유부서</td> 
		<td class="tab28"  colspan =3 >&nbsp;
			<input type="text" class="txt11" id="txt_own_dpt"       style="position:relative;left:-4px;width:50px;background-color:#d7d7d7" readOnly>
			<input type="text" class="txt11" id="txt_own_dptnm"  style="position:relative;left:-4px;width:100px;background-color:#d7d7d7" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="80px"   class="tab30" bgcolor="#eeeeee" align=center>생산일자</td>
		<td width="120px" class="tab28"  >&nbsp;
			<comment id="__NSID__">
			<object id=gcem_prd_dt    classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;left:0px;top:1px;font-size:12px;width:70px;">
					<param name=Text			    value="">
					<param name=Alignment		value=1>
					<param name=Format          value="YYYY-MM-DD">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center>생산자</td>  
	    <td width="120px" class="tab28">&nbsp;
			<comment id="__NSID__">
			<object id=gcem_prd_psn   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;left:0px;top:1px;font-size:12px;width:1px;">
					<param name=Text			    value="">
					<param name=Alignment		value=0>
					<param name=Numeric		value=true>
					<param name=MaxLength	value=10>
					<param name=IsComma      value=false>
					<param name=Visible          value="false">
			</object>
			
			<object id=gcem_prd_psn_nm  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;left:0px;top:1px;font-size:12px;width:70px;">
					<param name=Text			    value="">
					<param name=Alignment		value=0>
					<param name=MaxLength	value=10>
					<param name=IsComma      value=false>
					<param name=GeneralEdit   value="true">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
			<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="생산자를   검색합니다"  style="cursor:hand"  onclick="javascript:fnPrdPsnPopup();" align='absmiddle'>
			
		</td>
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>생산부서</td> 
		<td class="tab28" colspan =3 >&nbsp;
			<input type="text" class="txt11" id="txt_prd_dpt"       style="position:relative;left:-4px;width:50px;background-color:#d7d7d7" readOnly>
			<input type="text" class="txt11" id="txt_prd_dptnm"  style="position:relative;left:-4px;width:100px;background-color:#d7d7d7" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="80px"   class="tab30" bgcolor="#eeeeee" align=center>폐기일자</td>
		<td width="120px" class="tab28"  >&nbsp;
			<comment id="__NSID__">
			<object id=gcem_dus_dt    classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;left:0px;top:1px;font-size:12px;width:70px;">
					<param name=Text			    value="">
					<param name=Alignment		value=1>
					<param name=Format          value="YYYY-MM-DD">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center>생성구분</td>  
	    <td width="120px" class="tab28">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_crt_div classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	  	value="ds_crt_div">
				<param name=CBDataColumns   value="detail, detail_nm">
				<param name=SearchColumn		value=detail_nm>
				<param name=ListExprFormat	    value="detail_nm^0^100">
				<param name=BindColumn			value="detail">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
		</td>
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>사용유무</td> 
		<td class="tab28">&nbsp;
			<object  id=gclx_use_yn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:60px;">
				<param name=ComboDataID	  	value="ds_use_yn">
				<param name=CBDataColumns   value="detail, detail_nm">
				<param name=SearchColumn		value=detail_nm>
				<param name=ListExprFormat	    value="detail_nm^0^60">
				<param name=BindColumn			value="detail">
			</object>
		</td>
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>보존년한</td> 
		<td class="tab28">&nbsp;
			<object  id=gclx_prs_yr_lmt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:60px;">
				<param name=ComboDataID	  	value="ds_prs_yr_lmt">
				<param name=CBDataColumns   value="detail, detail_nm">
				<param name=SearchColumn		value=detail_nm>
				<param name=ListExprFormat	    value="detail_nm^0^60">
				<param name=BindColumn			value="detail">
			</object>
		</td>
	</tr>
	
	<tr> 
		<td width="80px"    class="tab30"  bgcolor="#eeeeee" align=center>제목</td>
		<td class="tab28"  colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_tle classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>내용</td>
		<td class="tab28" colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_cts classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>키워드</td>
		<td class="tab28" colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_kwd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>파일경로</td>
		<td class="tab28" colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_fle_drc classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
			<img src="<%=dirPath%>/Sales/images/p_search.gif"		style="cursor:hand;position:relative;top:2px" onclick="fnSearch()">
		</td> 
	</tr>
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>실물경로</td>
		<td class="tab28" colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_ral_drc classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>파일명</td>
		<td class="tab28" colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_fle_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
			<img src="<%=dirPath%>/Sales/images/p_find.gif"		style="cursor:hand;position:relative;top:2px" onclick="fnFind()">
		</td> 
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
   <tr><td height="5px"> </td> </tr>
   <tr><td><font  SIZE="2"   COLOR="blue"><b>[기안대상목록]</b></font></td></tr>
   <tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:250px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 value="ds_default">
					<param name="IndWidth"		 value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		 value="true">
					<param name="Sortview"		 value="left">
					<param name="ColSizing"	 value="true">
					<param name="Editable"		 value="False"> 
					<param name=TitleHeight      value="20">
					<param name="Format"	 	 value=" 
					<C> Name='등록번호'		  ID=DOC_MAG_SID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	     </C>
					<C> Name='생성구분' 	      ID=CRT_DIV              HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center   EditStyle=Lookup	Data='ds_crt_div:detail:detail_nm'  </C>
                    <C> Name='등급'  	          ID=DOC_GRD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left         EditStyle=Lookup	Data='ds_doc_grd:detail:detail_nm' </C>
					<C> Name='형태'  	          ID=DOC_FRM	          HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left         EditStyle=Lookup	Data='ds_doc_frm:detail:detail_nm' </C>
					<C> Name='제목'  	          ID=DOC_TLE	          HeadAlign=Center HeadBgColor=#B9D4DC Width=165 	align=left       </C>
					<C> Name='내용'  	          ID=DOC_CTS	          HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	align=left       </C>
					<C> Name='키워드'  	      ID=DOC_KWD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	align=left       </C>
					<C> Name='생산부서'	      ID=PRD_DPT_NM      HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left       </C>
					<C> Name='결재상태'	      ID=SGN_STS 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center   EditStyle=Lookup	Data='ds_sgn_sts:detail:detail_nm' </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>


<comment id="__NSID__">
	<object  id=gcbn_01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_default>
	<param name=BindInfo  value='  
	<C>Col=DOC_MAG_SID	  Ctrl=gcem_doc_mag_sid   Param=TEXT </C>
	<C>Col=DOC_GRD    	      Ctrl=gclx_doc_grd  	       Param=BindColVal</C>
	<C>Col=DOC_FRM    	      Ctrl=gclx_doc_frm 	           Param=BindColVal</C>
	<C>Col=DOC_TLE    	          Ctrl=gcem_doc_tle 	       Param=TEXT</C>
	<C>Col=DOC_CTS    	      Ctrl=gcem_doc_cts 	       Param=TEXT</C>
	<C>Col=DOC_KWD    	      Ctrl=gcem_doc_kwd 	       Param=TEXT</C>
	<C>Col=FLE_DRC    	          Ctrl=gcem_fle_drc 	           Param=TEXT</C>
	<C>Col=RAL_DRC    	          Ctrl=gcem_ral_drc 	       Param=TEXT</C>
	<C>Col=FLE_NM     	          Ctrl=gcem_fle_nm  	       Param=TEXT</C>
	<C>Col=OWN_DPT    	      Ctrl=txt_own_dpt   	           Param=value</C>
	<C>Col=OWN_DPT_NM       Ctrl=txt_own_dptnm           Param=value</C>
	<C>Col=PRD_DPT    	      Ctrl=txt_prd_dpt  	           Param=value</C>
	<C>Col=PRD_DPT_NM        Ctrl=txt_prd_dptnm             Param=value</C>
	<C>Col=PRD_PSN    	      Ctrl=gcem_prd_psn 	       Param=TEXT</C>
	<C>Col=PRD_PSN_NM 	  Ctrl=gcem_prd_psn_nm    Param=TEXT</C>
	<C>Col=PRD_DT     	          Ctrl=gcem_prd_dt  	           Param=TEXT</C>
	<C>Col=PRS_YR_LMT 	      Ctrl=gclx_prs_yr_lmt 	       Param=BindColVal</C>
	<C>Col=SGN_STS    	      Ctrl=txt_sgn_sts  	           Param=value</C>
	<C>Col=SGN_STS_NM	      Ctrl=txt_sgn_sts_nm          Param=value</C>
	<C>Col=CRT_DIV    	          Ctrl=gclx_crt_div 	           Param=BindColVal</C>
	<C>Col=USE_YN     	          Ctrl=gclx_use_yn  	           Param=BindColVal</C>
	<C>Col=DUS_DT     	          Ctrl=gcem_dus_dt  	       Param=TEXT</C>
	<C>Col=ORG_MGN_NO 	  Ctrl=gcem_org_mgn_no	   Param=TEXT</C>
	'>
</object>
</comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 