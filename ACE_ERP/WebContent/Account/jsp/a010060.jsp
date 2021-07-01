
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 관리비 계정 매칭 
+ 프로그램 ID	: a010060.jsp
+ 기 능 정 의	: CALL SALES.PR_SY141I_02('3',1000,'6070001');
+ 최 초 이 력	: 
+ 변 경 이 력	: 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ 수 정 내 용  :
+ 수   정  자  : 
+ 수 정 일 자  :
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a010060_s1, a010060_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

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

var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;



/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
    
    /**
	if(gf_empno_Enable(gs_userid,gcds_userid2)){
			sp0.style.display = "";
		}else{
		sp0.style.display = "none"; //숨김
	}
	**/
	/**
    gcra_reggb_0.codevalue="P"
    gcra_usegb_0.codevalue="1";
    gcra_use_tag_0.codevalue ="Y";	
    gcra_use_tag.codevalue ="Y";	
    gclx_cocomyn.index=0;
    **/
    
    /**
	txt_vend_cd.value  = "" ;
	txt_vend_nm.value  = "" ;
	gcem_vend_id2.text	= "" ;
	txt_empnm.value	= "" ;	
	txt_email.value	= "" ;	
	txt_deptnm.value = "" ;	
	txt_hpno.value	= "" ;	
	txt_telno.value	= "" ;	
	gcem_dsudt.text = "" ;	
	gcra_usegb.CodeValue = "" ; 
	txt_bsns_cnd.value	= "" ;	
	txt_bsns_knd.value = "" ;	
	**/
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010060_s1?v_str1="+gcem_yymm.text;
	                                                                                                                            
	                                                                                                                              
	                                                                                                                              
    //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}


/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	ln_SetDataHeader();
	gcds_data.addrow();	
}


/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010060_t1";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		gctr_pyo.post();
		ln_Query();
		}	
	}
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Save() {

   for(i=1;i<=gcds_data.countrow;i++){
   		if(gcds_data.namevalue(i,"BATCODE") == ""){//
			alert("판매비 계정을  입력하세요.");
			return false;
		}
		
		if(gcds_data.namevalue(i,"ATCODE") == ""){//
			alert("판매관리비 계정을  입력하세요.");
			return false;
		}
		
		if(gcds_data.namevalue(i,"FRYM") == ""){//
			alert("시작년월을  입력하세요.");
			return false;
		}
		
		if(gcds_data.namevalue(i,"TOYM") == ""){//
			alert("종료년월을  입력하세요.");
			return false;
		}
   }
	return true;
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
  
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010060_t1";
		gctr_pyo.post();
		return ln_Query();
	}	else {
	  gcds_data.undo(gcds_data.rowposition);
	}
}


/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	gcds_data.undo(gcds_data.rowposition);
}
/******************************************************************************
	Description : 삭제
******************************************************************************/

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}


/******************************************************************************
	Description : 문자열체크
******************************************************************************/


/******************************************************************************
	Description : 중복체크 팝업
******************************************************************************/
function ln_Find2(){
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	if(gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")!=""){
	    alert("신규 등록시에만 중복 체크 가능합니다.");
		return false;
	}
	
	strURL = "../../Account/jsp/a010050_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:120px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		ln_usegb_format(arrParam[1]);
		gcem_vend_id.text = arrParam[0];
	} else {
		gcem_vend_id.text ="";
	}
}

/******************************************************************************
	Description : Dataset Head 설정 -  
******************************************************************************/
function ln_SetDataHeader(){
	if(gcds_data.countrow<1){
		var THeader = "BATCODE:STRING,BATKORNAM:STRING,ATCODE:STRING,ATKORNAM:STRING,FRYM:STRING,"
							+ "TOYM:STRING";
		gcds_data.SetDataHeader(THeader);						
	}
}

