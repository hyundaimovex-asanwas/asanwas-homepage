<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  세금계산서목록	
+ 프로그램 ID	:  Com_Tax_List1.html
+ 기 능 정 의	:  세금계산서목록 팝업
+ 작   성  자 :  구 자 헌
+ 작 성 일 자 :  2006.03.23
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 화면사이즈 및 계산일자 추가   
+ 수   정  자 :  정영식
+ 수 정 일 자 :  2006.03.08
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

<title>세금계산서목록</title>

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
var parentGubun="";
get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	//파라미터 넘겨받음.
	var strParam = new Array();
	strParam=window.dialogArguments;

	ln_Before();
	gclx_taxiodiv.bindcolval="";
	gclx_documcd.bindcolval = strParam[6]; //증빙구분

	ln_Query();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
    var strGubun="";
	var strSabun="";


	//담당사원만 전체조회
	//나머진 개별로만 조회가능
    if(gs_userid=="2050053"||gs_userid=="6060001"||gs_userid=="2020009"||gs_userid=="2060015" ){
		strSabun="A";
	}else{
    	strSabun=gs_userid;
	}


	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>com_tax_list1_s1_e?v_str1="+gcem_vendnm.text
	                                                                              +"&v_str2="+gcem_taxdat_fr.text
																				  +"&v_str3="+gcem_taxdat_to.text
																				  +"&v_str4="+gcem_remark.text
																				  +"&v_str5="+gclx_taxiodiv.bindcolval
																				  +"&v_str6="+gclx_documcd.bindcolval
																				  +"&v_str7="+strGubun
																				  +"&v_str8="+strSabun;
    //prompt("",gcds_code01.DataID);
	gcds_code01.Reset();
}

/******************************************************************************
	Description : 조회
	parameter   : p - 계산서번호
******************************************************************************/
function ln_Query2(p){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>com_tax_list1_s2?v_str1="+p;
	//prompt("gcds_data.DataID",gcds_data.DataID)
	gcds_data.Reset();
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
	Description : 선조건
******************************************************************************/
function ln_Before(){ 
    gcem_taxdat_fr.text = gcurdate.substring(0,4) + gcurdate.substring(5,7)+"01";				//계산서기간 년 월
	gcem_taxdat_to.text = gs_date;	 //계산서기간 년 월
	//gcra_number.codevalue = "N";     //콤보의 초기값을 미연결로

	gcds_documcd.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0052&v_str2=01"
	//prompt("",gcds_documcd.DataID);
	gcds_documcd.Reset();

}

/***********************************************************************************************
	Description : 거래처 찾기
	parameter   :
**********************************************************************************************/
function ln_Popup(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_vendnm.text = arrParam[1];
		gcem_vendcd.text = arrParam[0];
	} else {
		gcem_vendnm.text = "";
		gcem_vendcd.text = "";
	}
}

