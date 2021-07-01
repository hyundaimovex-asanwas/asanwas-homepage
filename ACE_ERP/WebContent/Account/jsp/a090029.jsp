<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	: 자산관리- 건설중인자산
+ 프로그램 ID	: A090029.html
+ 기 능 정 의	: 건설중인자산 등록화면. ( 총괄표 출력용으로 사용함 ) 
+ 작   성  자 : 정영식
+ 작 성 일 자 : 2011.07.11
-----------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A090029_s1,A090029_s2, A090029_s3
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>건설중인자산</title>

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

var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode = gfdcode;


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
	//소속코드[검색]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//관리항목(건설중인자산)
	gcds_astrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1009";
	gcds_astrefcd.Reset();

  //그리드용
	gcds_astrefcd_g.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1009";
	gcds_astrefcd_g.Reset();

	//관리항목(건설중자산명)
	gcds_astcipcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2180";
	gcds_astcipcd.Reset();

	gcds_astcipcd_g.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2180";
	gcds_astcipcd_g.Reset();
	
	gclx_fdcode.bindcolval = gs_fdcode;
	gclx_aststat.index=0;

 }

/******************************************************************************
	Description : 조회
	Parameter   : p - 01 : 신규취득등록 ,  02 : 대체등록
******************************************************************************/
function ln_Query(p){

	if(p=="01"){
		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_s1"
											 + "?v_str1="+gclx_fdcode.bindcolval
											 + "&v_str2="+gclx_astrefcd.bindcolval
											 + "&v_str3="+gclx_astcipcd.bindcolval
											 + "&v_str4="+gclx_aststat.bindcolval;
		//prompt('',gcds_data01.DataID);
		gcds_data01.Reset();
	}else{
		gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_s2"
											 + "?v_str1="+gclx_fdcode.bindcolval
											 + "&v_str2="+gclx_astrefcd.bindcolval
											 + "&v_str3="+gclx_astcipcd.bindcolval
											 + "&v_str4="+gclx_aststat.bindcolval;
		//prompt('',gcds_data02.DataID);
		gcds_data02.Reset();
	}
}

/******************************************************************************
	Description : 추가
	Parameter   : p - 01 : 신규취득등록,  02 : 대체등록
******************************************************************************/
function ln_Add(p){
	if(p=="01"){
		gcds_data01.Addrow();
	}else{
		gcds_data02.Addrow();
	}
}

/******************************************************************************
	Description : 저장
	Parameter   : p - 01 : 신규취득등록,  02 : 대체등록
******************************************************************************/
function ln_Save(p){
	if(p=="01"){
		if(!ln_Chk_Save(p)) return; 
		if(gcds_data01.IsUpdated){
			if(confirm("건설중인자산 신규취득을 하시겠습니까?")){
					gctr_code01.KeyValue   =  "Account.a090029_t1(I:USER=gcds_data01)";
					gctr_code01.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_t1?";
					gctr_code01.Parameters =  "v_str1="+gusrid;
					//prompt('',gcds_data01.text);
					gctr_code01.post();
			}
		}
	}else{
		if(!ln_Chk_Save(p)) return; 
		if(gcds_data02.IsUpdated){
			if(confirm("건설중인자산 대체등록을 하시겠습니까?")){
					gctr_code01.KeyValue   =  "Account.a090029_t2(I:USER=gcds_data02)";
					gctr_code01.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_t2?";
					gctr_code01.Parameters =  "v_str1="+gusrid;
					//prompt('',gcds_data02.text);
					gctr_code01.post();
			}
		}
	}
}

/******************************************************************************
	Description : 추가
	Parameter   : p - 01 : 신규취득등록,  02 : 대체등록
******************************************************************************/
function ln_Chk_Save(p){
	return true;
}


/******************************************************************************
	Description : 삭제
	Parameter   : p - 01 : 신규취득등록,  02 : 대체등록
******************************************************************************/
function ln_Delete(p){
  if(p=="01"){
		if (confirm("선택하신 신규취득등록 건을 삭제하시겠습니까?")){
				gcds_data01.deleterow(gcds_data01.rowposition);
				gctr_code01.KeyValue = "a090029_t1(I:USER=gcds_data01)";
				gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_t1";
				//prompt('',gcds_code02.text);
				gctr_code01.post();
		}
  }else{
		if (confirm("선택하신 대체등록 건을 삭제하시겠습니까?")){
				gcds_data02.deleterow(gcds_data02.rowposition);
				gctr_code01.KeyValue = "a090029_t2(I:USER=gcds_data02)";
				gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_t2";
				//prompt('',gcds_code02.text);
				gctr_code01.post();
		}
	}
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- 관리항목 -->
<object  id=gcds_astrefcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_astrefcd_g classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 건설중인자산명 -->
<object  id=gcds_astcipcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_astcipcd_g classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 지점 -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090008_t1(I:USER=gcds_code01)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ft_cnt01.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
  
  ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
</script>


<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	ft_cnt02.innerText="데이타 조회중입니다.";
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)"> 
  ft_cnt02.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
