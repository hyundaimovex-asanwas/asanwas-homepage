<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 고객 사진 확인
 * 프로그램ID 	: RV280I
 * J  S  P		: rv280i
 * 서 블 릿		: Rv280i
 * 작 성 자		: 심동현
 * 작 성 일		: 2008-07-25
 * 기능정의		: 고객등록 
 * [ 수정일자 ][수정자] 내용
 * [2008-08-12][심동현] 대리점용 사진확인 메뉴 완성
 * [2008-11-28][심동현] 색상 조정
 *	1. 적합(기본값)		검정
 *	2. 부적합 값		빨강
 *	3. 덮어쓰기한 것.	초록
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	String tree_idx = request.getParameter("idx");	//메뉴id

	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
   	String firstday = m_today.format(date.getTime());	
%>


<%
	String basePath =  request.getServerName();

    //대리점 구분
    HDCookieManager cookie = new HDCookieManager(request, response);
/*    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);*/
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

    <script language=javascript src="<%=dirPath%>/Sales/common/js/rv411i.js"></script>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
	<script language="javascript">
	    var v_job = "";
		var v_btn_auth = "S";	//메뉴 내 권한 = select (기본값)
		
		get_cookdata();
		
	/* 페이지로딩 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit(); 

		//메뉴 내 수정 권한: 2008-11-10 BY 심동현 (+GetCookie("vusrid")+)
		ds_btnAuth.DataId = "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>BtnAuth?proType=S&dsType=1&userid=2030003&tree_idx="+tree_idx;
		ds_btnAuth.Reset();	//
	}
	 
	// 페이지 초기화 : 기본 코드정보를 얻어온다
	function fnInit(){
        v_job = "H";
		ee_depart_date.Text='<%=firstday%>';	
		
		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드

        ds_okYN.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RV033&s_Item1=Y";
        ds_okYN.Reset();	//적합여부

		ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_Item1=Y";
		ds_status.Reset();	//예약상태
	}

	// 조회
	function fnSelect() {
        v_job = "S";
	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
		          + ",sJobsel=" 	+ sJobsel.value
                  + ",sSalDamSid=" 	+ sSalDamSid.value
		          + ",sSaup_sid="	+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
		          + ",sDep_date=" 	+ ee_depart_date.Text
		          + ",sGoods_sid="	+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
                  + ",sClientSid="	+ ih_ClientSid.value
		          + ",sStatus="		+ lc_status.ValueOfIndex("detail", lc_status.Index)                  
		          + ",sOkYN=" 		+ lc_okYN.ValueOfIndex("detail", lc_okYN.Index);


        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv280I",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
	}


	// 검색조건 대리점  팝업 
    function fnSelectClientPopup(dirPath) {
        
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        arrResult = fnClientPop(dirPath,'');
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            it_ClientNm.value = arrParam[1];
            ih_ClientSid.value = arrParam[0];
        } else {
          it_ClientNm.value = "";
          ih_ClientSid.value = "";
        }               
    }   	
	//상품조회
	function fnSelectGoodsLC() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
            + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			+ ",sDepartDate=" + ee_depart_date.Text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_GOODS_DS=ds_goods)",
            param);
        tr_post(tr2);
	};
	
	//적합체크했을때.
	function chkOK(num){
		if(v_btn_auth=="S"){		//Select 권한
			alert("현재 사용자는 수정 권한이 없습니다.");
		}else if("U"==v_btn_auth){	//Update 권한
			if(getObjectFirst("nameColor"+num).style.color=="black"){
				getObjectFirst("nameColor"+num).style.color="red";
			}else{
				getObjectFirst("nameColor"+num).style.color="black";
			}
	        window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
				+ ",sCustSid=" + ds1.namevalue(num, "CUST_SID");
	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv280I",
	            "JSP(I:DS1=ds1)",
	            param);
	        tr_post(tr1);
		}
	};
	
	
	//2008-09-03 사진 업로드 컴포넌트 관련 신규 함수 ------------------------------------------
	function fnUploadPop(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/bsfoto_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}
	//2008-09-03 사진 업로드 컴포넌트 관련 신규 함수 ------------------------------------------	


	//영업담당자 팝업
	function fnPopup4() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sSalDamSid.value = arrParam[0];
				sSalDamCd.value = arrParam[1];
				sSalDamNm.value = arrParam[2];
			} else {
		    	sSalDamSid.value = 0;
				sSalDamCd.value = '';
				sSalDamNm.value = '';
			}
	}

	</script>
	
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language="javascript" for="gcip_file" event=OnClick()>
	    if (fn_trim(gcip_file.value)!="") {
	    	txt_file.value = gcip_file.value;
	    	photo.src = gcip_file.value;
	    }
	</script>
	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
	<script language="javascript" for="tr1" event="OnSuccess()">
	</script>
	
	<script language="javascript" for="tr1" event="OnFail()">
	</script>
	
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
		fnSelectGoodsLC();
	</script>

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectGoodsLC();//상품 재검색
	</script>	

	<script language=JavaScript for=ee_depart_date event=OnKillFocus()> <!-- 출발일자 -->
		fnSelectGoodsLC();			
	</script>
	
	<script language=JavaScript for=ds1 event=OnLoadCompleted(rowcnt)>  <!-- 메인DS -->
		// 객실배정과 다른 점
		//	객실 평면도는 고정되어 있어서 상태값에 따라 값을 수정해주면 되었지만.
		//	사진 확인 화면은 인원수에 따라 테이블을 그려줘야 함.. innerHTML을 왕창!. 훗..;
		if(rowcnt==0){
			alert("조회 결과가 없습니다.");
		}else{		
			var i = 0 ;
			var fontColor = "black";
			var contents =  "";
				contents +="<table>";
				contents +="  <tr>";
			
			for (i = 1 ; i <= ds1.countrow; i++) {
				if(ds1.namevalue(i, "REGI_YN")=="N"){
					fontColor="red";						// 부적합
				}else if(ds1.namevalue(i, "REGI_YN")=="R"){
					fontColor="green";						// re uploaded
				}else{
					fontColor="black";						// ok
				};
	
				contents +="	<td>																								  ";
				contents +="		<table border=0 cellpadding=0 cellspacing=1 bgcolor=#666666>                                      ";
				contents +="		  <tr align=center>                                                                               ";
//				contents +="			<td width=99 height=125 rowspan=6 bgcolor=#ffffff><img id=photo src=http://erp.hdasan.com/services/Sales/file/photo/cust/"+ds1.namevalue(i, "MANAGE_NO")+".JPG border=0 width=99 height=125></td>";
				contents +="			<td width=99 height=125 rowspan=6 bgcolor=#ffffff><img id=photo src=http://203.242.32.42/photos/cust/"+ds1.namevalue(i,"PIC_ADDR")+".JPG border=0 width=99 height=125></td>";				
				contents +="			<td width=180 bgcolor=#ffffff style='cursor:hand;color:"+ fontColor +"' id=nameColor"+i +" onclick='chkOK("+ i +")'>"+ ds1.namevalue(i, "CUST_NM") +"</td>";
				contents +="		  </tr>                                                                                           ";
				contents +="		  <tr align=center>                                                                               ";
				contents +="			<td bgcolor=#ffffff>"+ ds1.namevalue(i, "BIRTH_DAY") +"</td>                                  ";
				contents +="		  </tr>                                                                                           ";
				contents +="		  <tr align=center>                                                                               ";
				contents +="			<td bgcolor=#ffffff>"+ ds1.namevalue(i, "COMPANY") +"</td>                                     ";
				contents +="		  </tr>                                                                                           ";
				contents +="		  <tr align=center>                                                                               ";
				contents +="			<td bgcolor=#ffffff>"+ ds1.namevalue(i, "CLIENT_NM") +"</td>                                  ";
				contents +="		  </tr>                                                                                           ";
				contents +="		  <tr align=center>                                                                               ";
				contents +="			<td bgcolor=#ffffff>"+ ds1.namevalue(i, "ACCEPT_NO") +"</td>                                  ";
				contents +="		  </tr>                                                                                           ";
				contents +="		  <tr align=center>                                                                               ";
				contents +="			<td bgcolor=#ffffff>"+ ds1.namevalue(i, "TOUR_NO") +" ("+ ds1.namevalue(i, "STATUS_CD") +")</td>                                    ";
				contents +="		  </tr>                                                                                           ";
				contents +="		</table>                                                                                          ";
				contents +="	</td>                                                                                                 ";
				if(i%3==0){//3열 끝나면 행바꿈
					contents +="  </tr>    ";
					contents +="  <tr>    ";
				};
			};
			contents +="  </tr>                                                                                                       ";
		    contents +="</table>                                                                                                      ";
	
			getObjectFirst("picTable").innerHTML = contents;			
		};
	</script>	

	<script language=JavaScript for=ds_btnAuth event=OnLoadCompleted(rowcnt)>  <!-- 버튼권한DS -->
		if(rowcnt==0){
			v_btn_auth = "S";
		}else{		
			v_btn_auth = ds_btnAuth.NameValue(1, "BTN_AUTH");
		}

	</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>

	<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
		<param name="SyncLoad" 	value="true">
	</object>
	
	<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 상품 -->
		<param name="SyncLoad" 	value="false">
	</object>

	<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 상품 -->
		<param name="SyncLoad" 	value="false">
	</object>
	
	<object id=ds_okYN classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 적합여부 -->
		<param name="SyncLoad" 	value="false">
	</object>
	
	<object id=ds_btnAuth classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<param name="SyncLoad" 	value="false">
	</object>
	
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>

<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr height="50px">
		<td>
			<table  border="0" cellpadding="0" cellspacing="0"  width="845px">
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" width=845px>
						  <tr>
							<td>
							  <table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width='539px'>
								<tr height="30px">
					              <td align=left class="text" width="60px">고객구분</td>
					              <td align="left" bgcolor="#ffffff">&nbsp;
			    					<select name="sJobsel"> 
				    					 <option value="0" SELECTED>전체</option>
										 <option value="1">관광객</option>
										 <option value="2">사업자</option>
										 <option value="3">관광도우미</option>
									</select>
								  </td>   			
            					  <td align=center width=65 class="text">영업담당자</td>
                                  <td align=left bgcolor="#ffffff">&nbsp;<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
									<input id="sSalDamSid" type="hidden" value="0">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="영업담당자를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
									<input id="sSalDamNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;" maxlength="50" onBlur="" readOnly>
								  </td>
								</tr>
							  </table>
							</td>
							<td align='right'>
								<img src="<%=dirPath%>/Sales/images/upload.gif" style="cursor:hand" align=absmiddle onclick="fnUploadPop()">&nbsp;&nbsp;
								<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
							</td>
						  </tr>
						</table>
					</td>
				</tr>
				<tr height="10px">
					<td ></td>
				</tr>
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
							<tr>
							  <td align=center class="text" width="40">지역</td>
		                      <td align=left bgcolor="#ffffff">&nbsp;																										
								<%=HDConstant.COMMENT_START%>
		                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
									<param name=ComboDataID		value=ds_saup>
									<param name=BindColumn      value="saup_sid">
		                            <param name=BindColVal      value="saup_sid">
									<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
									<param name=ListExprFormat  value="saup_nm^0^60">
								</object>
								<%=HDConstant.COMMENT_END%>
							  </td>	
							  <td align=center class="text"  width="55">출발일자</td>
		                      <td align=left bgcolor="#ffffff">&nbsp;																							
								<%=HDConstant.COMMENT_START%>
								<object id=ee_depart_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=80 align=center class="textbox" style= "width:65px; height:17px;">			
									<param name=Text 				value="">
									<param name=Alignment 			value=1>
									<param name=Format 				value="0000-00-00">
									<param name=Cursor	 			value="iBeam">
									<param name=Border	 			value="false">		
									<param name=InheritColor      	value="true">																																																				
									<param name=ReadOnly  			value="false">
									<param name=SelectAll  			value="true">
									<param name=SelectAllOnClick  	value="false">																					
								</object>&nbsp;
								<%=HDConstant.COMMENT_END%>
						 	  </td>
							  <td align=center class="text" width="40">상품</td>
							  <td align=left bgcolor="#ffffff" valign="middle">&nbsp;<%=HDConstant.COMMENT_START%>
		                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
									<param name=ComboDataID		value=ds_goods>
									<param name=BindColumn      value="goods_sid">
		                            <param name=BindColVal      value="goods_sid">
									<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
									<param name=ListExprFormat  value="goods_nm^0^100"></object>
								<%=HDConstant.COMMENT_END%>&nbsp;	
							  </td>

								<td align="center" width="55px" height="30px" class="text" >대리점</td>								
								<td align="left"  bgcolor="#ffffff">&nbsp;
		                            <input type="text" name='it_ClientNm' id='it_ClientNm' value='' size='10' readonly='readonly'  class='textbox'>
		                            <input type="hidden" name='ih_ClientSid' id='ih_ClientSid' value=''>
		                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
								</td>
								<td align=left class="text" width="55">예약상태</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=lc_status classid='clsid:60109D65-70C0-425C-B3A4-4CB001513C69' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/LuxeCombo.cab#version=1,1,1,63' height=200 width=70 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_status>
                                        <param name=ListExprFormat  value="detail_nm^0^70">
                                    </object><%=HDConstant.COMMENT_END%>
                                </td>
								<td align="center" width="55px"  class="text">적합여부</td>
								<td align="center" bgcolor=#ffffff><%=HDConstant.COMMENT_START%>
		                            <object id=lc_okYN classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=80 width=60 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_okYN>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^60">
									</object><%=HDConstant.COMMENT_END%>	
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
	<tr height="25px">
		<td>※ 고객 사진을 동시에 다운받아 처리하므로 화면 표시에 시간이 조금 걸립니다. 기다려주세요~<br>
		　 성명이 붉게 표시된 고객들의 사진은 교체해 주세요.</br>
		※ 최근 3개월 이내의 탈모, 정면 증명사진이 아니면 벌금이 부과되거나 출경이 불가능할 수 있습니다.
		</td>
	</tr>
	<tr>
		<td id=picTable><br> <!-- 사진확인용 테이블 -->
		</td>
	</tr>
</table>						

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

