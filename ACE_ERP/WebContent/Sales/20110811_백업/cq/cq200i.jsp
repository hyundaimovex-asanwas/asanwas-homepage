<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 관광시스템> 차량탑승
 * 프로그램ID 	: cq200i
 * J  S  P		: cq200i
 * 서 블 릿		: Cq200i
 * 기능정의		: 완전한 출입계획을 위해, 차량과 인원의 관계를 맺는 화면.
 * [ 수정일자 ][수정자] 내용
 * [2010-03-15][심동현] 신설. 출입인원의 차량 탑승 관리
 * [2010-03-19][심동현] 방향에 따른 출경/입경시 방향에 따른 파라미터 변경
 *		     음.. 어쩔까.. 입경시각, 상품도 있는 것들만 검색하는게 좋은가? 움..;;
 *		     		체류변경에서는 입경시각/상품은 무엇으로 변경될지 모르니 전부 보여줬으나
 *		     		여기는 다르다.. 있는 것들만 조회하는게 맞을 듯~!
 *
 *					※ 상품, 출입경시각 모두 trm220(상품관리)에 등록된 것을 불러오기로 
 *						기존 페이지들에 영향이 없도록 commonH.java에 신규 쿼리로 추가
 *						- 쿼리의 컬럼명이 출경,입경시 같아야 서로 luxcombo에서 호환가능 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
	
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());	
//   	firstday="20060805";
//   date.add(java.util.Calendar.DATE, +10);         
//   String endday = m_today.format(date.getTime()); 
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
	
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
		<script language="javascript">
         var v_job = "H";		
		 var div='';

		// 페이지로딩
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
	        v_job = "H";		
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");		//요약
			sDate.Text = '<%=firstday%>';	
			fnInit()
		} 
		 
		function fnInit() {
			div = 'init';
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드

	        ds_code1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ001&s_item1=Y";
	        ds_code1.Reset();	//출입방향

	        ds_code2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ004&s_item1=Y";
	        ds_code2.Reset();	//운전여부

		}



		// 차량정보 조회 (GR1)
		function fnSelect1() {
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                      + ",v_direction=" + lc_code1.ValueOfIndex("detail", lc_code1.Index)
                      + ",v_date=" + sDate.Text
                      + ",v_time=" + lc_time.ValueOfIndex("depart_time", lc_time.Index)
                      + ",v_goods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",v_accept_no=" + v_accept_no.Text        ;

			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq200I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}


					

		// 차량정보저장
		function fnApply1() {
			if (ds1.IsUpdated) {
				v_job = "I1";	//차량정보저장은 I1
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				          + ",sDate=" + sDate.Text;

				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq200I",
				    "JSP(I:DS1=ds1,O:RESULT=ds_result)",
				    param);
				tr_post(tr1);
			} else {
				alert("수정된 차량정보가 없습니다.");
			};
			
		}


		// 인원정보 조회 (GR2)
		function fnSelect2() {
			v_job = "S";	//select 일듯..
			var v_assign;
			if(sAssign_YN.checked){
				v_assign="Y";
			}else{
				v_assign="N";
			}
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                      + ",v_direction=" + lc_code1.ValueOfIndex("detail", lc_code1.Index)
                      + ",v_date=" + sDate.Text
                      + ",v_time=" + lc_time.ValueOfIndex("depart_time", lc_time.Index)
                      + ",v_goods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",v_class=" + lc_class.ValueOfIndex("class", lc_class.Index)
			          + ",v_team=" + lc_team.ValueOfIndex("teams", lc_team.Index)
			          + ",v_jobsel=" + sJobsel.value
			          + ",v_accept_no=" + v_accept_no.Text
			          + ",v_assign_YN=" + v_assign
			          + ",v_custnm=" + sCustNm.value;
				          
				          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq200I",
			    "JSP(O:DS2=ds2)",
			    param);
			tr_post(tr1);
		}



		// 인원정보 저장
		function fnApply2() {
            if (ds2.IsUpdated){		
	            v_job = "I2";	//객실 저장은 I2
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                      + ",v_date=" + sDate.Text;
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq200I",
				    "JSP(I:DS2=ds2,O:RESULT=ds_result)",
				    param);
				   
				tr_post(tr1);
			} else {
				alert("탑승한 고객이 없습니다.");
			};
		}	
		
		
		/*
		 *	취소 
		 */
		function fnCancel1() {
			ds1.undoall();
		} 

		function fnCancel2() {
			ds2.undoall();
		} 

		// 출경시간, 상품조회
		function fnSelectDs3() {
		    window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		     
	 		if(lc_code1.ValueOfIndex("detail", lc_code1.Index)=="AR"){
	 		
			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sArriveDate=" + sDate.Text
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_ARRIVE_TIME_DS=ds_time,O:S_GOODS_DS=ds_goods)",
			        v_param);		

	 		}else{
			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sDepartDate=" + sDate.Text
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_DEPART_TIME_DS_NEW=ds_time,O:S_GOODS_DS=ds_goods)",
			        v_param);		

	 		} ;

		        
		    tr_post(tr1);
		}

		
		// 반
		function fnClass() {
			if (div == 'init') {
				ln_TRSetting(tr3, 
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		            "JSP(O:DS6=ds_class)",
		            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate=<%=firstday%>,sSaupSid=1,sUpjang="+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid"));
		        tr_post(tr3);
			} else {
				ln_TRSetting(tr3, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:DS6=ds_class)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sDate.Text+",sSaupSid=1,sUpjang="+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid"));
	        	tr_post(tr3);
			}
		}

		
		// 조 	
		function fnTeam() {
			if (div == 'init') {
				ln_TRSetting(tr4, 
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		            "JSP(O:DS7=ds_team)",
		            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate=<%=firstday%>,sSaupSid=1,sUpjang="
		            		+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid") + ",sClass=" + lc_class.ValueOfIndex("class", lc_class.Index));
		        tr_post(tr4);
			} else {
				ln_TRSetting(tr4, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:DS7=ds_team)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sDate.Text+",sSaupSid=1,sUpjang="
	            			+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid") + ",sClass=" + lc_class.ValueOfIndex("class", lc_class.Index));
	        	tr_post(tr4);
			}
			div='';
		}	

		// 신청서 번호 조회
	    function fnAcceptNoPopup(){
	        v_cust_row = 0;
	        var arrResult   = new Array();
	        arrResult = fnAcceptNoPop("<%=dirPath%>");
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            getObjectFirst("v_accept_sid").value = arrParam[0];
	            getObjectFirst("v_accept_no").Text   = arrParam[1];
	        }
	    }


		// 빈 차량번호로 배정하기 -------------------------------------------------------------------------
		function eraseNO(){
			for (i = 0 ; i <= ds2.countrow; i++) {
				if (ds2.namevalue(i, "CHOICE")=="T") {
					ds2.namevalue(i, "CAR_RSV_SID")=  0;
					ds2.namevalue(i, "RIDE_CAR_NUM")= "";
					ds2.namevalue(i, "RIDE_CAR_NM")	= "";
				};
			};
		};



	// 차량호수 자동배정
	function fnAssign() {
        window.status="자동배정 중입니다. 잠시만 기다려 주십시오...";
		//RIDE_CAR_NUM	        
		ds1.undoall();
		for( k=1; k<=ds1.CountRow; k++ ) {
			ds1.namevalue(k,"RIDE_CAR_NUM") = k;	//위에서부터 걍 차례대로~
		}
        window.status="자동배정이 완료되었습니다.";		
	}




		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/

