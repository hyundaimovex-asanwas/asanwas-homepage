<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	물류관리 - 전략물자신청관리
+ 프로그램 ID	: TR00604.HTML
+ 기 능 정 의	: 조회,저장,삭제
+ 작   성  자 : 이민정
+ 작성일자 :
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML 시작-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
		get_cookdata();
		
		var gs_userid = gusrid;
		
		var gs_ordno = null ; 
		var ls_start = "true" ; 
		
		var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
		var gs_date1 = gcurdate.substring(2,4) + gcurdate.substring(5,7);
		var gs_date2 = gcurdate.substring(0,4);

		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			ln_Start();
			
			window.status="완료";

		}


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start() {

	gcem_appl_dt.text='20060301';
	gcem_etd_dt.text=gs_date;

  //프로젝트구분[검색]
	gcds_line_part_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?NOH=Y&v_str1=0002"; 
	gcds_line_part_fr.Reset();

	
	//프로젝트구분
	gcds_line_part.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
	gcds_line_part.Reset();

	gclx_item_div_fr.index = 0 ; 

}
 

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  var str1 = gclx_line_part_fr.BindColVal;           //프로젝트
	var str2 = gclx_item_div_fr.BindColVal;            //물품분류
	var str3 = txt_item_nm_fr.value;                   //품명
	

 
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00604_s1?NOH=Y"
									 + "&v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;
									
	gcds_data.Reset();
	//prompt('',gcds_data.DataID) ; 
	gclx_item_div_fr.index = 0 ; 

	//ln_Enable(t);
	ln_Format(1);
	ls_start =  false;  
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	gcds_data.AddRow();
	//ln_Enable(t);
	gclx_line_part.index = 0 ;
	gclx_item_div.index = 0 ; 
	gcem_appl_dt.text=gs_date;
	gcem_etd_dt.text=gs_date;

	ln_Format(1);
	ls_start ='true' ; 
	
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
//alert(ls_start) ; 
	if (gcds_data.IsUpdated){
	//alert(ls_start + "ll" ) ;
	if(ln_Chk()){
		if(ls_start == 'true' ){ 
	//alert(ls_start) ; 	
			SEQ() ;  
			//alert(gs_ordno) ; 
		
		}
			//if(ln_Chk()){
		//prompt('',gcds_data.Text) ;
				if (confirm("저장하시겠습니까?")){	
					gctr_data.Action = g_servlet+"/Transfer.tr00604_t1?";
					gctr_data.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid+",gstr3=" + gs_ordno;		
					gctr_data.post();
					ls_start = false ; 
					gcds_data.reset();
					//ln_Query();
	
			}
		}
}
}

function SEQ(){

	var ls_yymm =  gs_date1 ; 
	//	var ls_yymm =  gcem_etd_dt.Text.substring(2,6) ; 
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetSeqNo?NOH=Y&gstr1=0005&gstr2=" + ls_yymm;  // 주문번호 Load
		gcds_data1.Reset();   
		gs_ordno = ls_yymm + 'O'+  gcds_data1.NameValue(1,"SEQ_NO")  ; 
		//alert("주문번호 : " + gs_ordno) ;
		txt_appl_no.value=gs_ordno;

}


/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	if (gcds_data.sysStatus(gcds_data.rowposition)=="1") gcds_data.undo(gcds_data.rowposition)
	else gcds_data.deleterow(gcds_data.rowposition);
	ln_Save();
}

/*function ln_Delete(){

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gcds_data.KeyValue = "tr00604_t2(I:USER=gcds_data)";
		gcds_data.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00604_t2";
		//gcds_data.post();
	
	}
}
*/
/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}