</script>

<!-- 지점분류 (검색)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	gclx_fdcode.index=0;
</script>


<!-- 관리항목 (검색)-->
<script language="javascript" for="gcds_astrefcd" event="onloadCompleted(row,colid)">
	gcds_astrefcd.InsertRow(1);
	gcds_astrefcd.NameValue(1,"CDCODE")="";
	gcds_astrefcd.NameValue(1,"CDNAM")="전체";
	gclx_astrefcd.index=0;
</script>

<!-- 건설중인자산명-->
<script language="javascript" for="gcds_astcipcd" event="onloadCompleted(row,colid)">
	gcds_astcipcd.InsertRow(1);
	gcds_astcipcd.NameValue(1,"CDCODE")="";
	gcds_astcipcd.NameValue(1,"CDNAM")="전체";
	gclx_astcipcd.index=0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gclx_asdivcod event=OnSelChange()>
	ln_Ast3rd();
</script>

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>  
	
</script>


<script language=JavaScript for=gcgd_disp01 event=OnPopup(row,colid,data)>

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = gcds_data01.namevalue(row,"FDCODE");

	strURL = "./hcdept_popup4.jsp";
	strPos = "dialogWidth:500px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(arrResult != null) {
		arrParam = arrResult.split(";"); 
		//alert("arrParam[0]::"+arrParam[0]+"::arrParam[1]"+arrParam[1]);
		gcds_data01.namevalue(row,"USEDPT")= ln_Trim(arrParam[0]);
		gcds_data01.namevalue(row,"DEPTNM")= ln_Trim(arrParam[1]);
	} else {
		gcds_data01.namevalue(row,"USEDPT")= "";
		gcds_data01.namevalue(row,"DEPTNM")= "";
	}

</script>


<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  if(colid=="ASTNM"){

		strURL = "./astname_popup.jsp";
		strPos = "dialogWidth:596px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			gcds_data02.namevalue(row,"ASTNM")  = arrParam[1];  //자산명
			gcds_data02.namevalue(row,"ASTNAME")= arrParam[0];  //자산코드
		} else {
			gcds_data02.namevalue(row,"ASTNM")  = "";
			gcds_data02.namevalue(row,"ASTNAME")= "";
		}
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
</script>
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090029_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  class="tab25" bgcolor="#eeeeee" align=center>지점</td>
		<td width="100px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:80px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=ListExprFormat	value="FDNAME^0^100">
				<param name=BindColumn			value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 

    <td width="80px"   class="tab24"  bgcolor="#eeeeee" align=center>관리항목</td>  
	  <td class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_astrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
				<param name=ComboDataID     value="gcds_astrefcd">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=Sort						value="false">
				<param name=ListExprFormat	value="CDNAM^0^120">
				<param name=BindColumn			value="CDCODE">
				<param name=XPStyle         value=true>
			</object></comment><script>__ws__(__NSID__);</script> 			
		</td>
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>건설중자산명</td>  
	  <td width="180px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_astcipcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:160px;">
				<param name=ComboDataID     value="gcds_astcipcd">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=Sort						value="false">
				<param name=ListExprFormat	value="CDNAM^0^170">
				<param name=BindColumn			value="CDCODE">
				<param name=XPStyle         value=true>
       </object>
			 </comment><script>__ws__(__NSID__);</script>
		</td>

		<td width="80px"   class="tab24"  bgcolor="#eeeeee" align=center>상태</td>  
	  <td class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_aststat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:90px;">
				<param name=CBData					value="''^전체,0^진행중,1^완료">
				<param name=CBDataColumns		value="Code, Parm">
				<param name=SearchColumn		value="Parm">
				<param name=Sort						value="false">
				<param name=ListExprFormat	value="Parm^0^100">
				<param name=BindColumn			value="Code">
				<param name=XPStyle         value=true>
			</OBJECT></comment><script>__ws__(__NSID__);</script> 			
		</td>
	</tr>
</table>
<table><tr><td height="1px;"> </td></tr></table>