///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
//		이후 필요한 메세지 띄우기는 rm310i.jsp 포캐스팅 변경을 참고할 것..
		var msg='';
        if(v_job=="I1") {	//차량 정보 저장
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
//	        fnSelect1();
        }  else if(v_job == "I2") {	// 인원 정보 저장
	        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
	        fnSelect2();
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
        };
	</script>
	<script language=JavaScript for="tr1" event=OnFail()>
		alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	</script>



	<script language=JavaScript for=sDate event=OnKillFocus()>
		if ( div != 'init' ) {	//출입일자 포커스 이동 
			if ( sDate.Modified ) {
				div = 'init';
				fnSelectDs3();
			}
		}
	</script>
	<script language=JavaScript for= lc_saup event=OnSelChange()>
		if ( div != 'init' ) {	//지역
			div = 'init';
			fnSelectDs3();
		}
	</script>
	<script language=JavaScript for= lc_code1 event=OnSelChange()>
		if ( div != 'init' ) {	//방향
			div = 'init';
			fnSelectDs3();
		}
	</script>
	<script language=JavaScript for=lc_time event=OnSelChange()>
		if ( div != 'init' ) {	//출경시간
			div = 'init';
			fnClass();
		}
	</script>
    <script language=JavaScript for=lc_goods event=OnSelChange()>
        if ( div != 'init' ) {  //상품
            div = 'init';
            fnClass();
        }
    </script>
	<script language=JavaScript for=lc_class event=OnSelChange()>
		if ( div != 'init' ) {	//반
			div = 'init';
			fnTeam();// 조 호출
		}
	</script>

	<script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
		fnSelectDs3();
	</script>
	<script language=JavaScript for=ds_time event=OnLoadCompleted(rowcnt)> <!-- 시각 -->
		fnClass();
	</script>
	<script language=JavaScript for=ds_class event=OnLoadCompleted(rowcnt)> <!-- 반 -->
		fnTeam();
	</script>
	<script language=JavaScript  for=ds_team event="OnLoadCompleted(row)"> <!-- 조 -->
		div=''
	</script>	

	<!-- 차량그리드 클릭→ 선택된 고객이 차량에 탑승함20100319   -->
 	<script language=JavaScript for=gr1 event=OnClick(row,colid)>
 		if(colid=="RIDE_CAR_NUM"||colid=="RIDE_CAR_NM"){
			return;
 		}else{

			for (i = 0 ; i <= ds2.countrow; i++) {	//DS2(고객정보)에서 선택된 손님 찾아서
				if (ds2.namevalue(i, "CHOICE")=="T") {
					ds2.namevalue(i, "CAR_RSV_SID")=ds1.namevalue(row, "CAR_RSV_SID");
					ds2.namevalue(i, "RIDE_CAR_NUM")=ds1.namevalue(row, "RIDE_CAR_NUM");
					ds2.namevalue(i, "RIDE_CAR_NM")	=ds1.namevalue(row, "RIDE_CAR_NM");
				};
			};				
 		};
	</script>


	<script language=javascript for="gr2" event="OnClick(Row, Colid)">
	// 제목 선택할 때.. 전체 변경 가능한 이벤트
        if(Row==0){
            if(ds2.CountRow==0) return;

            if(Colid=="CHOICE"){
                for(var i=1; i<=ds2.CountRow; i++){
                    ds2.NameValue(i, Colid) = ds2.NameValue(1, Colid);
                }
            }
		}
	</script>