/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		if(gcds_code01.countrow<1) {
			alert("선택하실 거래처가 없습니다.");
		}
		else {

			var row = gcds_code01.rowposition;
			var strTemp="";
			var strDouc=gclx_documcd.bindcolval;
			var strDouc_blank="000";
			if(gcds_code01.namevalue(row,"FSNBR")!=""){
				alert("전표와 이미 연결된 계산서는 연결할 수 없습니다.");
				return;
			}

			ln_Query2(gcds_code01.namevalue(row,"TAXNBR"));
		
			//계정코드, 계정명, 거래처코드, 거래처명, 부서코드, 부서명,
            //적요 , 차변금액, 대변금액(반복), 계산서번호, 증빙코드
			//본부코드, 계산서일자
			for(i=1;i<=gcds_data.countrow;i++){
			  if(i>1)strTemp+=";"
				strTemp += gcds_data.namevalue(i,"ATCODE")+";"
				strTemp += gcds_data.namevalue(i,"ATKORNAM")+";"
				strTemp += gcds_data.namevalue(i,"VEND_CD")+";"
				strTemp += gcds_data.namevalue(i,"VEND_NM")+";"
				strTemp += gcds_data.namevalue(i,"DEPTCD")+";"
				strTemp += gcds_data.namevalue(i,"DEPTNM")+";"
				strTemp += gcds_data.namevalue(i,"REMARK")+";"
				strTemp += gcds_data.namevalue(i,"CHAAMT")+";"
				strTemp += gcds_data.namevalue(i,"DAEAMT")+";"
				strTemp += gcds_data.namevalue(i,"TAXNBR")+";"
				
				if(i==1){
					strTemp += strDouc_blank+";"
				}else{
					strTemp += strDouc+";"
				}
				
				strTemp += gcds_data.namevalue(i,"DIVCD")+";"
				strTemp += gcds_data.namevalue(i,"TAXDAT")
				//alert("TAXDAT"+gcds_data.namevalue(i,"TAXDAT"));
			}

			///prompt("strTemp",strTemp);

			window.returnValue = strTemp;
			window.close();
		}
	} else {
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_documcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 로그인 부서 체크 -->
<comment id="__NSID__"><object  id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code01.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
	<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:800px;border:1 solid #708090">
			<tr>
					<td width="90" class="tab11" bgcolor="#eeeeee" align="center">매입매출구분</td>
					<td class="tab21" style="width:230px"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gclx_taxiodiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:3px;font-size:12px;width:100px;">
							<param name=CBData					value="^전체,A^매입,B^매출">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;
					</td>
					<td width="90" class="tab11" bgcolor="#eeeeee" align="center" width="110">증빙구분</td>
					<td class="tab22"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gclx_documcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:3px;font-size:12px;width:120px;">
						 <param name=ComboDataID    value="gcds_documcd">
							<param name=CBDataColumns	 value="CDCODE,CDNAM">
							<param name=SearchColumn	 value=CDNAM>
							<param name=Sort			     value=false>
							<param name=ListExprFormat value="CDNAM^0^120">								
							<param name=BindColumn		 value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
						&nbsp;&nbsp;&nbsp;&nbsp;
						<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;left:65px;top:2px;cursor:hand" onclick="ln_Query()"></nobr>
						</td>
				</tr>
				
				<tr>
					<td width="90" class="tab11" bgcolor="#eeeeee" align="center">거래처</td>
					<td class="tab21" style="width:230px"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:5px" onkeydown="if(event.keyCode==13) ln_Query();">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-3px;top:0px" align=center onclick="ln_Popup();">&nbsp;
						<comment id="__NSID__"><object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:0px;top:5px" onkeydown="if(event.keyCode==13) ln_Query();">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					<td width="90" class="tab11" bgcolor="#eeeeee" align="center" width="110">접수일자</td>
					<td class="tab22"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_taxdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:3px; width:68px; height:20px;" class="txtbox" onkeydown="if(event.keyCode==13) ln_Query();">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM/DD">
							<param name=PromptChar			value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxdat_fr', 'Text')" style="position:relative;width:20px;left:3px;top:0px;cursor:hand;">
            			&nbsp;~&nbsp;&nbsp;
						<comment id="__NSID__"><object  id=gcem_taxdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:3px; width:68px; height:20px;" class="txtbox" onkeydown="if(event.keyCode==13) ln_Query();">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM/DD">
							<param name=PromptChar		value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxdat_to', 'Text')" style="position:relative;width:20px;left:3px;top:0px;cursor:hand;">
						
						</td>
				</tr>
				<tr>
					<td width="90" class="tab12" bgcolor="#eeeeee" align="center">적요</td>
					<td class="tab23" style="width:650px" colspan=3>&nbsp;
						<comment id="__NSID__"><object  id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:650px;height:20px;position:relative;left:0px;top:3px" onkeydown="if(event.keyCode==13) ln_Query();">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
			<tr>
			<td  class="tab21" colspan="3">
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:798;height:300px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
					<PARAM NAME="DataID"			VALUE="gcds_code01">
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Indwidth"		VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<param name="ColSizing"   value="true">
					<param name="sortview"    value=left>
					<PARAM NAME="Format"			VALUE="  
					  <C>ID=GUBUN,		 Name=구분,	         width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false</C>
						<C>ID=CDNAM,		 Name=종류,	         width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false</C>
						<C>ID=TAXNBRS,	 Name=접수번호,	     width=72,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true, mask='XXXXXX-XXXX'</C>
						<C>ID=TAXDAT,		 Name=접수일자,		   width=72,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true, mask='XXXX/XX/XX'</C>
						<C>ID=VENDNM,		 Name=거래처명,	     width=115,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true </C>
						<C>ID=REMARK,		 Name=적요,	         width=180, HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left</C>
						<C>ID=TAXSUM,	   Name=공급가액,	     width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sort = true</C>
						<C>ID=TAXVATAMT, Name=부가세,	       width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sort = true</C>
						<C>ID=SUMS,	     Name=합계,	         width=82,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sort = true</C>
						<C>ID=DTI_STATUS, Name='상태'		  ,width=65, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='S:매출저장,A:매입저장,V:역발행요청,I:수신미승인,C:수신승인,M:발행취소요청(공급받는자),N:발행취소요청(공급자),R:수신거부,O:취소완료,T:역발행거부,W:역발행요청 취소'</C>
					">

				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
		<tr>
			<td>
				<fieldset id=ft_div1 style="width:800;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 