<table width="858px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr>
		<td width="680px" > <font size="2" color="blue"> <b> [신규취득등록] </b> </font></td>
		<td align="right" >
			<img src="../../Common/img/btn/com_b_delete.gif"	  style="cursor:hand" onClick="ln_Delete('01')">
			<img src="../../Common/img/btn/com_b_insert.gif"	  style="cursor:hand" onClick="ln_Add('01')">
			<img src="../../Common/img/btn/com_b_save.gif"	    style="cursor:hand" onClick="ln_Save('01')">
			<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand" onClick="ln_Query('01')">
		</td>
	</tr>
	<tr> 
		<td colspan =2>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:200px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_data01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="true"> 
					<param name=TitleHeight   value="20">
					<param name=ViewSummary   value="1">
					<param name="Format"		value=" 
					<C> Name='지점'		         ID=FDCODE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=45	  align=left   SumBgColor=#C3D0DB sumtext='' EditStyle=Combo Data='02:서울,03:금강산,04:개성' </C>
					<C> Name='건설중자산명'		 ID=ASTCIPCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=left	 SumBgColor=#C3D0DB sumtext='' EditStyle=Lookup Data='gcds_astcipcd_g:CDCODE:CDNAM'</C>
					<C> Name='진행년월'   		 ID=ASTYYMM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  	align=center SumBgColor=#C3D0DB sumtext='' Mask='XXXX/XX' </C>
					<C> Name='취득일자'   		 ID=ASAQSDAT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  	align=center SumBgColor=#C3D0DB sumtext='' Mask='XXXX/XX/XX' </C>
					<C> Name='관리항목'        ID=ASTREFCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=left   SumBgColor=#C3D0DB sumtext='' EditStyle=Lookup Data='gcds_astrefcd_g:CDCODE:CDNAM'</C>
					<C> Name='사용부서'		     ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 	align=left	 SumBgColor=#C3D0DB sumtext='계' EditStyle=Popup </C>
					<C> Name='원화'   			   ID=ASTAQAMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right  SumBgColor=#C3D0DB sumtext='@sum' </C>
					<C> Name='외화'     		   ID=ASTAQAMTY	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right  SumBgColor=#C3D0DB sumtext='@sum' </C>
					<C> Name='적요'		         ID=REMARK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=130  align=left   SumBgColor=#C3D0DB sumtext='' </C>
					<C> Name='상태'   		     ID=STATUS  	HeadAlign=Center HeadBgColor=#B9D4DC Width=45   align=left   SumBgColor=#C3D0DB sumtext='' EditStyle=Combo Data='0:진행중,1:완료'</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
  </tr>
  <tr>
		<td colspan=2><BR></td>
  </tr>
</table>

<table width="858px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr>
		<td width="680px" > <font size="2" color="blue"> <b> [대체등록] </b> </font></td>
		<td align="right" >
			<img src="../../Common/img/btn/com_b_delete.gif"	  style="cursor:hand" onClick="ln_Delete('02')">
			<img src="../../Common/img/btn/com_b_insert.gif"	  style="cursor:hand" onClick="ln_Add('02')">
			<img src="../../Common/img/btn/com_b_save.gif"	    style="cursor:hand" onClick="ln_Save('02')">
			<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand" onClick="ln_Query('02')">
		</td>
	</tr>
	<tr> 
		<td colspan =2>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
			style="position:relative;left:0px;width:858px; height:200px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_data02">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="true"> 
					<param name=TitleHeight   value="20">
					<param name="Format"		  value=" 
					<C> Name='지점'			       ID=FDCODE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=45	  align=left    EditStyle=Combo Data='02:서울,03:금강산,04:개성'</C>
					<C> Name='건설중자산명'		 ID=ASTCIPCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=left	  EditStyle=Lookup Data='gcds_astcipcd_g:CDCODE:CDNAM'</C>
					<C> Name='완료년월'		     ID=ASTYYMM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  	align=center  Mask='XXXX/XX'</C>
					<G> Name='대체정보'        HeadBgColor=#B9D4DC
						<C> Name='자산번호'			 ID=ASTNBR   	HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left	  </C>         
						<C> Name='자산명'        ID=ASTNM 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left    EditStyle=Popup </C>
						<C> Name='계정명' 			 ID=ATCODE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	  EditStyle=Combo Data='1220200:건물,1220700:공기구비품,1220300:구축물,1220400:기계장치,1222100:기타유형자산,1220600:차량운반구,1220100:토지'</C>
						<C> Name='취득일자'			 ID=ASAQSDAT	HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=left	  Mask='XXXX/XX/XX' </C>
						<C> Name='대체원화'			 ID=ASTRAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right   </C>
						<C> Name='대체외화'	     ID=ASTRAMTY  HeadAlign=Center HeadBgColor=#B9D4DC Width=90  	align=right   </C>
					</G>
					<C> Name='비고' 		       ID=REMARK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90   align=left    </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font></fieldset>
		</td>
  </tr>
  <tr>
		<td colspan =2 ><BR></td>
  </tr>
</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 