<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_time classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_code1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_class classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_team classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_code2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>


<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메세지 -->
    <param name="SyncLoad"  value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>



</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845' >
					<tr>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0' width='845px'>
								<tr>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/auto_assign.gif"  	style="cursor:hand"	align=absmiddle onclick="fnAssign()">
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect1()"> 		<!-- 조회 -->
										<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply1()"> 		<!-- 저장 -->
										<img src="<%=dirPath%>/Sales/images/cancel.gif"  	style="cursor:hand"	align=absmiddle onclick="fnCancel1()"> 		<!-- 취소 -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr height="5px">
			<td></td>
		</tr>
		
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td width="70px" height="25px" class="text">신청서번호</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>            
                                <param name=Format      value="00000000000000">
                                <param name=Alignment   value=1>
                                <param name=ClipMode    value=true>
                                <param name=Border      value=false>
                                <param name=SelectAll   value=true>
                                <param name=SelectAllOnClick      value=true>
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                        <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                        </td>
						<td align=left class="text" width="50">지역</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^70">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align=left class="text"  width="50">방향</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;
							<%=HDConstant.COMMENT_START%>
                            <object id=lc_code1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_code1>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail">
								<param name=EditExprFormat	value="%,%;detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
							</object>
							<%=HDConstant.COMMENT_END%>
	                    </TD>						
						<td align=left class="text"  width="60">출입일자</td>
	                    <td align=left bgcolor="#ffffff" width=150>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=sDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17  width=65 align=center class="textbox">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny  	value="false">																				
							</object>&nbsp;
                            <object id=lc_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_time>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail_nm">
								<param name=EditExprFormat	value="%,%;detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^50"></object>
							<%=HDConstant.COMMENT_END%>
						</td>																							
						<td align=left class="text" width="60">상품(출)</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
                            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=90 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=BindColumn      value="goods_sid">
                                <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10'>
			<td></td>
		</tr>
		<tr>
			<td align=center>
				<%=HDConstant.COMMENT_START%>
				<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width=845 height=190 border=1 style="display:;">
                    <param name="DataID"            value="ds1">
                    <param name="BorderStyle"       value="0">
                    <param name="ColSizing"         value="true">
                    <param name="editable"          value="True">
                    <param name="SuppressOption"    value="1">
                    <param name="Format"            value=" 
					<G> name='출입정보'
						<C> name='신청서번호'   ID='ACCEPT_NO'  	width=95 	align=center editlimit=15 edit=none show=true suppress=1 mask='XXXXX-XXXXXXXXX'</C>
						<C> name='상품명'    	ID='GOODS_NM'  		width=55 	align=left editlimit=15 edit=none show=true suppress=2 </C>
						<C> name='출발일자'    	ID='DEPART_DATE'    width=65 	align=CENTER	Edit=None suppress=3 mask='XXXX-XX-XX'</C>
						<C> name='시간'    		ID='DEPART_TIME'	width=35 	align=center	Edit=None suppress=4 mask='XX:XX'</C>
						<C> name='복귀일자'     ID='arrive_date' 	width=65 	align=CENTER	Edit=None suppress=5 mask='XXXX-XX-XX'</C>
						<C> name='시간'     	ID='arrive_time' 	width=35 	align=CENTER	Edit=None suppress=6 mask='XX:XX'</C>
					</G>
					<G> name='출입시 차량정보'
						<C> name='호수' 		ID='RIDE_CAR_NUM'	Width=35   Edit=true align=CENTER  show=true BgColor='#fefec0'</C>
						<C> name='명칭' 		ID='RIDE_CAR_NM'	Width=70   Edit=true align=CENTER  show=true BgColor='#fefec0'</C>
					</G>
                        <C> name='협력업체명'   ID='CLIENT_NM'		Width=100  Edit=none align=Left</C>
                        <C> name='코드'    		ID='CLIENT_CD'		Width=40   Edit=none align=Left </C>
						<C> name='차량예약ID' 		ID='CAR_RSV_SID'    Width=80   Edit=none align=Left show=false</C>
					<G> name='차량정보'
                        <C> name='등록번호'     ID='CAR_NO'             Width=80   Edit=none align=Left</C>
                        <C> name='차명'             ID='CAR_NM'             Width=80   Edit=none align=Left</C>
                        <C> name='차종'             ID='CAR_FORM'           Width=80   Edit=none align=Left</C>
                        <C> name='형식'             ID='CAR_TYPE'           Width=80   Edit=none align=Left</C>
                        <C> name='연식'             ID='CAR_YEAR'           Width=40   Edit=none align=Right</C>
                        <C> name='배기량(cc)'       ID='CAR_CC'             Width=80   Edit=none align=Right</C>
                        <C> name='승차인원'         ID='CAR_PERSONS'        Width=60   Edit=none align=Right</C>
                        <C> name='최대적재량(kg)'   ID='MAX_KG'             Width=100  Edit=none align=Right</C>
                        <C> name='차종1'            ID='CAR_TYPE_CD_NAME'   Width=80   Edit=none align=Left</C>
                        <C> name='차대번호'         ID='CAR_DNO'            Width=80   Edit=none align=Left</C>
					</G>
                    ">
				</object>
				<%=HDConstant.COMMENT_END%>

			</td>
		</tr>

		<tr>
			<td><BR>
				<table border=0 width=845 cellspacing=0 cellpadding=0>
					<tr>
						<td>				
							<%=HDConstant.COMMENT_START%>
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width=620 height=250 border=1 >
								<param name="DataID"        value="ds2">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="true">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<Param Name="UsingOneClick"   value="1">
								<param name=IndWidth" value="20">
								<param name="SuppressOption"    value="1">
	                            <param name="ViewSummary"       value="1">
								<param name="Format" 			value="
								   	<C> name='No'           ID='{STRING(CURROW)}'   Width=30    align=center</C>
								   	<C> name='선택\\√'   	ID='CHOICE'  width=30 	align=center editlimit=16 show=true EditStyle=CheckBox SUMTEXT=총</C>
									<C> name='신청서번호'   ID='ACCEPT_NO'  	width=95 	align=center editlimit=15 edit=none show=true suppress=1 mask='XXXXX-XXXXXXXXX' SUMTEXT=@CNT</C>
									<C> name='상품명'    	ID='GOODS_NM'  		width=55 	align=left editlimit=15 edit=none show=true suppress=2 SUMTEXT=명</C>
									<C> name='출발일자'    	ID='DEPART_DATE'    width=65 	align=CENTER	Edit=None suppress=3 mask='XXXX-XX-XX'</C>
									<C> name='시간'    		ID='DEPART_TIME'	width=35 	align=center	Edit=None suppress=4 mask='XX:XX'</C>
									<C> name='복귀일자'     ID='arrive_date' 	width=65 	align=CENTER	Edit=None suppress=5 mask='XXXX-XX-XX'</C>
									<C> name='시간'     	ID='arrive_time' 	width=35 	align=CENTER	Edit=None suppress=6 mask='XX:XX'</C>
									<C> name='성명'      	ID='CUST_NM'   		width=50 	align=left editlimit=30  edit=none show=true sort=true</C>
								<G> name='출입시 차량정보'
									<C> name='호수' 		ID='RIDE_CAR_NUM'	Width=30   Edit=none align=CENTER  show=true</C>
									<C> name='명칭' 		ID='RIDE_CAR_NM'	Width=70   Edit=none align=CENTER  show=true</C>
								</G>
									<C> name='동승' 		ID='DONGSEUNG'     	width=45   	align=center editlimit=10   editstyle=lookup  data='ds_code2:detail:detail_nm' edit=true show=true  BgColor='#fefec0' </C>
									<C> name='차량예약ID'	ID='CAR_RSV_SID'    width=80   	align=center editlimit=10  edit=TRUE show=false</C>
									<C> name='직장'   		ID='COMPANY_NM'  	width=80 	align=left editlimit=30  edit=none show=true</C>
									<C> name='직위'    		ID='POSITIONS'   	width=50 	align=left editlimit=30  edit=none show=true</C>
									<C> name='반'        	ID='CLASS'       	width=25 	align=right editlimit=2 	show=true</C>
									<C> name='조'        	ID='TEAMS'      	width=25  	align=right editlimit=2 	show=true</C>
									<C> name='주민 /\\여권' ID='MANAGE_NO'  	width=75  	align=left editlimit=20  edit=none show=true </C>
								">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align=right valign=top>
							<table  border=0 cellpadding='0' cellspacing='1' bgcolor=#666666>
								<tr>
									<td align=left class="text">반/조</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
			                            <object id=lc_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_class>
											<param name=BindColumn      value="class">
			                                <param name=BindColVal      value="class">
											<param name=EditExprFormat	value="%,%;class,class_nm">
											<param name=ListExprFormat  value="class_nm^0^70"></object>
			                            <object id=lc_team classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_team>
											<param name=BindColumn      value="teams">
			                                <param name=BindColVal      value="teams">
											<param name=EditExprFormat	value="%,%;teams,teams_nm">
											<param name=ListExprFormat  value="teams_nm^0^70"></object>
										<%=HDConstant.COMMENT_END%>
									</td>	
								</tr>
								<tr>
					              <td align=left class="text">고객구분</td>
					              <td align="left" bgcolor="#ffffff">&nbsp;
			    					<select name="sJobsel"> 
				    					 <option value="0" SELECTED>전체</option>
										 <option value="1">관광객</option>
										 <option value="2">사업자</option>
										 <option value="3">관광도우미</option>
									</select>
								  </td>
								</tr>
								<tr>
									<td align=left class="text">미배정</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<input type=checkbox name="sAssign_YN" id="sAssign_YN">　　　<img src="<%=dirPath%>/Sales/images/eraser.gif" style="cursor:hand"	align=absmiddle onclick="eraseNO()"></td>
								</tr>								
								<tr>
						            <td align=center class="text">성명</td>
						            <td align="left" bgcolor="#ffffff">&nbsp;
										<input type="text" name=sCustNm id=sCustNm value="" size=15 maxlength="15" class='textbox'>
									</td>
								</tr>								
								<tr height=24>
			                        <td align=center bgcolor="#ffffff" colspan=3><img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect2()"> 		<!-- 조회 -->
											<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply2()"> 		<!-- 상품의 숙박일자 기준으로 저장 -->
											<img src="<%=dirPath%>/Sales/images/cancel.gif"  	style="cursor:hand"	align=absmiddle onclick="fnCancel2()"> 		<!-- 취소 --></td>
								</tr>
							</table>
							<BR>
							<DIV ALIGN=LEFT>
							1.하단GRID에서 고객 선택 체크<BR>
							2.상단GRID에서 차량 클릭<BR>
							3.하단GRID에서 [동승]구분 선택<BR>
							4.우측 하단 [저장] 버튼 클릭</DIV>

						</td>
					</tr>
				</table>
			</td>
		</tr>

	</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