/******************************************************************************
	Description : 팝업
  parameter   : 
******************************************************************************/
function ln_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]='ATUSEYN';
    arrParam[1]='B';
	strURL = "./actcode_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_batcode.text = arrResult[0];
		gcem_batkornam.text = arrResult[1];
	}else{
        gcem_batcode.value="";
		gcem_batkornam.value="";
	}
}

/******************************************************************************
	Description : 계정초기화
  parameter   : 
******************************************************************************/
function ln_Clear(){
	gcem_atkornam.text="";
    gcem_atcode.text="";
}
/******************************************************************************
	Description : 팝업
  parameter   : 
******************************************************************************/
function ln_Popup2(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]='ATUSEYN';
    arrParam[1]='B';
	strURL = "./actcode_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_atcode.text = arrResult[0];
		gcem_atkornam.text = arrResult[1];
	}else{
        gcem_atcode.value="";
		gcem_atkornam.value="";
	}
}

/******************************************************************************
	Description : 계정초기화
  parameter   : 
******************************************************************************/
function ln_Clear2(){
	gcem_atkornam.text="";
    gcem_atcode.text="";
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- 로그인 사번 체크  -->
<comment id="__NSID__"><object  id=gcds_userid2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010047_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//총 조회 건수
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
//		ln_Query();
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language=JavaScript for=gcgd_pyo event=OnClick(row,colid)>
    
</script>


<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
	    <td ><img src="../img/a010060_head.gif"></td>
	    <td width="680" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	    style="cursor:hand" onclick="ln_Add()" >
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"      style="cursor:hand" onclick="ln_Cancel()">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"       style="cursor:hand" onclick="ln_Delete()">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		    style="cursor:hand" onclick="ln_Save()">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
   </tr>
 </table>
 <table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
	    <td  colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;"  >
		<tr> 			
		    
         		<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">적용년월</td>
			    <td >
						<comment id="__NSID__"><object  id=gcem_yymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:4px;top:0px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM">
							<param name=PromptChar			value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
			      </td>
			</tr>
		</table>
		</td>
	</tr>

	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-7px;width:500px;border:0 solid #708090;">
				<tr> 			
					<td>
						<comment id="__NSID__">
							<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo  
							 			 style="position:relative;left:7px;width:500px; top:1px;height:401px; border:1 solid #708090;">
				              <PARAM NAME="DataID"			VALUE="gcds_data">
				              <PARAM NAME="Editable"		VALUE="false">
				              <PARAM NAME="BorderStyle" VALUE="0">
							  <param name="SortView"    value="Left">
							  <param name="ColSizing"  value="true">
							  <param name="FillArea"   value="True">
							  <param name="IndWidth"   value="0">
							  <PARAM NAME="Format"			VALUE="
							  	<G> name='판매비' HeadAlign=Centert HeadBgColor=#B9D4DC
									<C> Name='코드'	    ID=BATCODE	     HeadAlign=Center HeadBgColor=#B9D4DC	 Width=60   align=center sort=true </C>
									<C> Name='계정명'	ID=BATKORNAM	 HeadAlign=Center HeadBgColor=#B9D4DC  Width=120  align=left   sort=true </C> 
								</G>
								<G> name='판매관리비' HeadAlign=Centert HeadBgColor=#B9D4DC
									<C> Name='코드' 	    ID=ATCODE  	     HeadAlign=Center HeadBgColor=#B9D4DC  Width=60   align=center sort=true</C>
									<C> Name='계정명'	ID=ATKORNAM	 HeadAlign=Center HeadBgColor=#B9D4DC  Width=120  align=left   sort=true</C>
								</G>
								<G> name='적용년월' HeadAlign=Centert HeadBgColor=#B9D4DC
									<C> Name='시작'	ID=FRYM  HeadAlign=Center  HeadBgColor=#B9D4DC  Width=60   align=center sort=true mask ='XXXX/XX' </C>
									<C> Name='종료'	ID=TOYM  HeadAlign=Center  HeadBgColor=#B9D4DC  Width=60   align=center sort=true mask ='XXXX/XX' </C>
								</G> 
								">
            				</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:7px;width:502px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt06 style="position:relative;top:4px;">조회건수 :</font>
						</fieldset>
				</td>
			</tr>
		</table>
		</td>
		<td>
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:-4px;top:0px;width:360px;border:0 solid #708090;">
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>판매비</nobr></td>
					<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;<nobr>				
					<comment id="__NSID__"><object  id=gcem_batkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:-5px;top:2px;">
			      		<param name=Text				 value="">
						<param name=Alignment       value=0>
						<param name=Border           value=true>
						<param name=Numeric         value=false>
						<param name=PromptChar    value="">
						<param name=BackColor      value="#CCCCCC">
						<param name=InheritColor    value=false>
						<param name=GeneralEdit    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:0px;top:0px" align=center onclick="ln_Popup();">
					<comment id="__NSID__"><object  id=gcem_batcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:2px;">
			      		<param name=Text				 value="">
						<param name=Alignment       value=0>
						<param name=Border           value=true>
						<param name=Numeric         value=false>
						<param name=Format            value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor      value="#CCCCCC">
						<param name=InheritColor    value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					&nbsp;
					<img SRC="../../Common/img/btn/com_b_clear.gif" BORDER="0" style="cursor:hand;position:relative;left:-5px;top:2px" align=center onclick="ln_Clear();">
					</nobr>
					</td>
				</tr>
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>판매관리비</nobr></td>
					<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<nobr>				
					<comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:-5px;top:2px;">
			      		<param name=Text				 value="">
						<param name=Alignment       value=0>
						<param name=Border           value=true>
						<param name=Numeric         value=false>
						<param name=PromptChar    value="">
						<param name=BackColor      value="#CCCCCC">
						<param name=InheritColor    value=false>
						<param name=GeneralEdit    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:0px;top:0px" align=center onclick="ln_Popup2();">
					<comment id="__NSID__"><object  id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:2px;">
			      		<param name=Text				 value="">
						<param name=Alignment       value=0>
						<param name=Border           value=true>
						<param name=Numeric         value=false>
						<param name=Format            value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor      value="#CCCCCC">
						<param name=InheritColor    value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					&nbsp;
					<img SRC="../../Common/img/btn/com_b_clear.gif" BORDER="0" style="cursor:hand;position:relative;left:-5px;top:2px" align=center onclick="ln_Clear2();">
					</nobr>
					</td>
				</tr>
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>시작년월</nobr></td>
					<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_frym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:0px;top:2px">				
						<param name=Text				value="">
						<param name=Border          value=true>
						<param name=format           value="YYYY/MM">
						<param name=maxlength     value="6">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=false>
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;
					</td>
				</tr>
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>종료년월</nobr></td>
					<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_toym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:0px;top:2px">				
						<param name=Text				value="">
						<param name=Border          value=true>
						<param name=format           value="YYYY/MM">
						<param name=maxlength     value="6">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=false>
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;
					</td>
				</tr>
				<tr>
				<td height="308px" style="border:1 solid #708090;border-right-width:0px;border-top-width:0px;">&nbsp;</td><!--밑에 비고칸-->
				<td height="308px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td>
			</tr>	
		</table> 
	</td>
		 </tr>
		</table>

	<tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search">
		</label></td>
  </tr>	
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='

		<C>Col=BATCODE,         Ctrl=gcem_batcode      Param=text		    </C>
		<C>Col=BATKORNAM,    Ctrl=gcem_batkornam   Param=text	    </C>
		<C>Col=ATCODE,           Ctrl=gcem_atcode        Param=text		    </C>
		<C>Col=ATKORNAM,      Ctrl=gcem_atkornam     Param=text		    </C>
		<C>Col=FRYM,               Ctrl=gcem_frym            Param=text		    </C>
		<C>Col=TOYM,               Ctrl=gcem_toym           Param=text		    </C>
		
	'>
</object></comment><script>__ws__(__NSID__);</script>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