/******************************************************************************
	Description : 출력(공문)
******************************************************************************/
function ln_Print(){
	if (gcds_data.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {
			
		//gs_la=false;

		gcds_print.ClearData();
			
		var ls_temp = "CUDATE:STRING,APPL_NO:STRING,ITEM_SPC:STRING,ITEM_UNIT:STRING,AA:STRING,I_DIV:STRING,L_PART:STRING,"
				        + "ITEM_NM:STRING,ITEM_DIV:STRING,IMAGE:STRING,MANG_NM:STRING,REMARK:STRING,ITEM_QTY:DECIMAL,A_DT:STRING";
		gcds_print.SetDataHeader(ls_temp);
		
		
		for (i=1;i<=gcds_data.countrow;i++) {
			gcds_print.Addrow();
			
			gcds_print.namevalue(i,"CUDATE")=gs_date2;
			gcds_print.namevalue(i,"I_DIV")=gcds_data.namevalue(i,"I_DIV");
			gcds_print.namevalue(i,"ITEM_SPC")=gcds_data.namevalue(i,"ITEM_SPC");
			gcds_print.namevalue(i,"ITEM_UNIT")=gcds_data.namevalue(i,"ITEM_UNIT");
			gcds_print.namevalue(i,"ITEM_QTY")=gcds_data.namevalue(i,"ITEM_QTY");
			gcds_print.namevalue(i,"MANG_NM")=gcds_data.namevalue(i,"MANG_NM");
			gcds_print.namevalue(i,"REMARK")=gcds_data.namevalue(i,"REMARK");
			gcds_print.namevalue(i,"AA")=gcds_data.namevalue(i,"AA");
			gcds_print.namevalue(i,"L_PART")=gcds_data.namevalue(i,"L_PART");
			gcds_print.namevalue(i,"A_DT")=gcds_data.namevalue(i,"A_DT");
		
		}
		gcrp_print.preview();	

		//gs_la=true;
	}
}

/******************************************************************************
	Description : 출력(확인서)
******************************************************************************/
function ln_Print01(){
		
	var	row = gcds_data.rowposition;
	
	if (gcds_data.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {
	
		
		//gs_la=false;

		gcds_print01.ClearData();
			
		var ls_temp = "CUDATE:STRING,APPL_NO:STRING,ITEM_SPC:STRING,ITEM_UNIT:STRING,AA:STRING,I_DIV:STRING,L_PART:STRING,"
				        + "ITEM_NM:STRING,ITEM_DIV:STRING,IMAGE:STRING,MANG_NM:STRING,REMARK:STRING,ITEM_QTY:DECIMAL";
		gcds_print01.SetDataHeader(ls_temp);
		
		gcds_print.addrow();

		
		for (i=1;i<=gcds_data.countrow;i++) {
			gcds_print01.Addrow();
			
			gcds_print01.namevalue(i,"CUDATE")=gs_date2;
			gcds_print01.namevalue(i,"I_DIV")=gcds_data.namevalue(row,"I_DIV");
			gcds_print01.namevalue(i,"ITEM_SPC")=gcds_data.namevalue(row,"ITEM_SPC");
			gcds_print01.namevalue(i,"ITEM_UNIT")=gcds_data.namevalue(row,"ITEM_UNIT");
			gcds_print01.namevalue(i,"ITEM_QTY")=gcds_data.namevalue(row,"ITEM_QTY");
			gcds_print01.namevalue(i,"MANG_NM")=gcds_data.namevalue(row,"MANG_NM");
			gcds_print01.namevalue(i,"REMARK")=gcds_data.namevalue(row,"REMARK");
			gcds_print01.namevalue(i,"AA")=gcds_data.namevalue(row,"AA");


			gcds_print01.namevalue(i,"APPL_NO")=gcds_data.namevalue(row,"APPL_NO");
			gcds_print01.namevalue(i,"ITEM_NM")=gcds_data.namevalue(row,"ITEM_NM");
			gcds_print01.namevalue(i,"ITEM_DIV")=gcds_data.namevalue(row,"ITEM_DIV");
			
			gcds_print01.namevalue(i,"IMAGE")=gcds_data.namevalue(i,"IMAGE");
			gcds_print01.namevalue(i,"P_CMPY")=gcds_data.namevalue(i,"P_CMPY");
			gcds_print01.namevalue(i,"L_PART")=gcds_data.namevalue(row,"L_PART");
			
		}

		gcrp_print01.preview();	
		
	}
}
/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 입력체크 
******************************************************************************/
function ln_Chk(){

		//필수항목체크
		if (fn_trim(gclx_line_part.BindColVal)=="" ){
			alert("프로젝트구분을 선택하십시요.");
			gclx_line_part.focus();
			return false; 
		}
		if (fn_trim(gcem_appl_dt.Text)=="" ){
			alert("신청일자를 입력하십시요.");
			gcem_appl_dt.focus();
			return false; 
		}

	return true; 
}

/******************************************************************************
	Description : 페이지 사용유무
******************************************************************************/
function ln_Format(e){
	if (gcds_data.sysStatus(e)=="1") {	//등록

		//txt_chargecode.disabled	= false;
		//gclx_pack_type.index = 1;

	} else {
		
		//txt_chargecode.disabled	= true;
	}
}

</script>

<script language=JavaScript for=gcgd_disp event=OnClick(row,colid)>
	ls_start = 'false' ;
	gs_ordno = gcds_data.NameValue(gcds_data.Rowposition,"APPL_NO") ; 
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 프로젝트구분[검색] -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_line_part_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 프로젝트구분  -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_line_part classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_print01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00604_t1">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00604_t1(I:USER=gcds_data)">
</OBJECT><%=HDConstant.COMMENT_END%>  
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
	ft_cnt.innerText = "조회건수 : 총 ( " + row + " ) 건";
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data" event="onRowPoschanged(row)">
	if (gcds_data.sysStatus(row)=="1") txt_appl_no.readOnly = true;
	//else txt_chargecode.readOnly = true;
</script>

 <script language=JavaScript for=gcem_unit_price event=onKeyUp(kcode,scode)>
		//alert("Key : " + kcode);
		var ls_amt = gcem_item_qty.Text ;        //수량
		var ls_ama = gcem_unit_price.Text ;      //단가

		gcem_item_price.Text = ls_amt*1 * ls_ama*1 ;
		
</script> 
	
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- 프로젝트구분[검색] -->
<script language="javascript" for="gcds_line_part_fr" event="onloadCompleted(row,colid)">
	gcds_line_part_fr.InsertRow(1);
	gcds_line_part_fr.NameValue(1,"MINORCD")="";
	gcds_line_part_fr.NameValue(1,"MINORNM")="전체";
	gclx_line_part_fr.index=0;
</script>

<!-- 프로젝트구분 -->
<script language="javascript" for="gcds_line_part" event="onloadCompleted(row,colid)">
	/*gcds_pack_type.InsertRow(1);
	gcds_pack_type.NameValue(1,"MINORCD")="";
	gcds_pack_type.NameValue(1,"MINORNM")="";
	gclx_pack_type.index=0;*/
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	//ln_Query();
	// prompt('',gcds_data.DataID) ; 
	// gcds_data.reset();

</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/TR00604_head.gif"></td>
    <td width="685" align="right" background="../../common/img/com_t_bg.gif">
			<img src="../img/btn/btn_print1.gif"		 style="position:relative;top:2px;cursor:hand" onClick="ln_Print01()">
			<img src="../img/btn/btn_print2.gif"		 style="position:relative;top:2px;cursor:hand" onClick="ln_Print()">
			<img src="../../common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src="../../common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
			<img src="../../common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
	    <img src="../../common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
		</td>
  </tr>
	<tr><td height=2></td></tr>
	<tr>
		<td valign=top colspan=2>
      <table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;">
				<tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">프로젝트구분</td>
					<td class="tab21" style="width:200px;">&nbsp;
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_line_part_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:160px;">
								<param name=ComboDataID			value="gcds_line_part_fr">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value=MINORCD>
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td> 

	
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">물품분류</td>
					 <td class="tab21"> 
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_item_div_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
										style="position:relative;left:8px;top:1px;font-size:12px;width:100px;" >
											<param name=CBData			   value="''^전체,C^컴퓨터,E^일반물자">
											<param name=CBDataColumns		value="Code,Parm">
											<param name=SearchColumn		value="Parm">
											<param name=Sort						value="false">
											<param name=ListExprFormat	value="Parm^0^80">
											<param name=BindColumn			value="Code">
									</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">품명</td>
					 <td class="tab21"> 
						 <input type="text" class="txt11" id="txt_item_nm_fr" style="width:100px;height:18px;IME-MODE: active;"
					onkeydown="if(event.keyCode==13) ln_Query();">
					</td>
				</tr>
			</table>
		</td>
	</tr>
  <tr> 
    <td colspan="2"> 

      <table width="867" style="position:relative;left:0px;width:866px;top:3px;border:0" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td style="width:503">
						<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:503px; height:420px; border:1 solid #708090" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="BorderStyle" VALUE="0">
              <PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="sortview"		VALUE="left">
							<Param Name="Editable"    VALUE="false"> 
						  <PARAM NAME="Format"			VALUE=" 
								<C> Name='신청번호'			  ID='APPL_NO' 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center</C>
								<C> Name='신청물품순번'	  ID='ITEM_SEQ'  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right,
								</C> 
								<C> Name='PROJECT'		    ID='LINE_PART'	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left, 
								Editstyle='lookup', Data='gcds_line_part:minorcd:minornm'</C>
								<C> Name='물품분류'	      ID='ITEM_DIV' 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left, 
								Value = {Decode(ITEM_DIV,'C','컴퓨터','E','일반물자')}</C>
								<C> Name='품명'			      ID='ITEM_NM'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left
								</C> 
								<C> Name='모델명'	        ID='MODEL_NM'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left
								</C> 
								<C> Name='규격'	          ID='ITEM_SPC'		  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left
								</C>
								<C> Name='일련번호'	      ID='SERIAL_NO'  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left
								</C>
							">
            </OBJECT><%=HDConstant.COMMENT_END%>
						<fieldset style="width:505px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
					<td style="">
						<table border="0" cellpadding="0" cellspacing="0" style="width:370px; border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<tr>
								<td class="tab21" style="width:90px;height:25px;" bgcolor="#eeeeee">&nbsp;신청번호</td>
								<td class="tab21" colspan="3"><input type="text" class="txt11" id="txt_appl_no" style="width:100px;height:20px;" readOnly></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;신청물품순번</td>
								<td class="tab21" colspan="3" > 
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_item_seq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=0>
                     <param name=Enable							value=true>
										 <param name=MaxLength          value=4>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;PROJECT 구분</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_line_part classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											style="position:relative;left:8px;top:1px;font-size:12px;width:160px;">
												<param name=ComboDataID			value="gcds_line_part">
												<param name=CBDataColumns		value="MINORCD, MINORNM">
												<param name=SearchColumn		value=MINORNM>
												<param name=Sort						value=false>
												<param name=ListExprFormat	value="MINORNM^0^160">
												<param name=BindColumn			value=MINORCD>
										</OBJECT><%=HDConstant.COMMENT_END%>
    						</td>
							</tr>
							
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;물품분류</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_item_div classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
										style="position:relative;left:8px;top:1px;font-size:12px;width:100px;" >
											<param name=CBData			   value="C^컴퓨터,E^일반물자">
											<param name=CBDataColumns		value="Code,Parm">
											<param name=SearchColumn		value="Parm">
											<param name=Sort						value="false">
											<param name=ListExprFormat	value="Parm^0^80">
											<param name=BindColumn			value="Code">
									</OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;품명</td>
								<td class="tab21" colspan="3">
								<input type="text" class="txt11" id="txt_item_nm" style="width:260px;height:20px;IME-MODE: active;" maxlength="50">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_rqst_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80" >
										 <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
										
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
								</tr>
						 	<!-- </tr>
							<tr>  -->
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;HS CODE</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_hs_code" style="width:100px;height:20px;IME-MODE: active;" maxlength="10"
									onBlur="bytelength(this,this.value,10);">
								<!-- 	<%=HDConstant.COMMENT_START%><OBJECT id=gcem_itemrqst_price2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
									</OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;모델명</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_model_nm" style="width:260px;height:20px;IME-MODE: active;" maxlength="50"
									onBlur="bytelength(this,this.value,50);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;규격</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_item_spc" style="width:260px;height:20px;IME-MODE: active;" maxlength="50"
									onBlur="bytelength(this,this.value,50);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;일련번호</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_serial_no" style="width:260px;height:20px;IME-MODE: active;" maxlength="50"
									onBlur="bytelength(this,this.value,50);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;CPU</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_cpu_spc" style="width:260px;height:20px;IME-MODE: active;" maxlength="50"
									onBlur="bytelength(this,this.value,50);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;하드</td>
								<td class="tab21" >
									<input type="text" class="txt11" id="txt_hard_spc" style="width:90px;height:20px;IME-MODE: active;" maxlength="20"
									onBlur="bytelength(this,this.value,20);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							<!-- </tr>
							<tr> -->
								<td class="tab21" style="width:70px;height:25px;" bgcolor="#eeeeee">&nbsp;램</td>
								<td class="tab21" >
									<input type="text" class="txt11" id="txt_ram_spc" style="width:90px;height:20px;IME-MODE: active;" maxlength="20"
									onBlur="bytelength(this,this.value,20);">
								<!-- 	<%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;단위</td>
								<td class="tab21" >
									<input type="text" class="txt11" id="txt_item_unit" style="width:90px;height:20px;IME-MODE: active;" maxlength="20"
									onBlur="bytelength(this,this.value,20);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
						<!-- 	</tr>
							<tr> -->
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;수량</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_item_qty classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
										 <param name=MaxLength          value=13>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;단가</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_unit_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
 									   <param name=MaxLength          value=13>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							<!-- </tr>
							<tr> -->
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;금액</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_item_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
										 <param name=MaxLength          value=13>
										
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;관리자</td>
								<td class="tab21" colspan="3">
									
								<input type="text" class="txt11" id="txt_mang_nm" style="width:260px;height:20px;IME-MODE: active;" maxlength="50"
								onBlur="bytelength(this,this.value,50);">
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;사용목적</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_use_pps" style="width:260px;height:20px;IME-MODE: active;" maxlength="100"
									onBlur="bytelength(this,this.value,100);">
								
								</td>
							</tr>

							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;신청일자</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_appl_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:3px;height:20;width:70" >
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
                  </OBJECT><%=HDConstant.COMMENT_END%>&nbsp;<img src="../img/btn_calendar.gif" style="position:relative; left:4px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_appl_dt', 'Text');"> 
									
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;반출일자</td>
								<td class="tab21">
									
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_etd_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:6px;top:3px;height:20;width:70">
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
                  </OBJECT><%=HDConstant.COMMENT_END%>&nbsp;<img src="../img/btn_calendar.gif" style="position:relative; left:6px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_etd_dt', 'Text');">
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;비고</td>
								<td class="tab21" colspan="3">
								<textarea id="txt_remark" class="txtbox"  style= "width:260px; height:23px; overflow:auto;position:relative;left:8px;IME-MODE: active" maxlength="100" onBlur="bytelength(this,this.value,100);"></textarea>
									
								</td>
							</tr>
							<tr>
					<td height="10px" style="border:1 solid 
					#708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;" >&nbsp;</td><!--밑에 비고칸-->
					 <td height="10px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan="3">&nbsp;</td>
				</tr>  
			</table>
		</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=APPL_NO      Ctrl=txt_appl_no       Param=value</C>
		<C>Col=ITEM_SEQ     Ctrl=gcem_item_seq     Param=Text</C>
		<C>Col=LINE_PART    Ctrl=gclx_line_part    Param=BindColVal</C>
		<C>Col=ITEM_DIV     Ctrl=gclx_item_div     Param=BindColVal</C>
		<C>Col=ITEM_NM      Ctrl=txt_item_nm       Param=Value</C>

		<C>Col=HS_CODE      Ctrl=txt_hs_code       Param=Value</C>
		<C>Col=MODEL_NM     Ctrl=txt_model_nm      Param=Value</C>
		<C>Col=ITEM_SPC     Ctrl=txt_item_spc      Param=Value</C>
		<C>Col=SERIAL_NO    Ctrl=txt_serial_no     Param=Value</C>
		<C>Col=CPU_SPC      Ctrl=txt_cpu_spc       Param=Value</C>

		<C>Col=HARD_SPC     Ctrl=txt_hard_spc      Param=Value</C>
		<C>Col=RAM_SPC      Ctrl=txt_ram_spc       Param=Value</C>
		<C>Col=ITEM_UNIT    Ctrl=txt_item_unit     Param=Value</C>
		<C>Col=ITEM_QTY     Ctrl=gcem_item_qty     Param=Text</C>
		<C>Col=UNIT_PRICE   Ctrl=gcem_unit_price   Param=Text</C>

		<C>Col=ITEM_PRICE   Ctrl=gcem_item_price   Param=Text</C>
		<C>Col=MANG_NM      Ctrl=txt_mang_nm       Param=Value</C>
		<C>Col=USE_PPS      Ctrl=txt_use_pps       Param=Value</C>
		<C>Col=APPL_DT      Ctrl=gcem_appl_dt      Param=Text</C>
		<C>Col=ETD_DT       Ctrl=gcem_etd_dt       Param=Text</C>

		<C>Col=REMARK       Ctrl=txt_remark        Param=Value</C>
	
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   출력
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print">
	<param NAME="DetailDataID"				VALUE="gcds_print">
	<PARAM NAME="PaperSize"						VALUE="A4">	
	<PARAM NAME="LandScape"					  VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format"							VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=2727 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=741 ,top=2612 ,right=1218 ,bottom=2712</I>
	<I>id='../../common/img/new_attamp.jpg' ,left=1134 ,top=2207 ,right=1864 ,bottom=2503</I>
	<T>id='110-793 / 서울특별시 종로구 계동 140-2 현대빌딩 Tel (02)3669-3881, Fax (02)3669-3880' ,left=24 ,top=473 ,right=1959 ,bottom=539 ,face='HY견명조' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산주식회사' ,left=24 ,top=299 ,right=1959 ,bottom=418 ,face='HY견명조' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=560 ,right=1959 ,bottom=560 </L>
	<L> left=29 ,top=547 ,right=1959 ,bottom=547 </L>
	<T>id='현    아 :' ,left=45 ,top=574 ,right=319 ,bottom=640 ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CERTINO', left=680, top=574, right=875, bottom=640, align='left' ,mask='제 XXXX - XXXX 호', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='호' ,left=883 ,top=574 ,right=973 ,bottom=640 ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='통일부' ,left=335 ,top=653 ,right=609 ,bottom=719 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수    신 :' ,left=45 ,top=653 ,right=319 ,bottom=719 ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개성공단사업지원단 투자지원과' ,left=335 ,top=732 ,right=1110 ,bottom=798 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='참    조 :' ,left=45 ,top=732 ,right=319 ,bottom=798 ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제    목 :' ,left=45 ,top=814 ,right=319 ,bottom=880 ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대북한 물품 반출 승인 신청의 건' ,left=335 ,top=817 ,right=1110 ,bottom=883 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=917 ,right=1959 ,bottom=917 </L>
	<T>id='1. 귀부의 무궁한 발전을 기원합니다.' ,left=269 ,top=962 ,right=1255 ,bottom=1028 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='붙 임 :' ,left=113 ,top=1544 ,right=282 ,bottom=1610 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확인서 1부.' ,left=295 ,top=1544 ,right=570 ,bottom=1610 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전략물자 확인서 1부. 끝.' ,left=295 ,top=1628 ,right=1071 ,bottom=1694 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='민족화합의.새시대를.선도하는기업' ,left=24 ,top=227 ,right=1959 ,bottom=293 ,face='HY견명조' ,size=15 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=335, top=574, right=556, bottom=640, align='left' ,mask='제 XXXX - XXXX 호', face='HY견명조', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2. 당사가 승인 신청한 ' ,left=269 ,top=1057 ,right=833 ,bottom=1123 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='컴퓨터 1대의 반출승인신청과 관련하여 붙임과 같이 확인서를 첨부하오니 적기' ,left=111 ,top=1145 ,right=1914 ,bottom=1211 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='에 물품이 공급될 수 있도록 협조하여 주시기 바랍니다.' ,left=111 ,top=1232 ,right=1914 ,bottom=1298 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='-' ,left=585 ,top=574 ,right=675 ,bottom=640 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='A_DT', left=1545, top=574, right=1846, bottom=640, face='HY견명조', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='L_PART', left=838, top=1057, right=1097, bottom=1123, face='HY견명조', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='1단계 조성공사와 관련하여 사용될' ,left=1107 ,top=1057 ,right=1935 ,bottom=1123 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print01  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print">
	<param NAME="DetailDataID"				VALUE="gcds_print01">
	<PARAM NAME="PaperSize"						VALUE="A4">	
	<PARAM NAME="LandScape"					  VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format"							VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=2218 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=132 ,top=1213 ,right=1804 ,bottom=1417 ,border=true</X>
	<T>id='반출하고자 합니다. ' ,left=1176 ,top=777 ,right=1767 ,bottom=843 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1단계 조성공사와 관련하여 사용될 ' ,left=749 ,top=698 ,right=1577 ,bottom=764 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='L_PART', left=446, top=698, right=730, bottom=764, face='HY견명조', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AA', left=965, top=777, right=1173, bottom=843, face='HY견명조', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='대를 아래 목록과 같이 ' ,left=425 ,top=777 ,right=962 ,bottom=843 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='반출자재 용도 제한 확인' ,left=335 ,top=605 ,right=1110 ,bottom=671 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제     목 :' ,left=45 ,top=603 ,right=319 ,bottom=669 ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ITEM_QTY', left=272, top=777, right=414, bottom=843, face='HY견명조', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='I_DIV', left=1582, top=698, right=1777, bottom=764, face='HY견명조', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='당사는 ' ,left=269 ,top=698 ,right=438 ,bottom=764 ,align='left' ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확 인 서' ,left=24 ,top=140 ,right=1959 ,bottom=259 ,face='HY견명조' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=809 ,top=267 ,right=1163 ,bottom=267 </L>
	<C>id='I_DIV', left=140, top=1332, right=335, bottom=1406</C>
	<C>id='ITEM_SPC', left=348, top=1332, right=918, bottom=1406</C>
	<C>id='ITEM_UNIT', left=931, top=1332, right=1073, bottom=1406</C>
	<C>id='ITEM_QTY', left=1092, top=1332, right=1234, bottom=1406</C>
	<C>id='MANG_NM', left=1247, top=1332, right=1429, bottom=1406</C>
	<C>id='REMARK', left=1448, top=1332, right=1790, bottom=1406</C>
	<L> left=1081 ,top=1213 ,right=1081 ,bottom=1417 </L>
	<L> left=923 ,top=1213 ,right=923 ,bottom=1417 </L>
	<L> left=1437 ,top=1213 ,right=1437 ,bottom=1417 </L>
	<L> left=1239 ,top=1213 ,right=1239 ,bottom=1417 </L>
	<L> left=340 ,top=1213 ,right=340 ,bottom=1417 </L>
	<L> left=132 ,top=1322 ,right=1804 ,bottom=1322 </L>
	<T>id='규 격' ,left=348 ,top=1221 ,right=918 ,bottom=1314 ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='단위' ,left=931 ,top=1221 ,right=1073 ,bottom=1314 ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수량' ,left=1092 ,top=1221 ,right=1234 ,bottom=1314 ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관리자' ,left=1247 ,top=1221 ,right=1429 ,bottom=1314 ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1448 ,top=1221 ,right=1790 ,bottom=1314 ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='품 명' ,left=140 ,top=1221 ,right=335 ,bottom=1314 ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='- 아                래  -' ,left=24 ,top=1078 ,right=1959 ,bottom=1145 ,face='HY견명조' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='L_PART', left=599, top=1618, right=1015, bottom=1684, face='HY견명조', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='1단계 공단부지 조성간 업무진행' ,left=1023 ,top=1618 ,right=1785 ,bottom=1684 ,align='left' ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 관리자임을 알려드립니다.' ,left=396 ,top=2070 ,right=1782 ,bottom=2136 ,align='left' ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MANG_NM', left=113, top=2070, right=388, bottom=2136, face='HY견명조', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='아울러 반출되는 자재들에 대한 관리는 현지에서 근무중인 현대아산' ,left=113 ,top=1990 ,right=1785 ,bottom=2056 ,align='left' ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='타 용도로 사용하지 않을 것을 확인합니다.' ,left=113 ,top=1779 ,right=1785 ,bottom=1845 ,align='left' ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의 효율을 기하기 위하여 투입되는 것으로 본래의 용도 외의' ,left=113 ,top=1700 ,right=1785 ,bottom=1766 ,align='left' ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='I_DIV', left=182, top=1618, right=377, bottom=1684, face='HY견명조', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ITEM_QTY', left=382, top=1618, right=472, bottom=1684, face='HY견명조', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='대는 ' ,left=477 ,top=1618 ,right=593 ,bottom=1684 ,align='left' ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='위' ,left=113 ,top=1618 ,right=177 ,bottom=1684 ,align='left' ,face='HY견명조' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>



">
</OBJECT><%=HDConstant.COMMENT_END%>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

