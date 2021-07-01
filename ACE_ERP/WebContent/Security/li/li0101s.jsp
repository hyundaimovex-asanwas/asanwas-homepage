<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 정보보보>정보관리>등록관리>정보조회
* 프로그램 ID	: li0101S.jsp
* 기 능 정 의	: 정보조회
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
	ds_doc_grd.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=LI001&s_item1=Y";
    ds_doc_grd.Reset(); //문서등급
    
    ds_doc_frm.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=LI002&s_item1=Y";
    ds_doc_frm.Reset(); //문서형태
    
    ds_crt_div.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI003&s_item1=Y";
    ds_crt_div.Reset(); //생성구분
    
    ds_sgn_sts.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP002&s_item1=Y";
    ds_sgn_sts.Reset(); //결재상태
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function fnSelect() {

	 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		              + ",v_doc_grd="+gclx_doc_grd.bindcolval
		              + ",v_doc_frm=" +gclx_doc_frm.bindcolval
		              + ",v_gdeptcd=" + txt_own_dpt.value
		              + ",v_doc_tle=" + gcem_doc_tle.text
		              + ",v_doc_cts=" + gcem_doc_cts.text
		              + ",v_doc_kwd=" + gcem_doc_kwd.text;
              
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0101S",  "JSP(O:DS_DEFAULT=ds_default)",  param);
       
    tr_post(tr1);

}

/******************************************************************************
	Description : 폴더 경로 찾기 
******************************************************************************/
function fnShowFolderList(drivePath){
	var fso,drvname,enumObj,enum1;
	var chk_Drive="N";
    
    fso=new ActiveXObject('Scripting.FileSystemObject'); // 자동화 개체를 만듬.
    
    enumObj=new Enumerator(fso.Drives);
    
    for (; !enumObj.atEnd(); enumObj.moveNext()){
     	 enum1=enumObj.item();
     	if (enum1.DriveLetter=="Z"){  //Z 드라이브 존재 
			chk_Drive="Y";     	 
			 if (enum1.DriveType==3) drvname=enum1.ShareName
     	}
    }
     
    if(chk_Drive=="N"){
    	alert(drivePath+" 드라이브가 존재하지 않습니다.");
    	return;
    }
         
    drvname = drvname.substring(14,drvname.length); //ip주소 제거 경로 
    drivePath = ds_default.namevalue(ds_default.rowposition,"FLE_DRC");  
    var strFile="";
    
    strFile= drivePath.substring(drvname.length,drivePath.length);
      
    var strRoot="Z:";
    var strA="";
    var myArray=Array(); // 배열변수의 지정
    
    myArray= strFile.split("\\ ");
    
    for(var i =0; i<myArray.length;i++){
        strA="";	 
    	 
    	 if(i<myArray.length-1){
    	    strA = myArray[i]+"\\";	
    	 }else{
            strA = myArray[i]
    	 }
    	 strRoot += strA; 
    }
    
   
   	tb_InputFile.OpenFileName =strRoot;
    tb_InputFile.Open();
 
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

<object  id=ds_sgn_sts classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
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


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>

   if(colid=="FLE_DRC" && row>0){
   		fnShowFolderList('Z:\\');
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
		<td align=right >
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"   class="tab25" bgcolor="#eeeeee" align=center>문서등급</td>
		<td width="120px" class="tab24"  >&nbsp;
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
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>문서형태</td>  
	    <td width="120px" class="tab24">&nbsp;
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
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>소유부서</td> 
		<td class="tab24" >&nbsp;
			<input type="text" class="txt11" id="txt_own_dpt"       style="position:relative;left:-4px;width:50px;background-color:#d7d7d7" readOnly>
			<input type="text" class="txt11" id="txt_own_dptnm"  style="position:relative;left:-4px;width:180px;background-color:#d7d7d7" readOnly>
		</td>
	</tr>
	
	<tr> 
		<td width="80px"    class="tab30"  bgcolor="#eeeeee" align=center>제목</td>
		<td class="tab28"  colspan =5 >&nbsp;
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
		<td class="tab28" colspan =5 >&nbsp;
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
		<td class="tab28" colspan =5 >&nbsp;
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
	
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:345px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 value="ds_default">
					<param name="IndWidth"		 value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		 value="true">
					<param name="Sortview"		 value="left">
					<param name="ColSizing"	 value="true">
					<param name="Editable"		 value="False"> 
					<param name=TitleHeight      value="30">
					<param name="Format"	 	 value=" 
					<FC> Name='등록번호'		  ID=DOC_MAG_SID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	     </FC>
					<FC> Name='생성\\구분' ID=CRT_DIV              HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=center  EditStyle=Lookup	Data='ds_crt_div:detail:detail_nm'  </FC>
                    <FC> Name='등급'  	          ID=DOC_GRD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=left        EditStyle=Lookup	Data='ds_doc_grd:detail:detail_nm' </FC>
					<FC> Name='형태'  	          ID=DOC_FRM	          HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=left        EditStyle=Lookup	Data='ds_doc_frm:detail:detail_nm' </FC>
					<FC> Name='제목'  	          ID=DOC_TLE	          HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	align=left       </FC>
					<C> Name='내용'  	          ID=DOC_CTS	          HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	align=left       </FC>
					<C> Name='키워드'  	      ID=DOC_KWD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	align=left       </C>
					<C> Name='생산일자'  	      ID=PRD_DT	          HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center   MASK='XXXX/XX/XX'       </C>
					<C> Name='생산부서'	      ID=PRD_DPT_NM      HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left       </C>
					<C> Name='결재상태'	      ID=SGN_STS 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center   EditStyle=Lookup	Data='ds_sgn_sts:detail:detail_nm'  </C>
					<C> Name='파일경로'	      ID=FLE_DRC  	          HeadAlign=Center HeadBgColor=#B9D4DC Width=500 	align=left       BgColor=#B9D1DC </C>
					<C> Name='실물경로'          ID=RAL_DRC	          HeadAlign=Center HeadBgColor=#B9D4DC Width=500 	align=left       </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 